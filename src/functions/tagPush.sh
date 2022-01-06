function tagPush() {
  local tagName="$1"
  # local promptPrefix="$2"
  local input

  printf "Ready to Push "$tagName" or nah? P to push the tag to GitHub? [p/N]: "
  read -n 1 input
  bold=$(tput bold)
  normal=$(tput sgr0)
  underline=$(tput smul)
  removeUnderline=$(tput rmul)

  printf "\n\n"
  # if [ "$input" != "P" ] && [ "$input" != "p" ]; then
  case "$input" in
    y)
      printf "${underline}${bold}Notice: Only 'P' will push the tag to GitHub\n"
      printf "This is for the sake of safety so we don't do it accidentally${removeUnderline}${normal}\n\n"
      printf "If you want to push the tag you just creatd, you can run:\n"
      printf "${bold}date-tag push\n${normal}"
      ;;
    p)
      # Push the one tag; no output if we do this, since git will give us some
      git push origin "refs/tags/$tagName"
      ;;
    *)
      echo "KK I won't"
      ;;
  esac
}