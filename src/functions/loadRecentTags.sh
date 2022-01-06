RECENT_TAGS=""

loadRecentTags() {
  local prefix="$1"
  local date=$2
  debug "prefix" "$prefix"

  if [ -z "$prefix" ]; then
    prefix="*"
  fi

  local search="$prefix$date*"
  debug "git tag search" "$search"

  local tags=$(git tag -l "$search")
  debug "tags" "$tags"
  RECENT_TAGS="$tags"
}