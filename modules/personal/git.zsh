alias gst='git status'
alias gco='git checkout'

alias gf="git fetch --prune"
compdef _git gf=git-fetch

alias ga="git add"
alias gap="git add -p"

if [ -x '/usr/local/bin/gitx' ]; then
  alias gx='gitx'
else
  function gx() {
    gitk --all $* &
  }
fi
alias gd='git diff'

alias gcola='git cola &'

alias gpoh="git push --set-upstream origin HEAD"

export git_concise_log_format='--pretty=format:%Cblue%h%d%Creset %ar %Cgreen%an%Creset %s'

alias glog='git log $git_concise_log_format'
alias gl='glog --graph'
alias glg='git log --graph --oneline --decorate'

function grh() {
  local branch
  branch=${1-HEAD}
  git reset --hard $branch
}

alias gcot='git checkout -t'
compdef _git gcot=git-checkout
alias gcob='git checkout -b'
compdef _git gcob=git-checkout
