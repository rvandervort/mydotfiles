#source ~/.bashrc
source ~/.bash_aliases

export PATH="$PATH:$HOME/bin"
export KEYPAIRNAME=amzn-isengard-us-east-1
export AMI=ami-d05e75b8


#git_branch() {
#  if [ -d .git ] ; then
#    branch=$(git branch | awk '/^\*/ { print $2 }')
#  else
#    unset branch
#  fi
#}

git_branch() {
  unset branch
  branch=$(git branch 2>/dev/null | awk '/^\*/ { print $2 }')
}

#command prompt customization
prompt() {
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[0;32m\]"
  local CYAN="\[\033[0;36m\]"
  local GRAY="\[\033[0;37m\]"
  local BLUE="\[\033[0;34m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local YELLOW="\[\033[1;33m\]"
  local RED="\[\033[1;31m\]"

  git_branch

  PS1="${YELLOW}\d \@ ${GREEN}\u@\h ${branch:+$LIGHT_BLUE$branch } ${CYAN}\w${GRAY}\n$  "
}

PROMPT_COMMAND=prompt
# retain $PROMPT_DIRTRIM directory components when the prompt is too long
PROMPT_DIRTRIM=3

# history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
# mappings for Ctrl-left-arrow and Ctrl-right-arrow for word moving
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'
bind '"\e\e[C": forward-word'
bind '"\e\e[D": backward-word'

bind Space:magic-space

export EDITOR=vim
export CLICOLOR=1

# Git Bash Completion
gbc="$HOME/.git-completion.bash"
[ -s $gbc ] && source $gbc

# if a local bash profile file exists, load it
# We'll use this as an override to anything that happens in the "OS-generic" file
lbp="$HOME/.local_bash_profile"
[ -s $lbp ] && source $lbp


# if a local bash aliases file exists, load it
lba="$HOME/.local_bash_aliases"
[ -s $lba ] && source $lba
