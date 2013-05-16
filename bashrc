export INPUTRC="~/.inputrc"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:~/bin"
export MANPATH="$MANPATH:/opt/local/man:/usr/local/mysql/man"
export EDITOR=`which vim`
# Whenever displaying the prompt, write the previous line to disk.
export PROMPT_COMMAND="history -a"
export CC="/Applications/Xcode.app/Contents/Developer/usr/bin/gcc"

# Setup Amazon EC2 Command-Line Tools
export EC2_HOME=~/.ec2
export PATH=$PATH:$EC2_HOME/bin
export EC2_PRIVATE_KEY=$HOME/.ssh/electnext2.pem
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/

# Source global definitions
[[ -s "/etc/bashrc" ]] && source "/etc/bashrc"

# Source global aliases
[[ -s "$HOME/.aliases.sh" ]] && source "$HOME/.aliases.sh"

# Bash completion
[[ -s `brew --prefix`/etc/bash_completion ]] && source `brew --prefix`/etc/bash_completion

# Git completion
[[ -s "$HOME/.git-completion.sh" ]] && source "$HOME/.git-completion.sh"

# knife completion
#[[ -s "$HOME/.knife-completion.sh" ]] && source "$HOME/.knife-completion.sh"

# Load RVM into a shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load NVM into a shell session
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

# Autojump
[[ -s `brew --prefix`/etc/autojump ]] && source `brew --prefix`/etc/autojump

# Init rbenv
#eval "$(rbenv init -)"

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# Ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Autofix typos
shopt -s cdspell

# Check the window size after each command and, if necessary,
# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make Bash append rather than overwrite the history on disk.
shopt -s histappend

# Make 'less' more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi

function parse_git_deleted {
  [[ $(git status 2> /dev/null | grep deleted:) != "" ]] && echo "-"
}
function parse_git_added {
  [[ $(git status 2> /dev/null | grep "Untracked files:") != "" ]] && echo '+'
}
function parse_git_modified {
  [[ $(git status 2> /dev/null | grep modified:) != "" ]] && echo "*"
}
function parse_git_dirty {
  # [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "☠"
  echo "$(parse_git_added)$(parse_git_modified)$(parse_git_deleted)"
}
function parse_git_branch {
  echo "$(parse_git_dirty)$(__git_ps1 '%s')"
}

export LSCOLORS='Exfxcxdxbxegedabagacad'

if [ "$color_prompt" = yes ]; then
  PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u@\H \[$(tput setaf 4)\]\w\[$(tput setaf 3)\] \$(parse_git_branch)\[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 1)\]\$(~/.rvm/bin/rvm-prompt) \[$(tput sgr0)\]> "
else
  PS1="\u@\H \w \$(parse_git_branch)\n\$(~/.rvm/bin/rvm-prompt) > "
fi
unset color_prompt

#export NODE_PATH="/usr/local/lib/node:/Users/mertonium/.npm:/usr/local/share/npm/bin:/usr/local/lib/node_modules:$NODE_PATH";
#ssh-add ~/.ssh/id_dsa

# Setup IAM Cli
export AWS_IAM_HOME=~/Code/IAMCli-1.5.0/
export JAVA_HOME=/usr
export AWS_CREDENTIAL_FILE=${AWS_IAM_HOME}account-key
PATH=${AWS_IAM_HOME}bin:$PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
