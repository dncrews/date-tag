debug() {
  debug2 "$@"
  # if [ -n "$DEBUG" ]; then
  #   printf "$@ \n"
  # fi
}

debug2() {
  local name="$1"
  local value="$2"

  case "$DEBUG" in
    1 | "y")
      local pvalue
      if [[ $# > 1 ]]; then
        pvalue=": '$value'"
      fi

      printf "$name$pvalue\n"
      ;;
    2 | "p")
      local pname
      local pvalue
      local lengthOfName=$(printf "$name" | wc -c)
      local dashes="$(printf "%${lengthOfName}s" | tr ' ' '-')"

      if [[ $# > 1 ]]; then
        pname="$(printf "$name" | awk '{ print toupper($0) }')"
        pvalue="'$value'"
      else
        pname="$name"
        pvalue=""
      fi

      printf "\n$pname\n$dashes\n$pvalue\n"
      ;;
    *)
      return 0
      ;;
  esac
}
