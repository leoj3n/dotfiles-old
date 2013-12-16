#
# Executes commands at login post-zshrc.
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin"
fi
