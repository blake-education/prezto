
alias ag="noglob ag --smart-case -C 2"

function f() {
  find . -iname "*$**"
}
alias f="noglob f"

alias dl="curl -L -O"

alias d="sudo docker"

function naut () {
  local DIR="${1-.}"
  nautilus --no-desktop $DIR
}

alias apt-get="sudo apt-get"
alias aptitude="sudo aptitude"
alias apts="aptitude search"
alias apti="apt-get install"
