CREATED_TAG=""
# TODAY="$(date +%F)"

tagCreate() {
  local prefix="$1"
  local date="$2"
  local version="$3"
  # local previousDot="$3"

  # local nextDot="1"
  local input

  if [ -z "$prefix" ]; then
    echo "No Prefix set for tag"
    exit 1
  fi
  if [ -z "$version" ]; then
    echo "No version set for tag"
    exit 1
  fi

  local newTag="$prefix$date.$version"

  printf "Ready to create tag '$newTag'? [y/N]: "
  read -n 1 input
  printf "\n\n"
  if [ "$input" != "Y" ] && [ "$input" != "y" ]; then
    echo "OK. Thanks for playing."
    exit 0
  fi

  # Create the tag
  debug "Creating Tag" "$newTag"
  git tag -a "$newTag" -m "New Release: $newTag"

  CREATED_TAG="$newTag"
}