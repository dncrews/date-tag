tagPush() {
  local tagName="$1"
  # local promptPrefix="$2"
  local input

  printf "Ready to Push "$tagName" or nah? P to push the tag to GitHub? [p/N]: "
  read -n 1 input

  printf "\n\n"
  # if [ "$input" != "P" ] && [ "$input" != "p" ]; then
  case "$input" in
    y)
      echo "Notice: Only 'P' will push the tag to GitHub"
      echo "This is for the sake of safety so we don't do it accidentally"
      ;;
    p)
      # Push the tag; no output if we do this, since git will give us some
      git push --tags origin "$tagName"
      ;;
    *)
      echo "KK I won't"
      ;;
  esac
  # if [ "$input" != "p" ]; then
  #   echo "KK I won't"
  #   exit 0
  # fi


}