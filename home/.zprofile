#
# Executes commands at login pre-zshrc.
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
fi

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

export GOPATH="${HOME}/.go"

#
# Python
#

export PYTHONPATH="/usr/local/lib/python2.7/site-packages:${PYTHONPATH}"

#
# Set the list of directories that Zsh searches for programs.
#

path=(
  /opt/local/bin
  # /usr/local/{bin,sbin} # Homebrew wants /usr/local/bin at front of $PATH...
                          # We do that in /etc/paths
  /usr/local/mysql/bin
  $(brew --prefix josegonzalez/php/php54)/bin
  ${HOME}/.composer/bin
  ${GOPATH}/bin
  /Applications/Sublime\ Text.app/Contents/SharedSupport/bin
  ${HOME}/bin
  ${path}
)

#
# z
#

source "$(brew --prefix)/etc/profile.d/z.sh"

#
# Perlbrew
#

source "${HOME}/perl5/perlbrew/etc/bashrc"
