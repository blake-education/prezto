
alias ag="noglob ag --smart-case -C 2"

function f() {
  find . -iname "*$**"
}
alias f="noglob f"

alias dl="curl -L -O"


function naut () {
  local DIR="${1-.}"
  nautilus --no-desktop $DIR
}

alias apt-get="sudo apt-get"
alias aptitude="sudo aptitude"
alias apts="aptitude search"
alias apti="apt-get install"

alias be="bundle exec"

#function fgem() {
  #local p="$1"
  #echo $(bundle show "$p") || $(dirname $(gem which $p))
#}

function cdgem() {
  cd "$(bundle show "$1")"
}
