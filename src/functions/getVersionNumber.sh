VERSION_NUMBER="1"

function getVersionNumber() {
  local tagPrefix="$1"
  local date="$2"

  loadRecentTags "$tagPrefix" "$date"
  debug "RECENT_TAGS" "$RECENT_TAGS"

  if [ -z "$RECENT_TAGS" ]; then
    debug "No tags found"
    return 0
  fi

  # So this is a "hack" to get the sort point as the number after the dot
  local matches=(${RECENT_TAGS//./ })
  local sortPoint=$((${#matches[0]} + 2))
  debug "SORT_POINT" "$sortPoint"

  if [ -z "$sortPoint" ]; then
    debug "No sort point found"
    return 0
  fi

  # sort by the sortPoint of the first word
  local lastTag="$(echo "$RECENT_TAGS" | sort -rn -k 1.$sortPoint | head -n 1)"
  debug "LAST_TAG" "$lastTag"

  local previousVersion="$(echo $lastTag | sed 's/[^\.]*\.//')"
  debug "PREVIOUS_VERSION" "$previousVersion"

  if [ -z "$previousVersion" ]; then
    debug "No previous version found"
    return 0
  fi

  local dotVersion="$(($previousVersion + 1))"
  debug "Next Dot Version" "$dotVersion"

  VERSION_NUMBER="$dotVersion"

  return 0
}
