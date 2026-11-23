#!/usr/bin/env bash
# Check a TidyTuesday submission for expected content.
# Run from anywhere; writes pr_comment.md to the current directory and appends
# check_status=success|failure to $GITHUB_OUTPUT (if set).
# Requires: bash, perl, curl, jq, yq, perl, and duckdb (for the CSV
# column summaries; skipped with a note if unavailable).

set -uo pipefail
export LC_ALL=C.UTF-8

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${script_dir}/lib.sh"

report_file="${REPORT_FILE:-pr_comment.md}"
status_file="${GITHUB_OUTPUT:-/dev/null}"
curated_root="${CURATED_ROOT:-data/curated}"

errors=()
infos=()

# Submission directory --------------------------------------------------------

submission_dirs=()
for d in "${curated_root}"/*/; do
  [[ -d ${d} ]] || continue
  d=${d%/}
  [[ ${d##*/} == template ]] && continue
  submission_dirs+=("${d}")
done

if [[ ${#submission_dirs[@]} -ne 1 ]]; then
  echo "PR must contain files in exactly one new directory under ${curated_root}/." >&2
  exit 1
fi
submission_dir=${submission_dirs[0]}
echo "Running checks on submission directory: ${submission_dir}"

# 1. Required files -----------------------------------------------------------
echo "1. Checking for required files..."
for f in meta.yaml intro.md; do
  [[ -f ${submission_dir}/${f} ]] || errors+=("Missing required file: ${f}")
done
mapfile -t cleaning_files < <(cleaning_scripts "${submission_dir}")
if ((${#cleaning_files[@]} == 0)); then
  errors+=("Missing required file: cleaning.R, cleaning.py, or cleaning.jl")
elif ((${#cleaning_files[@]} > 1)); then
  names=$(printf '%s, ' "${cleaning_files[@]##*/}")
  errors+=("Multiple cleaning scripts found (${names%, }); submit exactly one.")
fi
shopt -s nullglob
pngs=("${submission_dir}"/*.png)
if [[ ${#pngs[@]} -eq 0 ]]; then
  errors+=("Missing required file: At least one *.png image is required.")
fi

# 2. CSV files and data dictionaries ------------------------------------------
echo "2. Checking CSV files and data dictionaries..."

# Print a markdown summary table (variable, class, p_missing, n_unique) in the
# same layout as knitr::kable(format = "pipe"). Empty strings and "NA" are
# treated as missing, matching readr::read_csv() defaults.
summarize_csv() {
  local csv=$1 path_sql cols sql="" name type q rclass src
  path_sql=${csv//\'/\'\'}
  src="read_csv('${path_sql}', sample_size = -1, nullstr = ['', 'NA'])"
  cols=$(duckdb -list -separator $'\t' -noheader -c \
    "SELECT column_name, column_type FROM (DESCRIBE SELECT * FROM ${src})" | tr -d '\r') || return 1
  while IFS=$'\t' read -r name type; do
    [[ -z ${name} ]] && continue
    case "${type}" in
      VARCHAR) rclass=character ;;
      BOOLEAN) rclass=logical ;;
      DATE) rclass=Date ;;
      TIMESTAMP*) rclass=POSIXct ;;
      TIME*) rclass=hms ;;
      *) rclass=numeric ;;
    esac
    q=${name//\"/\"\"}
    [[ -n ${sql} ]] && sql+=" UNION ALL "
    sql+="SELECT '${name//\'/\'\'}' AS variable, '${rclass}' AS class, "
    sql+="printf('%.1f', round(100.0 * (count(*) - count(\"${q}\")) / nullif(count(*), 0), 1)) AS p_missing, "
    sql+="(count(DISTINCT \"${q}\") + CASE WHEN count(*) > count(\"${q}\") THEN 1 ELSE 0 END)::VARCHAR AS n_unique "
    sql+="FROM ${src}"
  done <<<"${cols}"
  [[ -z ${sql} ]] && return 1
  duckdb -list -separator $'\t' -noheader -c "${sql}" | awk -F'\t' '
    { v[NR] = $1; c[NR] = $2; p[NR] = $3; u[NR] = $4 }
    END {
      wv = length("variable"); wc = length("class"); wp = length("p_missing"); wu = length("n_unique")
      for (i = 1; i <= NR; i++) {
        if (length(v[i]) > wv) wv = length(v[i])
        if (length(c[i]) > wc) wc = length(c[i])
        if (length(p[i]) > wp) wp = length(p[i])
        if (length(u[i]) > wu) wu = length(u[i])
      }
      wv++; wc++; wp++; wu++
      printf "|%-*s|%-*s|%*s|%*s|\n", wv, "variable", wc, "class", wp, "p_missing", wu, "n_unique"
      printf "|:%s|:%s|%s:|%s:|\n", dash(wv - 1), dash(wc - 1), dash(wp - 1), dash(wu - 1)
      for (i = 1; i <= NR; i++)
        printf "|%-*s|%-*s|%*s|%*s|\n", wv, v[i], wc, c[i], wp, p[i], wu, u[i]
    }
    function dash(n,  s) { s = sprintf("%*s", n, ""); gsub(/ /, "-", s); return s }
  '
}

csv_files=("${submission_dir}"/*.csv)
if [[ ${#csv_files[@]} -eq 0 ]]; then
  errors+=("Missing required file: At least one *.csv data file is required.")
fi
have_duckdb=true
command -v duckdb >/dev/null 2>&1 || have_duckdb=false

for csv in "${csv_files[@]}"; do
  base=${csv##*/}
  md="${csv%.csv}.md"
  if [[ ! -f ${md} ]]; then
    errors+=("Missing data dictionary for ${base}. Expected ${md##*/}.")
    continue
  fi
  msg=$(utf8_error "${csv}")
  [[ -n ${msg} ]] && errors+=("${msg}")
  if ${have_duckdb}; then
    if table=$(summarize_csv "${csv}" 2>&1); then
      infos+=("${base}:"$'\n\n'"${table}")
    else
      infos+=("${base}:"$'\n\n'"Could not summarize columns.")
    fi
  fi
done

# 3. meta.yaml content and linked files ---------------------------------------
echo "3. Checking meta.yaml content..."
meta="${submission_dir}/meta.yaml"
if [[ -f ${meta} ]]; then
  if ! yq -e '.' "${meta}" >/dev/null 2>&1; then
    errors+=("meta.yaml could not be parsed as YAML.")
  else
    title=$(yq -r '.title // ""' "${meta}")
    if [[ -n ${title} ]]; then
      enc=$(jq -rn --arg t "${title}" '$t | @uri')
      infos+=("- [ ] [Manual controversy check](https://www.google.com/search?q=${enc}+controversy)")
    fi

    check_url "$(yq -r '.article.url // ""' "${meta}")" article
    check_url "$(yq -r '.data_source.url // ""' "${meta}")" data_source

    if [[ $(yq -r '.images | tag' "${meta}") != '!!seq' || $(yq -r '.images | length' "${meta}") -eq 0 ]]; then
      errors+=("'images' section is missing, empty, or malformed in meta.yaml.")
    else
      while IFS= read -r item; do
        file=$(jq -r 'if type == "object" then (.file // "") else "" end' <<<"${item}")
        alt=$(jq -r 'if type == "object" then (.alt // "") else "" end' <<<"${item}")
        img="${submission_dir}/${file}"
        if [[ -n ${file} ]] && ! is_safe_name "${file}"; then
          errors+=("Image file '${file}' must be a plain filename inside the submission folder.")
        elif [[ -z ${file} || ! -f ${img} ]]; then
          errors+=("Image file '${file}' listed in meta.yaml does not exist.")
        elif ! dims=$(png_dims "${img}"); then
          errors+=("Image '${file}' could not be read.")
        else
          size=$(file_bytes "${img}")
          if ((size > MAX_BSKY_BYTES)); then
            kb=$(awk -v s="${size}" 'BEGIN { printf "%.2f", s / 1024 }')
            errors+=("Image '${file}' is too large. Size is ${kb} KB, max is 976.56 KB.")
          fi
          read -r w h <<<"${dims}"
          mp=$(awk -v w="${w}" -v h="${h}" 'BEGIN { printf "%.2f", w * h / 1e6 }')
          if awk -v w="${w}" -v h="${h}" -v m="${MAX_MASTODON_MP}" 'BEGIN { exit !(w * h / 1e6 > m) }'; then
            errors+=("Image '${file}' has too many megapixels. It is ${mp} MP, max is ${MAX_MASTODON_MP} MP.")
          fi
        fi
        if ((${#alt} > 1000)); then
          errors+=("Alt text for '${file}' is ${#alt} characters, which exceeds the Mastodon limit of 1000 characters.")
        fi
      done < <(yq -o=json -I=0 '.images[]' "${meta}")
    fi
  fi
fi

# 4. Report -------------------------------------------------------------------
echo "4. Preparing report..."
header="### TidyTuesday Submission Check:"
if [[ ${#errors[@]} -gt 0 ]]; then
  header+=" Failed ❌"
  status=failure
else
  header+=" Passed ✅"
  status=success
fi

{
  echo "<!-- PR check -->"
  echo
  echo "${header}"
  echo
  if [[ ${#errors[@]} -gt 0 ]]; then
    for e in "${errors[@]}"; do
      printf -- '- [ ] %s\n' "${e}"
    done
    echo
  fi
  for i in "${!infos[@]}"; do
    ((i > 0)) && echo
    printf '%s\n' "${infos[i]}"
  done
} >"${report_file}"

echo "Report written to ${report_file}"
echo "check_status=${status}" >>"${status_file}"
