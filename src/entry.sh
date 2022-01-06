#!/usr/bin/env bash

if [[ "$0" =~ "entry.sh" ]]; then
  echo "$(tput setaf 1)$(tput bold)$(tput setab 7)ERROR:This script should not be run directly. Please use 'yarn|npm start'$(tput sgr0)"
  exit 1
fi

# This sets our matching to case insensitive
# https://unix.stackexchange.com/a/395686
shopt -s nocasematch

TAG_TO_PUSH=""

parseArgs "$@"

debug "Date" "$DATE"
debug "Do create tag" "$DO_CREATE_TAG"
debug "P" "$TAG_PREFIX"
debug "PO" "$DO_PUSH_ONLY"

if $DO_CREATE_TAG; then
  getVersionNumber "$TAG_PREFIX"
  debug "Dot Version" "$VERSION_NUMBER"

  tagCreate "$TAG_PREFIX" "$VERSION_NUMBER"

  debug "Created Tag" "$CREATED_TAG"

  if [ -n "$CREATED_TAG" ]; then
    TAG_TO_PUSH="$CREATED_TAG"
  else
    echo "OK. Thanks for playing."
  fi
fi

if $DO_PUSH_ONLY; then
  chooseRecentTag
  debug "Picked Tag" "$CHOSEN_TAG"

  if [ -n "$CHOSEN_TAG" ]; then
    TAG_TO_PUSH="$CHOSEN_TAG"
  else
    echo "None selected. kthxbai"
    exit 0
  fi
fi


if [[ "$TAG_TO_PUSH" != "" ]]; then
  tagPush "$TAG_TO_PUSH"
fi

exit 0