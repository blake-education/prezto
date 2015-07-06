alias dockerenv='eval $(boot2docker shellinit)'

#b2d=
#if command -v boot2docker > /dev/null; then
  #b2d=1
  #if [[ $(boot2docker status) = "running" ]]; then
    #dockerenv
  #fi
#fi


with_boot2docker() {
  $*
}

#with_boot2docker() {
  #if [[ $b2d ]]; then
    #if [[ $(boot2docker status) = "running" ]]; then
      #$*
    #else
      #echo "boot2docker not running, starting it"
      #boot2docker up
      #dockerenv
      #$*
    #fi
  #else
    #$*
  #fi
#}

alias docker="with_boot2docker docker"
alias d="docker"
alias dc="with_boot2docker docker-compose"
