CHOSEN_TAG=""

function chooseRecentTag() {
  local input

  loadRecentTags "*"
  debug "RECENT_TAGS" "$RECENT_TAGS"

  if [ -z "$RECENT_TAGS" ]; then
    echo "No tags found for today. Please create one first."
    exit 1
  fi

  printf "\n\n"
  # Check if there is more than one line

  if [ "$(echo "$RECENT_TAGS" | wc -l)" == 1 ]; then
      debug "Only one tag found. Using it."
      CHOSEN_TAG="$RECENT_TAGS"
      return 0
  fi

  printf "\nMultiple tags found. Let's choose one.\n"
  PS3="Select a release to push: "
  IFS=$'\n'
  select input in $RECENT_TAGS; do
    if [ -n "$input" ]; then
      CHOSEN_TAG="$input"
      debug "Chosen tag" "$CHOSEN_TAG"
      break
    fi
  done
  printf "\n\n"
  unset IFS
  unset PS3

  return 0
}