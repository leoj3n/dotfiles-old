eval "$(hub alias -s)"

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
#PATH=/usr/local/bin:$(path_remove /usr/local/bin)
#export PATH

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# http://superuser.com/questions/31744/how-to-get-git-completion-bash-to-work-on-mac-os-x

if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
. `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

if [ -f `brew --prefix`/etc/bash_completion.d/git-prompt.sh ]; then
    . `brew --prefix`/etc/bash_completion.d/git-prompt.sh
fi

source /usr/local/share/zsh/site-functions/git-completion.bash

# https://makandracards.com/makandra/524-show-the-current-git-branch-on-your-bash-prompt

export PS1='\[\033[01;32m\]\h\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 "(%s)") \[\033[01;34m\]$\[\033[00m\] '

# git aliases

alias gco='git co'
alias gci='git ci'
alias grb='git rb'
alias gs='git status'

# other aliases

alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
# IP addresses
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whois="whois -h whois-servers.net"
# Flush Directory Service cache
alias flush="dscacheutil -flushcache"
# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# functions

# From http://stackoverflow.com/questions/370047/#370255
function path_remove() {
  IFS=:
  # convert it to an array
  t=($PATH)
  unset IFS
  # perform any array operations to remove elements from the array
  t=(${t[@]%%$1})
  IFS=:
  # output the new array
  echo "${t[*]}"
}

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
