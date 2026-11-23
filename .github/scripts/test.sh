#!/usr/bin/env bash
# Tests for the TidyTuesday check/assign scripts (ported from the former
# testthat files). Run from anywhere:
#   bash .github/scripts/test.sh
# Requires: bash, perl, GNU date, yq (for the YAML/CSV-summary tests).

set -uo pipefail
export LC_ALL=C.UTF-8

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${script_dir}/lib.sh"
fixtures="${script_dir}/fixtures"
check_script="${script_dir}/check_curated.sh"

tmp_root=$(mktemp -d)
trap 'rm -rf "${tmp_root}"' EXIT

passed=0
failed=0

pass() { passed=$((passed + 1)); }
fail() {
  failed=$((failed + 1))
  echo "FAIL: $1" >&2
  [[ -n ${2:-} ]] && printf '      %s\n' "$2" >&2
}

assert_eq() { # name expected actual
  if [[ $2 == "$3" ]]; then pass; else fail "$1" "expected [$2], got [$3]"; fi
}
assert_contains() { # name haystack needle
  if [[ $2 == *"$3"* ]]; then pass; else fail "$1" "[$3] not found in [$2]"; fi
}
assert_not_contains() {
  if [[ $2 != *"$3"* ]]; then pass; else fail "$1" "[$3] unexpectedly found"; fi
}
assert_true() { # name command...
  local name=$1
  shift
  if "$@"; then pass; else fail "${name}"; fi
}
assert_false() {
  local name=$1
  shift
  if "$@"; then fail "${name}"; else pass; fi
}

new_dir() { mktemp -d "${tmp_root}/d.XXXXXX"; }
copy_valid() {
  local d
  d=$(new_dir)
  cp -r "${fixtures}/valid/." "${d}/"
  echo "${d}"
}

# Run the full check script against a directory; sets $report and $status.
run_check() {
  local dir=$1 root
  root=$(new_dir)
  mkdir -p "${root}/curated"
  cp -r "${dir}" "${root}/curated/submission"
  (cd "${root}" && CURATED_ROOT=curated REPORT_FILE=report.md \
    GITHUB_OUTPUT="${root}/out.txt" bash "${check_script}" >/dev/null 2>&1)
  report=$(cat "${root}/report.md" 2>/dev/null || true)
  status=$(cat "${root}/out.txt" 2>/dev/null || true)
}

# yaml_preprocess ---------------------------------------------------------

quote_line() { # prints the preprocessed form of the given lines
  local f
  f=$(mktemp "${tmp_root}/y.XXXXXX")
  printf '%s\n' "$@" >"${f}"
  yaml_preprocess "${f}"
  cat "${f}"
}

assert_eq "yaml: quotes bare scalar" 'title: "Test Dataset"' \
  "$(quote_line 'title: Test Dataset')"
assert_eq "yaml: no double quoting" 'title: "Test Dataset"' \
  "$(quote_line 'title: "Test Dataset"')"
assert_eq "yaml: bare key unchanged" "images:" "$(quote_line 'images:')"
assert_eq "yaml: block scalar indicator '>'" "  alt: >" "$(quote_line '  alt: >')"
assert_eq "yaml: block scalar indicator '|'" "  alt: |" "$(quote_line '  alt: |')"

out=$(quote_line "images:" "- file: image.png" "  alt: >" \
  "    Overall success rate: 62% across 136,000 repairs.")
assert_eq "yaml: block scalar continuation with colon untouched" \
  "    Overall success rate: 62% across 136,000 repairs." "$(sed -n 4p <<<"${out}")"

out=$(quote_line "  alt: >" "    Some text: with colon" "title: Next Section")
assert_eq "yaml: continuation untouched" "    Some text: with colon" "$(sed -n 2p <<<"${out}")"
assert_eq "yaml: quoting resumes after block scalar" 'title: "Next Section"' "$(sed -n 3p <<<"${out}")"

out=$(quote_line "  alt: >" "" "    Continuation after blank line: value" "title: After")
assert_eq "yaml: blank line inside block scalar" "" "$(sed -n 2p <<<"${out}")"
assert_eq "yaml: continuation after blank line" \
  "    Continuation after blank line: value" "$(sed -n 3p <<<"${out}")"
assert_eq "yaml: resumes after blank-line block" 'title: "After"' "$(sed -n 4p <<<"${out}")"

# Parsed fixtures (require yq)
if command -v yq >/dev/null 2>&1; then
  f=$(mktemp "${tmp_root}/m.XXXXXX")
  cp "${fixtures}/valid/meta.yaml" "${f}"
  yaml_preprocess "${f}"
  assert_eq "yaml: valid fixture parses" "Test Dataset" "$(yq -r .title "${f}")"

  cp "${fixtures}/alt-with-colon/meta.yaml" "${f}"
  yaml_preprocess "${f}"
  alt=$(yq -r '.images[0].alt' "${f}")
  assert_not_contains "yaml: alt has no stray quotes" "${alt}" '"'
  assert_contains "yaml: alt content survives" "${alt}" "62%"
else
  echo "SKIP: yq not found; skipping parsed-YAML tests" >&2
fi

# read_piece --------------------------------------------------------------

f=$(mktemp "${tmp_root}/p.XXXXXX")
printf '\n\nHello <!-- gone\nmultiline --> world\n\n\n' >"${f}"
assert_eq "read_piece: strips comments and trims, one trailing newline" \
  "$(printf 'Hello  world\n')" "$(read_piece "${f}")"

# is_ssrf_risk ------------------------------------------------------------

for u in http://example.com https://github.com/repo https://www.google.com/search; do
  assert_false "ssrf: public host ${u}" is_ssrf_risk "${u}"
done
for u in http://localhost http://127.0.0.1 http://169.254.169.254 http://10.1.2.3 \
  http://192.168.0.1 http://172.20.0.5 "http://[::1]/x" "http://[fd12::1]/x" \
  http:///path http://user@127.0.0.1:8080/x; do
  assert_true "ssrf: private host ${u}" is_ssrf_risk "${u}"
done
assert_false "ssrf: 172.32 is public" is_ssrf_risk "http://172.32.0.1"

# check_url ---------------------------------------------------------------

errors=()
check_url "" source
assert_eq "check_url: empty url adds nothing" 0 "${#errors[@]}"

for u in file:///etc/passwd ftp://example.com/file "javascript:alert(1)"; do
  errors=()
  check_url "${u}" source
  assert_contains "check_url: scheme rejected ${u}" "${errors[*]:-}" "must use http"
done
for u in http://localhost/api http://127.0.0.1/secret http://169.254.169.254/metadata \
  http://10.0.0.1/internal http://192.168.1.1/router http://172.16.0.1/priv; do
  errors=()
  check_url "${u}" source
  assert_contains "check_url: private rejected ${u}" "${errors[*]:-}" "private or reserved"
done

# Reachability, using a stub curl so tests don't need the network.
stub_dir=$(new_dir)
for code in 200 404 000; do
  printf '#!/usr/bin/env bash\nprintf "%s"\n' "${code}" >"${stub_dir}/curl"
  chmod +x "${stub_dir}/curl"
  errors=()
  PATH="${stub_dir}:${PATH}" check_url "https://example.com/x" article
  if [[ ${code} == 200 ]]; then
    assert_eq "check_url: reachable (200)" 0 "${#errors[@]}"
  else
    assert_contains "check_url: unreachable (${code})" "${errors[*]:-}" "Could not reach URL"
  fi
done

# utf8_error --------------------------------------------------------------

assert_eq "utf8: valid file has no error" "" "$(utf8_error "${fixtures}/valid/data.csv")"
msg=$(utf8_error "${fixtures}/latin1/data.csv")
assert_contains "utf8: latin1 flagged" "${msg}" "non-UTF-8"
assert_contains "utf8: hex byte reported" "${msg}" "e9"
assert_contains "utf8: latin1 hint" "${msg}" "as latin1"
assert_contains "utf8: latin1 decoded char" "${msg}" "é"
msg=$(utf8_error "${fixtures}/latin1_no_newline/data.csv")
assert_contains "utf8: bad last line without newline" "${msg}" "non-UTF-8"

# Dates -------------------------------------------------------------------

assert_eq "date: next is latest + 7" "2026-12-01" \
  "$(next_target_date 2026-11-17 2026-11-24 2026-11-10)"
assert_true "date: valid Tuesday accepted" \
  validate_target_date 2026-12-01 2026-11-24
assert_contains "date: already used" "$(validate_target_date 2026-11-24 2026-11-24)" \
  "already used"
assert_contains "date: non-Tuesday" "$(validate_target_date 2026-12-02 2026-11-24)" \
  "Tuesday"
assert_contains "date: invalid format" "$(validate_target_date 2026-13-45 2026-11-24)" \
  "Bad target_date"
assert_contains "date: garbage" "$(validate_target_date /assign 2026-11-24)" \
  "Bad target_date"
assert_eq "date: week 1" 1 "$(week_of_year 2026-01-06)"
assert_eq "date: week 47" 47 "$(week_of_year 2026-11-24)"
assert_eq "date: week 48" 48 "$(week_of_year 2026-12-01)"
assert_eq "date: week 53 (day 365)" 53 "$(week_of_year 2026-12-31)"
mapfile -t got < <(readme_dates <(printf '| Week|Date|Data|\n|--:|:--|:--|\n|   1|2026-01-06 |x|\n|   2|2026-01-13 |y|\n'))
assert_eq "date: readme_dates parses table" "2026-01-06 2026-01-13" "${got[*]}"

# check_curated.sh: required files ---------------------------------------

if command -v yq >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  # Offline: stub curl so URL checks pass.
  PATH="${stub_dir}:${PATH}"
  printf '#!/usr/bin/env bash\nprintf "200"\n' >"${stub_dir}/curl"

  d=$(copy_valid)
  run_check "${d}"
  assert_contains "check: valid fixture passes" "${report}" "Passed"
  assert_contains "check: status success" "${status}" "check_status=success"
  assert_contains "check: hidden PR tag" "${report}" "<!-- PR check -->"
  assert_contains "check: controversy link" "${report}" "Manual controversy check"

  for f in meta.yaml intro.md; do
    d=$(copy_valid)
    rm "${d}/${f}"
    run_check "${d}"
    assert_contains "check: missing ${f}" "${report}" "Missing required file: ${f}"
    assert_contains "check: failure status (${f})" "${status}" "check_status=failure"
  done

  d=$(copy_valid)
  rm "${d}/cleaning.R"
  run_check "${d}"
  assert_contains "check: missing cleaning script" "${report}" "cleaning.R or cleaning.py"

  touch "${d}/cleaning.py"
  run_check "${d}"
  assert_not_contains "check: cleaning.py alone is enough" "${report}" "cleaning"

  d=$(copy_valid)
  touch "${d}/cleaning.py"
  run_check "${d}"
  assert_not_contains "check: both cleaning scripts ok" "${report}" "Missing required file: cleaning"

  d=$(copy_valid)
  rm "${d}/image.png"
  run_check "${d}"
  assert_contains "check: missing png" "${report}" "*.png"
  assert_contains "check: listed image missing" "${report}" "does not exist"

  d=$(copy_valid)
  rm "${d}/data.csv"
  run_check "${d}"
  assert_contains "check: no csv" "${report}" "At least one *.csv"

  d=$(copy_valid)
  rm "${d}/data.md"
  run_check "${d}"
  assert_contains "check: missing dictionary" "${report}" "Missing data dictionary"

  d=$(copy_valid)
  cp "${fixtures}/latin1/data.csv" "${d}/data.csv"
  run_check "${d}"
  assert_contains "check: non-UTF-8 csv" "${report}" "non-UTF-8"

  d=$(copy_valid)
  cp "${fixtures}/latin1_no_newline/data.csv" "${d}/data.csv"
  run_check "${d}"
  assert_contains "check: non-UTF-8 last line" "${report}" "non-UTF-8"

  d=$(copy_valid)
  if command -v duckdb >/dev/null 2>&1; then
    run_check "${d}"
    assert_contains "check: info has csv filename" "${report}" "data.csv:"
    assert_contains "check: summary table header" "${report}" "|variable"
  fi

  d=$(copy_valid)
  cp "${fixtures}/oversized.png" "${d}/image.png"
  run_check "${d}"
  assert_contains "check: Bluesky size limit" "${report}" "too large"

  d=$(copy_valid)
  # 3500x3500 PNG header (only the IHDR is read by the check).
  perl -e 'print "\x89PNG\r\n\x1a\n", pack("N", 13), "IHDR", pack("NN", 3500, 3500), "\x08\x02\x00\x00\x00", "\0\0\0\0"' >"${d}/image.png"
  run_check "${d}"
  assert_contains "check: Mastodon megapixel limit" "${report}" "megapixels"

  for n in 1001 1000; do
    d=$(copy_valid)
    alt=$(printf 'a%.0s' $(seq 1 "${n}"))
    printf 'title: "T"\narticle:\n  url: "https://example.com"\ndata_source:\n  url: "https://example.com"\nimages:\n  - file: "image.png"\n    alt: "%s"\n' \
      "${alt}" >"${d}/meta.yaml"
    run_check "${d}"
    if [[ ${n} -gt 1000 ]]; then
      assert_contains "check: alt text ${n} too long" "${report}" "Alt text"
    else
      assert_not_contains "check: alt text ${n} ok" "${report}" "Alt text"
    fi
  done

  d=$(copy_valid)
  printf 'data_source:\n  url: "https://example.com"\n' >"${d}/meta.yaml"
  run_check "${d}"
  assert_not_contains "check: no title, no controversy link" "${report}" "controversy"
  assert_contains "check: images section missing" "${report}" "'images' section"

  d=$(copy_valid)
  sed -i 's#https://example.com/article#http://localhost/x#' "${d}/meta.yaml"
  run_check "${d}"
  assert_contains "check: private article url" "${report}" "private or reserved"
else
  echo "SKIP: yq/jq not found; skipping check_curated.sh tests" >&2
fi

echo "${passed} passed, ${failed} failed"
[[ ${failed} -eq 0 ]]
