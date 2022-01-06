pushd ./functions > /dev/null

source "./chooseRecentTag.sh"
source "./debug.sh"
source "./getVersionNumber.sh"
source "./loadRecentTags.sh"
source "./parseArgs.sh"
source "./tagCreate.sh"
source "./tagPush.sh"

popd  > /dev/null
