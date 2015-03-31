bx_home=$HOME/Blake/bx

if [[ ! -d $bx_home/.git ]]; then
  echo "sorry to break it to you, but it seems you don't have bx installed"
  echo "go here to find out what to do: https://github.com/blake-education/bx"
  return 1
fi

eval "$($bx_home/bin/bx init -)"

alias be='bundle exec'
