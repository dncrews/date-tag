CREATED_TAG=""
CHOSEN_TAG=""

function chooseRecentTag() {
  local date="$1"
  local input

  loadRecentTags "*" "$date"
  debug "RECENT_TAGS" "$RECENT_TAGS"

  if [ -z "$RECENT_TAGS" ]; then
    echo "No tags found for today. Please create one first."
    exit 1
  fi

  printf "\n\n"
  # Check if there is more than one line
  if [ "$(echo "$RECENT_TAGS" | wc -l)" -gt 1 ]; then
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
  else
    debug "Only one tag found. Using it."
    CHOSEN_TAG="$RECENT_TAGS"
  fi
  return 0

  # printf= "\nMultiple tags found for today. Please choose one: \n"
  # PS3="Select a release to push: "
  # IFS=$'\n'
  # select chosenTag in $RECENT_TAGS; do
  #   printf "\n\n"
  #   if [ -n "$chosenTag" ]; then
  #     debug "Chosen tag" "$chosenTag"
  #     CHOSEN_TAG="$chosenTag"
  #     return 0
  #   else
  #     return 0
  #     # echo "None selected. kthxbai"
  #   fi
  # done
  # unset IFS
  # unset PS3

  # # git tag -l "*$TODAY*"
  # getTodaysTags '*' && TODAY_TAGS=$GLOBAL_RETURN
  # TODAY_TAGS=$(git tag -l "*$TODAY*")
  # debug "Today's tags" "$TODAY_TAGS"
  # if [ -z "$TODAY_TAGS" ]; then
  #   printf "No tags found for today. Would you like to create one? [y/N]: "

  #   # Create or nah?
  #   read -n 1 input
  #   printf "\n\n"
  #   if [ "$input" != "y" ]; then
  #     echo "OK. Thanks for playing."
  #     exit 0
  #   fi

  #   echo "TODO: Create the tag and continue"
  #   exit 1
  # fi
  # IFS=$'\n'
  # select chosenTag in $RECENT_TAGS; do
  #   printf "\n\n"
  #   if [ -n "$chosenTag" ]; then
  #     debug "Chosen tag" "$chosenTag"
  #     CHOSEN_TAG="$chosenTag"
  #   else
  #     return 0
  #     # echo "None selected. kthxbai"
  #   fi
  # done
  # unset IFS
}