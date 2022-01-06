DATE=""
DO_CREATE_TAG=false
DO_PUSH_ONLY=false
TAG_PREFIX=""

function parseArgs() {
  DATE="$(date +%F)"

  local version="$1"
  # TODO: Add support for --help
  # TODO: Add support for other things?

  case $version in
    "rc" | "beta" | "demo")
      TAG_PREFIX="rc-v"
      DO_CREATE_TAG=true
      ;;
    "prod" | "full" | "release" )
      TAG_PREFIX="v"
      DO_CREATE_TAG=true
      ;;
    "push" )
      DO_CREATE_TAG=false
      DO_PUSH_ONLY=true
      ;;
    * )
      echo "Usage: release <rc | prod>"
      exit 1
      ;;
  esac
}