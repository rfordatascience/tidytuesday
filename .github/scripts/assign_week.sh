#!/usr/bin/env bash
# Accept a curated TidyTuesday submission: move it to data/<year>/<date>/ and
# update the readmes and static/tt_data_type.csv.
#
# Usage: assign_week.sh [target_date] [src_folder_name]
#   target_date      YYYY-MM-DD Tuesday. Defaults to a week after the latest
#                    date in README.md.
#   src_folder_name  Folder under data/curated. Defaults to the only
#                    non-template folder there.
#
# Requires: bash, perl, GNU date, awk, yq (mikefarah); Python (Pillow is installed on demand) for resizing.

set -euo pipefail
export LC_ALL=C.UTF-8

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${script_dir}/lib.sh"
cd "${script_dir}/../.."

die() {
  echo "Error: $*" >&2
  exit 1
}

# Arguments -------------------------------------------------------------------

target_date=${1:-}
src_folder_name=${2:-}

main_readme=README.md
mapfile -t used_dates < <(readme_dates "${main_readme}")
[[ ${#used_dates[@]} -gt 0 ]] || die "No dates found in ${main_readme}."

if [[ -z ${target_date} ]]; then
  target_date=$(next_target_date "${used_dates[@]}")
fi
msg=$(validate_target_date "${target_date}" "${used_dates[@]}") || die "${msg}"

if [[ -z ${src_folder_name} ]]; then
  dirs=()
  for d in data/curated/*/; do
    d=${d%/}
    [[ ${d##*/} == template ]] && continue
    dirs+=("${d##*/}")
  done
  [[ ${#dirs[@]} -gt 0 ]] || die "No curated directories found in data/curated."
  [[ ${#dirs[@]} -eq 1 ]] ||
    die "Multiple curated directories found in data/curated: ${dirs[*]}"
  src_folder_name=${dirs[0]}
fi

echo "target_date = ${target_date}"
echo "src_folder_name = ${src_folder_name}"

# Sources and targets ---------------------------------------------------------

is_safe_name "${src_folder_name}" ||
  die "Invalid folder name (must be a single directory under data/curated): ${src_folder_name}"
src_dir=data/curated/${src_folder_name}
[[ -d ${src_dir} ]] || die "${src_dir} does not exist."
target_year=${target_date:0:4}
target_week=$(week_of_year "${target_date}")
target_dir=data/${target_year}/${target_date}
mkdir -p "data/${target_year}"
# Atomic create: refuse to overwrite an existing assignment.
mkdir "${target_dir}" 2>/dev/null || die "${target_dir} already exists; refusing to overwrite."

shopt -s nullglob
mapfile -t cleaning_src < <(cleaning_scripts "${src_dir}")
[[ ${#cleaning_src[@]} -gt 0 ]] || die "No cleaning script found in ${src_dir}."
dup=$(duplicate_cleaning_languages "${cleaning_src[@]}")
[[ -z ${dup} ]] ||
  die "More than one cleaning script for the same language (${dup}) in ${src_dir}."
dataset_files=("${src_dir}"/*.csv)
[[ ${#dataset_files[@]} -gt 0 ]] || die "No csv files found in ${src_dir}."

# Metadata --------------------------------------------------------------------

meta=${src_dir}/meta.yaml
yaml_preprocess "${meta}"

meta_get() {
  yq -r "${1} // \"\"" "${meta}"
}
require() {
  [[ -n $1 ]] || die "missing data in meta.yaml: $2"
}

title=$(meta_get .title)
data_title=$(meta_get .data_source.title)
data_link=$(meta_get .data_source.url)
article_title=$(meta_get .article.title)
article_link=$(meta_get .article.url)
require "${title}" title
require "${data_title}" data_source.title
require "${data_link}" data_source.url
require "${article_title}" article.title
require "${article_link}" article.url

credit=$(meta_get .credit.post)
credit_github=$(meta_get .credit.github)
if [[ -n ${credit_github} ]]; then
  # Normalize in case they gave full path vs just handle or included @.
  credit_handle=$(printf '%s' "${credit_github}" |
    sed -e 's/github\.com//' -e 's#https://##' -e 's#/##g' -e 's/@//')
  credit_github="https://github.com/${credit_handle}"
  if [[ -n ${credit} ]]; then
    credit="[${credit}](${credit_github})"
  else
    # Existing behavior (documented in copilot-instructions.md).
    credit="@credit_handle"
  fi
fi

# Copy files ------------------------------------------------------------------

cp "${meta}" "${target_dir}/"
cp "${dataset_files[@]}" "${target_dir}/"

for f in "${src_dir}"/*.md "${cleaning_src[@]}"; do
  { read_piece "${f}"; echo; } >"${target_dir}/$(basename "${f}")"
done

# Resize images
mapfile -t image_files < <(yq -r '.images[].file' "${meta}")
for image in "${image_files[@]}"; do
  [[ -n ${image} && ${image} != null ]] || continue
  is_safe_name "${image}" ||
    die "Image ${image} in meta.yaml must be a plain filename inside the submission folder."
  original=${src_dir}/${image}
  [[ -f ${original} ]] || die "Image ${image} listed in meta.yaml does not exist."
  size=$(file_bytes "${original}")
  if ((size >= MAX_BSKY_BYTES)); then
    # Round down to stay under the limit; file size isn't exactly proportional
    # to pixel scale, but this errs on the side of being smaller.
    ratio=$((MAX_BSKY_BYTES * 90 / size))
    resize_image "${original}" "${target_dir}/${image}" "${ratio}"
  else
    cp "${original}" "${target_dir}/"
  fi
done

# Create readme ---------------------------------------------------------------

intro=$(read_piece "${src_dir}/intro.md")$'\n'
intro+=$'\n'"Thank you to ${credit} for curating this week's dataset."$'\n'

# Render the_data.md template: {{date}}/{{year}}/{{week}} plus the
# {{#datasets}}...{{/datasets}} loop over dataset files.
dataset_names=()
for f in "${dataset_files[@]}"; do
  dataset_names+=("$(basename "${f}")")
done
the_data=$(read_piece static/templates/the_data.md |
  DATE=${target_date} YEAR=${target_year} WEEK=${target_week} \
    DATASETS=$(printf '%s\n' "${dataset_names[@]}") perl -0777 -e '
    my $t = <STDIN>;
    my @files = split /\n/, $ENV{DATASETS};
    $t =~ s{^\{\{#datasets\}\}\n(.*?)^\{\{/datasets\}\}\n}{
      my $body = $1;
      join "", map {
        my $f = $_; (my $n = $f) =~ s/\.[^.]*$//;
        (my $b = $body) =~ s/\{\{\{dataset_name\}\}\}/$n/g;
        $b =~ s/\{\{\{dataset_file\}\}\}/$f/g;
        $b =~ s/\{\{dataset_file\}\}/$f/g;
        $b;
      } @files
    }gmse;
    $t =~ s/\{\{date\}\}/$ENV{DATE}/g;
    $t =~ s/\{\{year\}\}/$ENV{YEAR}/g;
    $t =~ s/\{\{week\}\}/$ENV{WEEK}/g;
    print $t;
  ')
the_data+=$'\n'

how_to_participate=$(read_piece static/templates/how_to_participate.md)

dictionaries=""
for name in "${dataset_names[@]}"; do
  [[ -n ${dictionaries} ]] && dictionaries+=$'\n\n'
  dictionaries+="### \`${name}\`"$'\n\n'
  dictionaries+=$(read_piece "${src_dir}/${name%.csv}.md")
done
data_dictionary="## Data Dictionary"$'\n\n'"${dictionaries}"

cleaning_script="## Cleaning Script"
((${#cleaning_src[@]} > 1)) && cleaning_script="## Cleaning Scripts"
cleaning_script+=$'\n\n'
for cleaning_file in "${cleaning_src[@]}"; do
  case "${cleaning_file##*.}" in
    R | r) language_tag=r ;;
    py) language_tag=python ;;
    jl) language_tag=julia ;;
    *) die "Unknown cleaning script extension: ${cleaning_file##*.}" ;;
  esac
  if ((${#cleaning_src[@]} > 1)); then
    cleaning_script+="### \`$(basename "${cleaning_file}")\`"$'\n\n'
  fi
  cleaning_script+="\`\`\`${language_tag}"$'\n'
  cleaning_script+=$(read_piece "${cleaning_file}")$'\n\n'
  cleaning_script+='```'$'\n\n'
done
cleaning_script=${cleaning_script%$'\n'}

{
  printf '# %s\n\n%s\n\n%s\n\n%s\n\n%s\n\n%s' \
    "${title}" "${intro}" "${the_data}" "${how_to_participate}" \
    "${data_dictionary}" "${cleaning_script}"
} | perl -0777 -pe 's/\n{3,}/\n\n/g' >"${target_dir}/readme.md"

# Update readme tables --------------------------------------------------------

# Insert a table row into a markdown file, keeping rows sorted by date. The
# header and delimiter rows are untouched; rows are matched on the first table
# column group (Week|Date|...).
insert_row() {
  local file=$1 row=$2
  ROW=${row} DATE=${target_date} awk '
    BEGIN { FS = "|"; inserted = 0 }
    {
      if ($0 ~ /^\|/ && !inserted) {
        d = $3; gsub(/ /, "", d)
        if (d ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && d > ENVIRON["DATE"]) {
          print ENVIRON["ROW"]; inserted = 1
        }
      }
      if ($0 !~ /^\|/ && last_table && !inserted) {
        print ENVIRON["ROW"]; inserted = 1
      }
      last_table = ($0 ~ /^\|/)
      print
    }
    END { if (!inserted) print ENVIRON["ROW"] }
  ' "${file}" >"${file}.tmp"
  mv "${file}.tmp" "${file}"
}

year_readme=data/${target_year}/readme.md
if [[ ! -f ${year_readme} ]]; then
  {
    printf '# %s Data\n\n' "${target_year}"
    printf 'Archive of datasets and articles from the %s series of `#TidyTuesday` events.\n\n' "${target_year}"
    printf '| Week|Date|Data|Source|Article|\n|----:|:---|:---|:---|:---|\n'
  } >"${year_readme}"
fi

year_row="|${target_week}|${target_date}|[${title}](${target_date}/readme.md)|[${data_title}](${data_link})|[${article_title}](${article_link})|"
main_row="|${target_week}|${target_date}|[${title}](data/${target_year}/${target_date}/readme.md)|[${data_title}](${data_link})|[${article_title}](${article_link})|"
insert_row "${year_readme}" "${year_row}"
insert_row "${main_readme}" "${main_row}"

# tt_data_type.csv ------------------------------------------------------------

types_file=static/tt_data_type.csv
{
  head -n 1 "${types_file}"
  for name in "${dataset_names[@]}"; do
    printf '%s,%s,%s,%s,csv,","\n' "${target_week}" "${target_date}" "${target_year}" "${name}"
  done
  tail -n +2 "${types_file}"
} >"${types_file}.tmp"
mv "${types_file}.tmp" "${types_file}"

# Delete the used directory ---------------------------------------------------

rm -rf "${src_dir}"
echo "Assigned ${src_folder_name} to ${target_date}."
