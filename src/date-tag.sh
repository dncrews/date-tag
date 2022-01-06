#!/usr/bin/env bash

# This sets our matching to case insensitive
# https://unix.stackexchange.com/a/395686
shopt -s nocasematch

function loadDeps() {
  FULL_PATH="$(realpath $0)"
  __DIRNAME__="$(dirname $FULL_PATH)"

  # relative source only works if you're actually in that directory
  pushd $__DIRNAME__ > /dev/null
  source "./functions/functions.sh"
  popd > /dev/null
}

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

loadDeps
parseArgs "$@"

debug "Today" "$DATE"
debug "Today" "$TODAY"
debug "Do create tag" "$DO_CREATE_TAG"
debug "P" "$PREFIX"
debug "S" "$STAGE"
debug "PO" "$PUSH_ONLY"

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

if [ -n $TAG_TO_PUSH ]; then
  tagPush "$TAG_TO_PUSH"
fi

exit 0