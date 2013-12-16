#
# Executes commands at login pre-zshrc.
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

#
# Ruby Version Manager
#

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#
# Perlbrew
#

source "$HOME/perl5/perlbrew/etc/bashrc"

#
# z
#

source "$(brew --prefix)/etc/profile.d/z.sh"

#
# Editors
#

export VISUAL='subl'
export EDITOR='vim'
export GIT_EDITOR='vim'
export PAGER='less'
export MANPAGER='less -s -M +Gg'

#
# GTK
#

export GTK_PATH='/usr/local/lib/gtk-2.0'

#
# Go
#

export GOPATH="$HOME/.go"

# Set the list of directories that Zsh searches for programs.
path=(
  /Applications/Sublime\ Text.app/Contents/SharedSupport/bin
  $HOME/bin
  /opt/local/bin
  # /usr/local/{bin,sbin} # Homebrew wants /usr/local/bin at front of $PATH...
  /usr/local/sbin         # We do that in /etc/paths and keep here /sbin
  /usr/local/mysql/bin
  $HOME/.composer/bin
  $HOME/.rvm/bin
  $GOPATH/bin
  $path
)
