p_scanned_list=$HOME/.project_scanned_list
p_custom_list=$HOME/.project_list
project_roots=($HOME/dev $HOME/Dropbox/dev $HOME/Blake)

# main commands
# cd to a project
unalias p
p() {
  if [[ -z "$1" ]]; then
    cd $(git rev-parse --show-cdup)
  else
    cd "$(project_path $1)"
  fi
}


# open a project in $EDITOR
m() {
  if [[ $# -eq 0 ]]; then
    vim .
  else
    vim $(project_resolve $1)
  fi
}


add_project() {
  local base
  base=${1-$(basename $PWD)}
  
  echo "$base,$PWD" >> $p_custom_list
}

# reindex the projects
projects_reindex() {
  rm -f $p_scanned_list
  touch $p_scanned_list

  local -a lines
  for root in $project_roots; do
    lines+=($(find $root -depth 2 -name .git -exec dirname {} \;))
  done

  for line in $lines; do
    echo $(basename $line),$line >> $p_scanned_list
  done
}


# open the project db in sqlite repl
projects_sqlite() {
  sqlite3 $p_scanned_list
}


project_resolve() {
  local project_path
  
  path=$(project_path $1)

  echo "${path:-$1}"
}

read_projects() {
  cat $p_custom_list $p_scanned_list 
}

project_list() {
  read_projects | cut -d, -f1
}

project_path() {
  read_projects | command grep "^$1," | cut -d, -f2 | head -1
}

project_search() {
  if [[ $1 ]]; then

    read_projects | cut -d, -f1 | command grep "^$1"
  else
    read_projects | cut -d, -f1
  fi
}


compctl -K project_search p
compctl -K project_search -g '*' m
