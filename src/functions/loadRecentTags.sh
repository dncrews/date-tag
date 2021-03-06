RECENT_TAGS=""

function loadRecentTags() {
  local prefix="$1"
  debug "prefix" "$prefix"

  if [ -z "$prefix" ]; then
    prefix="*"
  fi

  local search="$prefix$DATE*"
  debug "git tag search" "$search"

  local tags=$(git tag -l "$search")
  debug "tags" "$tags"
  RECENT_TAGS="$tags"
}