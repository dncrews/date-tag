CREATED_TAG=""

function tagCreate() {
  local prefix="$1"
  local version="$2"

  local input

  if [ -z "$prefix" ]; then
    echo "No Prefix set for tag"
    exit 1
  fi
  if [ -z "$version" ]; then
    echo "No version set for tag"
    exit 1
  fi

  local newTag="$prefix$DATE.$version"

  printf "Ready to create tag '$newTag'? [y/N]: "
  read -n 1 input
  printf "\n\n"
  if [ "$input" != "Y" ] && [ "$input" != "y" ]; then
    debug "Don't Create. Input" "$input"
    return 0
  fi

  # Create the tag
  debug "Creating Tag" "$newTag"
  git tag -a "$newTag" -m "New Release: $newTag"

  CREATED_TAG="$newTag"
}