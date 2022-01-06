DATE=""
DO_CREATE_TAG=false
# DO_PUSH=false
PREFIX=""
PUSH_ONLY=false
DO_PUSH_ONLY=false
STAGE=""
TAG_PREFIX=""
TODAY=""

function parseArgs() {
  TODAY="$(date +%F)"
  DATE="$(date +%F)"

  local version="$1"
  # TODO: Add support for --help
  # TODO: Add support for other things?

  case $version in
    "rc" | "beta" | "demo")
      PREFIX="rc-v"
      TAG_PREFIX="rc-v"
      STAGE="Demo"
      DO_CREATE_TAG=true
      ;;
    "prod" | "full" | "release" )
      PREFIX="v"
      TAG_PREFIX="v"
      STAGE="Production"
      DO_CREATE_TAG=true
      ;;
    "push" )
      # PREFIX="--"
      # TAG_PREFIX="--"
      # STAGE="--"
      DO_CREATE_TAG=false
      # DO_PUSH=true
      DO_PUSH_ONLY=true
      PUSH_ONLY=true
      ;;
    * )
      echo "Usage: release <rc | prod>"
      exit 1
      ;;
  esac
}