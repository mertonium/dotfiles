export INPUTRC="~/.inputrc"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/sbin:~/bin"
export MANPATH="$MANPATH:/opt/local/man:/usr/local/mysql/man"
export EDITOR=`which vim`
# Whenever displaying the prompt, write the previous line to disk.
export PROMPT_COMMAND="history -a"
export CC="/Applications/Xcode.app/Contents/Developer/usr/bin/gcc"
export GOPATH="/Users/jmertens/Code/gocode"
export GOROOT=/usr/local/opt/go/libexec
export PATH="$PATH:$GOROOT/bin"

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
eval "$(rbenv init -)"

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
  PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u \[$(tput setaf 4)\]\w\[$(tput setaf 3)\] \$(parse_git_branch)\[$(tput sgr0)\]\n\[$(tput bold)\]\[$(tput setaf 1)\]\$(rbenv version | sed -e 's/ .*//')\[$(tput sgr0)\]/\[\033[38;5;91m\]\$(nvm current)\[$(tput sgr0)\] > "
else
  PS1="\u@\H \w \$(parse_git_branch)\n\$(~/.rvm/bin/rvm-prompt) > "
fi
unset color_prompt

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

function nodes() {
  cd ~/Code/deploy
  git pull origin master

  if [ -n "$2" ]; then
    ORG=$2 bundle exec knife search node role:$1
  else
    ORG=$1 bundle exec knife search node 'role:base'
  fi
  cd -
}

# Export Salesforce Marketing Cloud keys
if [ -f ~/.fuelcfg ]; then
  . ~/.fuelcfg
  export FUELSDK_ENVIRONMENT
  export FUELSDK_SFTP_USER
  export FUELSDK_CLIENT_ID_CHANGE_ORG_INC
  export FUELSDK_CLIENT_SECRET_CHANGE_ORG_INC
  export FUELSDK_CLIENT_ID_GLOBAL_TRIGGERED_MESSAGES
  export FUELSDK_CLIENT_SECRET_GLOBAL_TRIGGERED_MESSAGES
  export FUELSDK_CLIENT_ID_PETITION_UPDATES
  export FUELSDK_CLIENT_SECRET_PETITION_UPDATES
  export FUELSDK_CLIENT_ID_CAMPAIGNS_US
  export FUELSDK_CLIENT_SECRET_CAMPAIGNS_US
  export FUELSDK_CLIENT_ID_CAMPAIGNS_ES
  export FUELSDK_CLIENT_SECRET_CAMPAIGNS_ES
fi

# Export AWS KEYS
if [ -f ~/.awscfg ]; then
  . ~/.awscfg
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
fi

# Export Github Access token (for graphql test app)
if [ -f ~/.githubcfg ]; then
  . ~/.githubcfg
  export GRAPHQL_GH_ACCESS_TOKEN
fi

# Export Jenkins info
if [ -f ~/.jenkinscfg ]; then
  . ~/.jenkinscfg
  export CHANGE_USERNAME CHANGE_JENKINS_USER_TOKEN
fi

PATH="/Users/jmertens/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/jmertens/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/jmertens/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/jmertens/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/jmertens/perl5"; export PERL_MM_OPT;

# Unset the deprecated ruby GC vars
unset RUBY_FREE_MIN
unset RUBY_HEAP_MIN_SLOTS


# Java version of rbenv or nvm
alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d_\d\d" | cut -d , -f 1 | colrm 1 4 | grep -v Home'
function java_use() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
  export PATH=$JAVA_HOME/bin:$PATH
  java -version
}

export ERL_AFLAGS="-kernel shell_history enabled"
# Initialize asdf
source /usr/local/opt/asdf/asdf.sh

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

MESSAGE_BUS_DEV_STAGE=dev-jmertens

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/jmertens/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash ] && . /Users/jmertens/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/jmertens/.config/yarn/global/node_modules/tabtab/.completions/sls.bash ] && . /Users/jmertens/.config/yarn/global/node_modules/tabtab/.completions/sls.bash
# Added by change/development_environment script
export WORKDIR="/Users/jmertens/Code"
export PATH="$WORKDIR/development_environment/bin:$PATH"
