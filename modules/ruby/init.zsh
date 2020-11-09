#
# Configures Ruby local gem installation, loads version managers, and defines
# aliases.
#
# Authors: Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load RVM into the shell session.
if [[ ! -z "$ASDF_DIR" && -d "$ASDF_DIR/plugins/ruby" || -d "$HOME/.asdf/plugins/ruby" ]]; then
  # nothing necessary for asdf <3

elif [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # Unset AUTO_NAME_DIRS since auto adding variable-stored paths to ~ list
  # conflicts with RVM.
  unsetopt AUTO_NAME_DIRS

  # Source RVM.
  source "$HOME/.rvm/scripts/rvm"

elif [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  # Load manually installed rbenv into the shell session.
  path=("$HOME/.rbenv/bin" $path)
  eval "$(rbenv init - --no-rehash zsh)"

elif (( $+commands[rbenv] )); then
  # Load package manager installed rbenv into the shell session.
  eval "$(rbenv init - --no-rehash zsh)"

elif (( $+commands[chruby-exec] )); then
  # Load package manager installed chruby into the shell session.
  source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
  if zstyle -t ':prezto:module:ruby:chruby' auto-switch; then
    source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"

    # If a default Ruby is set, switch to it.
    chruby_auto
  fi

else
  # Prepend local gems bin directories to PATH.
  path=($HOME/.gem/ruby/*/bin(N) $path)
fi

# Return if requirements are not found.
if (( ! $+commands[ruby] && ! ( $+commands[rvm] || $+commands[rbenv] ) )); then
  return 1
fi

#
# Aliases
#

# General
alias rb='ruby'

# Bundler
if (( $+commands[bundle] )); then
  alias rbb='bundle'
  alias rbbe='bundle exec'
  alias rbbi='bundle install --path vendor/bundle'
  alias rbbl='bundle list'
  alias rbbo='bundle open'
  alias rbbp='bundle package'
  alias rbbu='bundle update'
  alias rbbI='rbbi \
    && bundle package \
    && print .bundle       >>! .gitignore \
    && print vendor/assets >>! .gitignore \
    && print vendor/bundle >>! .gitignore \
    && print vendor/cache  >>! .gitignore'
fi
