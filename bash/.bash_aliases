#! /bin/bash

RED='\033[1;31m'
WHITE='\033[1;37m'
CYAN='\033[4;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[0;33m'
ENDCOLOR='\033[0m'
SEP="${WHITE}|${ENDCOLOR}"
LOG_FORMAT="${CYAN}%h${ENDCOLOR} ${SEP} %s ${SEP} ${YELLOW}%an <%ae>${ENDCOLOR}"

# Env / vim
alias v='vim'
alias vba='vim ~/.bash_aliases'
alias vbp='vim ~/.bash_profile'
alias vssh='vim ~/.ssh/config'

# General NAV
alias ~='cd ~'
alias ll='ls -laG'
alias l='ls -laG'

alias ..2='cd ../../'
alias cda='cd ~/app'
alias euler='cd ~/Dropbox/Euler/Scala'

# git
alias gpom='git pull origin master'
alias gpo="git pull origin $branch"
alias gs='git status'
alias gg='git grep'
alias br='git checkout'
alias br+='git checkout -b'
alias bra='git branch -a'
alias gl1='git log -1'
alias gl2='git log -2'
alias gl3='git log -3'
alias gnuke='git reset --hard HEAD'
alias gfp='git fetch origin -p'

# Ruby / Rails / ActiveRecord
alias be='bundle exec'
alias ber='bundle exec rspec'
alias berf='bundle exec rspec --fail-fast'
alias rc='bundle exec rails console'
alias ras='bundle exec rails server -b 0.0.0.0'
alias vlm='vim db/migrate/`ls db/migrate | tail -1`'
alias mig='bundle exec rake db:migrate && bundle exec rake db:test:prepare'

# Other Dev
alias junit='java junit.textui.TestRunner'
alias clojure='java -cp ~/bin/clojure-1.5.1/clojure-1.5.1.jar clojure.main'
alias clj=clojure
alias ppjson="ruby -r json -e 'jj JSON.parse gets'"

alias bukkit="java -Xms1024 Xmx1024M -jar craftbukkit.jar"

function cdgem() {
  dir=$(dirname $(gem which "$@"))
  if [ -d $dir ]; then
    cd $dir
  else
    echo -e "Directory does not exist $dir"
  fi
}

# Launch vim with a tab for each file matching the git grep pattern
# $1 =
#   -o windows (split horizontal)
#   -O windows (split vertical)
#   -p tabs
function ggvim() {
  vim $1 `git grep -l $2`
}

function gvim() {
  vim $1 `grep -r -l $2 $3`
}

function gvimO {
  gvim "-O" $@
}

# Show a "nicely" formatted short git log
# expects first 'parameter' to be the number of commits to show
function gl() {
  res=$(git log -$@ --format="$LOG_FORMAT")
  echo -e "$res"
}

function cdl() {
  cd $@ && ll
}

function find_and_replace() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: find_and_replace [path] [regex pattern]"
  else
    # dangerous. will screw up .git if not careful!!
    find $1 -type f -exec sed -i '' $2 {} +
  fi
}

function cr() {
  javac $1.java && java $1 $2
}
