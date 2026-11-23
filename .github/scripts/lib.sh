#!/usr/bin/env bash
# Shared helpers for the TidyTuesday check/assign scripts.
# Sourced by check_curated.sh and assign_week.sh. Requires: bash, perl, and
# (for metadata) yq (mikefarah), all available on GitHub's ubuntu-latest image.

# Strip HTML comments and surrounding whitespace, and end with one newline.
read_piece() {
  perl -0777 -pe 's/\r\n/\n/g; s/<!--.*?-->//gs; s/\A\s+//; s/\s+\z//; $_ .= "\n"' "$1"
}

# Quote bare YAML scalar values in place so values containing ": " parse.
# Block scalars (`key: >` / `key: |`) and their continuation lines are skipped.
yaml_preprocess() {
  perl -i -ne '
    BEGIN { $in_block = 0; $block_indent = 0; }
    s/\s+\z//;
    $line = $_;
    ($indent) = $line =~ /^( *)/;
    $indent = length($indent);
    $empty = $line !~ /\S/;
    if ($in_block && !$empty && $indent <= $block_indent) { $in_block = 0; }
    if ($in_block) { print "$line\n"; next; }
    if ($line =~ /^\s*\S[^:]*:\s*[>|][-+]?[0-9]*\s*$/) {
      $in_block = 1;
      $block_indent = $indent;
    }
    $line =~ s/^([^:]*:\s+)([^>|"\x27].*)$/$1"$2"/;
    print "$line\n";
  ' "$1"
}

# Print the dates (YYYY-MM-DD) listed in the first column group of a readme's
# markdown table, one per line.
readme_dates() {
  grep -E '^\|' "$1" | cut -d'|' -f3 | tr -d ' ' |
    grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' || true
}

# Print "width height" of a PNG by reading its IHDR chunk. Fails for non-PNGs.
png_dims() {
  perl -e '
    open(my $fh, "<:raw", $ARGV[0]) or exit 1;
    read($fh, my $b, 24) == 24 or exit 1;
    substr($b, 0, 8) eq "\x89PNG\r\n\x1a\n" && substr($b, 12, 4) eq "IHDR" or exit 1;
    print join(" ", unpack("NN", substr($b, 16, 8)));
  ' "$1"
}

# Resize an image to PERCENT% of its size using Pillow, installing Pillow
# only if it is missing. Usage: resize_image in out percent
resize_image() {
  local py cand
  for cand in python3 python; do
    # Skip missing interpreters and Windows Store stubs that don't run.
    if command -v "${cand}" >/dev/null 2>&1 && "${cand}" -c "" 2>/dev/null; then
      py=${cand}
      break
    fi
  done
  if [[ -z ${py:-} ]]; then
    echo "Python is required to resize images." >&2
    return 1
  fi
  if ! "${py}" -c 'import PIL' 2>/dev/null; then
    "${py}" -m pip install --quiet pillow || return 1
  fi
  "${py}" -c '
import sys
from PIL import Image
src, dst, pct = sys.argv[1], sys.argv[2], float(sys.argv[3]) / 100
with Image.open(src) as im:
    size = (max(1, round(im.width * pct)), max(1, round(im.height * pct)))
    im.resize(size, Image.LANCZOS).save(dst, optimize=True)
' "$1" "$2" "$3"
}

# File size in bytes.
file_bytes() {
  wc -c <"$1" | tr -d ' '
}

# Bluesky image limit (976.56 KB in bytes, rounded down) and Mastodon limit.
MAX_BSKY_BYTES=999997
MAX_MASTODON_MP=8.3

# URL checks ------------------------------------------------------------------
# check_url appends to the caller's `errors` array.

# True (0) if the host in a URL looks private/internal (SSRF risk).
is_ssrf_risk() {
  local rest=${1#*://} host
  rest=${rest%%[/?#]*}
  rest=${rest##*@}
  if [[ ${rest} == \[* ]]; then
    host=${rest#\[}
    host=${host%%]*}
  else
    host=${rest%%:*}
  fi
  host=${host,,}
  [[ -z ${host} ]] && return 0
  is_private_host "${host}"
}

# True (0) if a host name or IP literal is private/internal/reserved.
is_private_host() {
  local pattern='^(localhost$|0\.|127\.|10\.|100\.(6[4-9]|[7-9][0-9]|1[01][0-9]|12[0-7])\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.|169\.254\.|::1?$|::ffff:|f[cd][0-9a-f]{2}:|fe[89ab][0-9a-f]:)'
  [[ ${1,,} =~ ${pattern} ]]
}

# Print the IP addresses a host name resolves to (one per line).
resolve_host() {
  perl -MSocket=:all -e '
    my ($err, @res) = Socket::getaddrinfo($ARGV[0], "", {socktype => SOCK_STREAM});
    exit 0 if $err;
    my %seen;
    for my $r (@res) {
      my ($e, $ip) = Socket::getnameinfo($r->{addr}, NI_NUMERICHOST, NIx_NOSERV);
      print "$ip\n" unless $e || $seen{$ip}++;
    }' "$1" 2>/dev/null
}

# Print "host port" for a URL.
url_host_port() {
  local rest=${1#*://} host port scheme=${1%%://*}
  rest=${rest%%[/?#]*}
  rest=${rest##*@}
  if [[ ${rest} == \[* ]]; then
    host=${rest#\[}
    host=${host%%]*}
    port=${rest##*]}
    port=${port#:}
  else
    host=${rest%%:*}
    [[ ${rest} == *:* ]] && port=${rest##*:}
  fi
  if [[ -z ${port:-} ]]; then
    [[ ${scheme,,} == https ]] && port=443 || port=80
  fi
  printf '%s %s\n' "${host,,}" "${port}"
}

check_url() {
  local url=$1 name=$2 hop output code next
  [[ -z ${url} ]] && return 0
  local orig=${url}
  # Follow redirects by hand (at most 5) so every hop is re-validated; letting
  # curl follow them would let a public URL redirect to an internal address.
  for ((hop = 0; hop <= 5; hop++)); do
    if [[ ! ${url,,} =~ ^https?:// ]]; then
      if ((hop == 0)); then
        errors+=("URL for '${name}' must use http:// or https:// scheme: ${url}")
      else
        errors+=("URL for '${name}' redirects to a non-http(s) address: ${url}")
      fi
      return 0
    fi
    if is_ssrf_risk "${url}"; then
      if ((hop == 0)); then
        errors+=("URL for '${name}' targets a private or reserved address: ${url}")
      else
        errors+=("URL for '${name}' redirects to a private or reserved address: ${url}")
      fi
      return 0
    fi
    # Resolve here, validate every address, and pin curl to them so DNS
    # cannot change between the check and the request (rebinding).
    local host port ips ip pin=()
    read -r host port < <(url_host_port "${url}")
    if [[ ! ${host} =~ ^[0-9.]+$ && ${host} != *:* ]]; then
      ips=$(resolve_host "${host}")
      if [[ -z ${ips} ]]; then
        errors+=("Could not reach URL for '${name}'. Please check manually: ${orig}")
        return 0
      fi
      while read -r ip; do
        if is_private_host "${ip}"; then
          errors+=("URL for '${name}' resolves to a private or reserved address (${ip}): ${url}")
          return 0
        fi
      done <<<"${ips}"
      pin=(--resolve "${host}:${port}:$(paste -sd, - <<<"${ips}")")
    fi
    output=$(curl -s -o /dev/null -I -m 10 "${pin[@]}" \
      -A "Mozilla/5.0 (compatible; TidyTuesdayBot/1.0)" \
      -w '%{http_code} %{redirect_url}' -- "${url}") || output="000 "
    read -r code next <<<"${output}"
    if [[ ${code} =~ ^3[0-9]{2}$ && -n ${next:-} ]]; then
      url=${next}
      continue
    fi
    if [[ ${code} == 000 || ${code} -ge 400 ]]; then
      errors+=("Could not reach URL for '${name}'. Please check manually: ${orig}")
    fi
    return 0
  done
  errors+=("Could not reach URL for '${name}' (too many redirects). Please check manually: ${orig}")
}

# UTF-8 check -----------------------------------------------------------------

# Print an error for each non-UTF-8 line (up to 5 shown) in a file, if any.
utf8_error() {
  perl -e '
    use strict; use warnings; use Encode ();
    my ($file, $name) = @ARGV;
    open(my $fh, "<:raw", $file) or die "cannot open $file: $!";
    my ($n, $bad, @details) = (0, 0);
    while (my $line = <$fh>) {
      $n++;
      my $copy = $line;
      next if eval { Encode::decode("UTF-8", $copy, Encode::FB_CROAK | Encode::LEAVE_SRC); 1 };
      $bad++;
      if (@details < 5) {
        my @hi = grep { $_ > 0x7f } unpack("C*", $line);
        my $hex = join(" ", map { sprintf("%02x", $_) } @hi);
        my $latin1 = Encode::encode("UTF-8", join("", map { chr($_) } @hi));
        push @details, "  line $n: bytes [$hex] (as latin1: \"$latin1\")";
      }
    }
    exit 0 unless $bad;
    print "$name contains $bad line(s) with non-UTF-8 bytes (first 5 shown). "
      . "The file may be Latin-1 or another encoding; re-save as UTF-8 in "
      . "cleaning.R using `readr::locale(encoding = \"latin1\")` (or the correct "
      . "encoding). Offending bytes per line:\n" . join("\n", @details);
  ' "$1" "$(basename "$1")"
}

# Date logic ------------------------------------------------------------------

# Print the date 7 days after the latest of the given dates.
next_target_date() {
  local latest
  latest=$(printf '%s\n' "$@" | sort | tail -n 1)
  date -d "${latest} + 7 days" +%F
}

# Validate a target date against the already-used dates (remaining arguments).
# Prints an error message and returns 1 if invalid.
validate_target_date() {
  local target=$1
  shift
  if ! [[ ${target} =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] ||
    [[ $(date -d "${target}" +%F 2>/dev/null) != "${target}" ]]; then
    echo "Bad target_date: ${target}"
    return 1
  fi
  if printf '%s\n' "$@" | grep -qx "${target}"; then
    echo "Date already used."
    return 1
  fi
  if [[ $(date -d "${target}" +%u) != 2 ]]; then
    echo "Bad target_date: not a Tuesday."
    return 1
  fi
}

# Week number matching lubridate::week(): 7-day blocks counted from Jan 1.
week_of_year() {
  local yday
  yday=$((10#$(date -d "$1" +%j)))
  echo $(((yday - 1) / 7 + 1))
}

# Path safety and cleaning scripts --------------------------------------------

# True (0) if $1 is a plain single path component: non-empty, not hidden (which
# also excludes . and ..), and with no path separators.
is_safe_name() {
  [[ -n $1 && $1 != .* && $1 != */* && $1 != *'\'* ]]
}

# Print the cleaning scripts (cleaning.R, .r, .py, .jl) in directory $1.
cleaning_scripts() {
  local f
  for f in "$1"/cleaning.*; do
    [[ -f ${f} ]] || continue
    case "${f##*.}" in
      R | r | py | jl) printf '%s\n' "${f}" ;;
    esac
  done
}

# Print the languages used by more than one of the cleaning script paths given
# (comma-separated); empty if each language appears at most once.
duplicate_cleaning_languages() {
  local f
  for f in "$@"; do
    case "${f##*.}" in
      R | r) echo r ;;
      py) echo python ;;
      jl) echo julia ;;
    esac
  done | sort | uniq -d | paste -sd, -
}
