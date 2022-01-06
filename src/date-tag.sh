#!/usr/bin/env bash

# This sets our matching to case insensitive
# https://unix.stackexchange.com/a/395686
shopt -s nocasematch

# https://stackoverflow.com/a/17744637/652728
function realpath() {
    f=$@
    if [ -d "$f" ]; then
        base=""
        dir="$f"
    else
        base="/$(basename "$f")"
        dir=$(dirname "$f")
    fi
    dir=$(cd "$dir" && /bin/pwd)
    echo "$dir$base"
}

FULL_PATH="$(realpath $0)"
__DIRNAME__="$(dirname $FULL_PATH)"

# relative source only works if you're actually in that directory
pushd $__DIRNAME__ > /dev/null
source "./functions/functions.sh"
popd > /dev/null


PUSH_READY=false
# PUSH_ONLY=false
# TODAY="$(date +%F)"
# PREFIX=""
GLOBAL_RETURN=""
# CREATED_TAG=""

# createTagr() {
#   # local returnVar="$1"
#   local prefix="$1"
#   local previousDot="$2"

#   local nextDot="1"
#   local input

#   if [ -z "$prefix" ]; then
#     echo "No Prefix set for tag"
#     exit 1
#   fi
#   if [ -n "$previousDot" ]; then
#     nextDot="$(($previousDot + 1))"
#   fi

#   local newTag="$prefix$TODAY.$nextDot"

#   printf "Ready to create tag '$newTag'? [y/N]: "
#   read -n 1 input
#   printf "\n\n"
#   if [ "$input" != "Y" ] && [ "$input" != "y" ]; then
#     echo "OK. Thanks for playing."
#     exit 0
#   fi

#   # Create the tag
#   debug "Creating Tag: '$newTag'"
#   git tag -a "$newTag" -m "New Release: $newTag"

#   CREATED_TAG="$newTag"
#   GLOBAL_RETURN="$newTag"
#   # eval "$returnVar"="'$newTag'"
# }

# debugr() {
#   if [ -n "$DEBUG" ]; then
#     echo "$@"
#   fi
# }

# getTodaysTagsr() {
#   local returnVar="$1"
#   local prefix="$2"
#   echo "prefix \"$prefix\""

#   if [ -z "$prefix" ]; then
#     prefix="*"
#   fi
#   echo "$prefix$TODAY*"

#   local tags=$(git tag -l "$prefix$TODAY*")
#   echo "TAGS"
#   echo "$tags"
#   echo "/TAGS"
#   GLOBAL_RETURN="$tags"
#   # eval "$returnVar=\"$tags\""
# }

# pushTagr() {
#   local tagName="$1"
#   local input

#   printf "Ready to Push or nah? P to push the tag to GitHub? [p/N]: "
#   # Push it up or nah?
#   read -n 1 input
#   printf "\n\n"
#   if [ "$input" != "P" ] && [ "$input" != "p" ]; then
#     echo "KK I won't"
#     exit 0
#   fi

#   # Push the tag; no output if we do this, since git will give us some
#   git push origin "$tagName"
#   exit 0
# }

parseArgs "$@"
debug "Today" "$TODAY"

# getTodaysTags 'rc-v' && TEST_TAGS=$GLOBAL_RETURN

# # echo "GLOBALRETURN2: $GLOBAL_RETURN"
# echo "TEST_TAGS: $TEST_TAGS"
# exit 1

# rc => Deploys to Demo
# case $1 in
#   "rc" | "beta" | "demo")
#     PREFIX="rc-v"
#     STAGE="Demo"
#     ;;
#   "prod" | "full" | "release" )
#     PREFIX="v"
#     STAGE="Production"
#     ;;
#   "push" )
#     PUSH_ONLY=true
#     ;;
#   * )
#     echo "Usage: release <rc | prod>"
#     exit 1
#     ;;
# esac

debug "P" "$PREFIX"
debug "S" "$STAGE"
debug "PO" "$PUSH_ONLY"



# if $PUSH_ONLY; then

# fi

# exit 1
# if [[ "$1" = "rc" ]]; then
#   PREFIX="rc-v"
#   STAGE="Demo"
# # prod => Deploys to Production
# elif [ "$1" = "prod" ]; then
#   PREFIX="v"
#   STAGE="Production"
# # push => Shows you a list of todays releases to push
# elif [ "$1" = "push" ]; then
#   PUSH_ONLY=true
#   # PREFIX="v"
#   # STAGE="Production"
# else
#   echo "Usage: release <rc | prod>"
#   exit 1
# fi

if $DO_CREATE_TAG; then
  getVersionNumber "$TAG_PREFIX" "$DATE"
  debug "Dot Version" "$VERSION_NUMBER"

  tagCreate "$TAG_PREFIX" "$DATE" "$VERSION_NUMBER"

  debug "Created Tag" "$CREATED_TAG"
  # PUSH_READY=true
  if [ -n "$CREATED_TAG" ]; then
    PUSH_READY="$CREATED_TAG"
  else
    echo "OK. Thanks for playing."
  fi

  # debug "RECENT_TAGS" "$RECENT_TAGS"

  # Create the new version tag or nah?
  # NEW_TAG="$VERSION_DATE.$NEW_DOT_VERSION"

  # # So this is a hack to get the sort point as the number after the dot
  # arrIN=(${RECENT_TAGS//./ })
  # debug "arrIN0" "${arrIN[0]}"
  # debug "arrIN1" "${arrIN[1]}"
  # debug "arrIN2" "${arrIN[2]}"
  # debug "arrIN3" "${arrIN[3]}"
  # # echo ${arrIN[0]}
  # SORT_POINT=$((${#arrIN[0]} + 2))
  # debug "SORT_POINT" "$SORT_POINT"
  # LAST_TAG="$(echo $RECENT_TAGS | sort -rn -k 1.$SORT_POINT | head -n 1)"
  # debug "LAST_TAG" "$LAST_TAG"
  # exit 4

  # tagCreate "$TAG_PREFIX" "$DATE" "$PREVIOUS_DOT"
fi

if $DO_PUSH_ONLY; then
  chooseRecentTag "$DATE"
  debug "Picked Tag" "$CHOSEN_TAG"

  if [ -n "$CHOSEN_TAG" ]; then
    PUSH_READY="$CHOSEN_TAG"
  else
    echo "None selected. kthxbai"
    exit 0
  fi
fi

if [ -n $PUSH_READY ]; then
  tagPush "$PUSH_READY"
fi

exit 0
# if $PUSH_ONLY; then
#   loadRecentTags "*" $TODAY
#   debug "RECENT TAGS" "$RECENT_TAGS"

#   if [ -z "$RECENT_TAGS" ]; then
#     echo "There are no tags from today. Please create one first."
#     exit 1
#     # # TODO: Make this work?
#     # printf "No tags found for today. Would you like to create one? [y/N]: "

#     # # Create or nah?
#     # read -n 1 CREATE_OR_NAH
#     # printf "\n\n"
#     # if [ "$CREATE_OR_NAH" != "Y" ] && [ "$CREATE_OR_NAH" != "y" ]; then
#     #   echo "OK. Thanks for playing."
#     #   exit 0
#     # fi
#     # echo "TODO: Create the tag and continue"
#     # exit 1
#   fi
#   exit 1

#   PS3="Select a release to push: "
#   # git tag -l "*$TODAY*"
#   getTodaysTags '*' && TODAY_TAGS=$GLOBAL_RETURN
#   TODAY_TAGS=$(git tag -l "*$TODAY*")
#   debug "Today's tags" "$TODAY_TAGS"
#   if [ -z "$TODAY_TAGS" ]; then
#     printf "No tags found for today. Would you like to create one? [y/N]: "

#     # Create or nah?
#     read -n 1 CREATE_OR_NAH
#     printf "\n\n"
#     if [ "$CREATE_OR_NAH" != "Y" ] && [ "$CREATE_OR_NAH" != "y" ]; then
#       echo "OK. Thanks for playing."
#       exit 0
#     fi
#     echo "TODO: Create the tag and continue"
#     exit 1
#   fi
#   IFS=$'\n'
#   select TAG in $TODAY_TAGS; do
#     printf "\n\n"
#     if [ -n "$TAG" ]; then
#       printf "Found Tag '$NEW_TAG'. "
#       pushTag "$TAG"
#       exit 1 # shouldn't get here
#     fi
#     echo "None selected. kthxbai"
#     exit 0
#   done
#   unset IFS

#   exit 0
# fi

# exit 42

# # This isn't in an else so that I can break out of the previous one.
# if !$PUSH_ONLY; then
#   ###
#   # Get the latest version that was deployed today
#   #
#   # If there weren't any deployments for today, this will all just skip
#   ###
#   debug "prefix" "$PREFIX"
#   VERSION_DATE="$PREFIX$TODAY"
#   debug "version date" "$VERSION_DATE"

#   # Sort Point is used to allow us to sort numerically (adding 2 starts after the period)
#   SORT_POINT=$((${#VERSION_DATE} + 2))
#   debug "Git Command" "git tag -l \"$VERSION_DATE*\" | sort -rn -k 1.$SORT_POINT | head -n 1"
#   LATEST_TODAY="$(git tag -l "$VERSION_DATE*" | sort -rn -k 1.$SORT_POINT | head -n 1)"

#   PREVIOUS_DOT_VERSION="0"

#   # If there were no deployments today, we'll start from zero
#   if [ -n "$LATEST_TODAY" ]; then
#     echo "Today's Previous Deployment: '$LATEST_TODAY'"
#     PREVIOUS_DOT_VERSION="$(echo $LATEST_TODAY | sed 's/[^\.]*\.//')"
#     debug "Previous Dot Version" "$PREVIOUS_DOT_VERSION"
#   else
#     echo "First $STAGE Deployment Today"
#   fi

#   # Increment the previous version by one
#   NEW_DOT_VERSION="$(($PREVIOUS_DOT_VERSION + 1))"
#   debug "Next Dot Version" "$NEW_DOT_VERSION"

#   # Create the new version tag or nah?
#   NEW_TAG="$VERSION_DATE.$NEW_DOT_VERSION"
#   printf "Ready to create tag '$NEW_TAG'? [y/N]: "
#   read -n 1 CREATE_TAG
#   printf "\n\n"
#   if [ "$CREATE_TAG" != "Y" ] && [ "$CREATE_TAG" != "y" ]; then
#     echo "OK. Thanks for playing."
#     exit 0
#   fi

#   # Create the tag
#   debug "Creating Tag" "$NEW_TAG"
#   git tag -a "$NEW_TAG" -m "Deploy to $STAGE: $NEW_TAG"
#   printf "Created Tag '$NEW_TAG'. P to push the tag to GitHub or nah? [p/N]: "
# fi

# if [ -n "$CREATED_TAG" ]; then
#   pushTag "$CREATED_TAG"
#   exit 1 # shouldn't get here
# fi

# # # Push it up or nah?
# # read -n 1 PUSH_OR_NAH
# # printf "\n\n"
# # if [ "$PUSH_OR_NAH" != "P" ] && [ "$PUSH_OR_NAH" != "p" ]; then
# #   echo "KK I won't"
# #   exit 0
# # fi

# # # Push the tag; no output if we do this, since git will give us some
# # git push origin "$NEW_TAG"