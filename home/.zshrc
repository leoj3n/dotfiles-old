#
# Executes commands at the start of an interactive session.
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

###############################################################################
# Options
###############################################################################

# setopt SH_WORD_SPLIT

###############################################################################
# Variables
###############################################################################

readonly CASKROOM='/opt/homebrew-cask/Caskroom'
readonly TAPS="$(brew --repository)/Library/Taps"
readonly VLC="${CASKROOM}/vlc/2.1.1/VLC.app/Contents/MacOS/VLC"

###############################################################################
# Autoloads
###############################################################################

autoload -U colors && colors
autoload bashcompinit && bashcompinit

###############################################################################
# Filetype Aliases
###############################################################################

alias -s git=gfc
alias -s js=wget
alias -s less=wget

###############################################################################
# Homeshick
###############################################################################

source "${HOME}/.homesick/repos/homeshick/homeshick.sh"

fpath=(
  ${HOME}/.homesick/repos/homeshick/completions
  ${fpath}
)

###############################################################################
# GitHub CLI
###############################################################################

eval "$(gh alias -s)"
# eval "$(hub alias -s)"

###############################################################################
# WP-CLI Completion
###############################################################################

source "${HOME}/.composer/vendor/wp-cli/wp-cli/utils/wp-completion.bash"

###############################################################################
# Git Aliases
###############################################################################

#
# Fetch
#

alias gfa='gf --all'
alias gfccd=git_fetch_change_directory

#
# Add
#

alias giaa='gia --all'
alias giap=git_add_pattern

#
# Commit
#

alias gcam='gca -m'

#
# Remote
#

alias gRe='gR set-url'

#
# Push
#

alias gpuo='gp -u origin'
alias gpul='gp -u leoj3n'
alias gpuom='gpuo master'

#
# Pull requests
#

alias gpr='g pull-request'
alias gbr=git_branch_from_pull_request

#
# Assume unchanged
#

alias gih='g update-index --assume-unchanged'
alias gis='g update-index --no-assume-unchanged'
alias gdh='g ls-files -v | grep "^h " | cut -d" " -f2-'

#
# Utility
#

alias gfx=git_fix
alias gic=git_uppercase

###############################################################################
# Target and fix files in the git index
#
# Default action is to remove unstaged deleted files
#
# Arguments:
#   [kind]
#   [action]
# Returns:
#   fixed file status
###############################################################################

function git_fix() {
  local knd='.D'
  local act='rm'

  if [[ -n "$1" ]]; then
    knd="$1"
  fi

  if [[ -n "$2" ]]; then
    act="$2"
  fi

  gws | awk "/^${knd} .*$/ {print \$2}" | xargs git "${act}" -f
}

###############################################################################
# Uppercase the first letter of a git-indexed filename
#
# Arguments:
#   path
# Returns
#   none
###############################################################################

function git_uppercase() {
  local pth="$1"

  g mv --force \
    "${pth}" "$(tr '[:lower:]' '[:upper:]' <<< ${pth:0:1})${pth:1}"
}

###############################################################################
# Fetch a pull request into a git branch
#
# Arguments:
#   pull request ID
#   [branch name]
# Returns:
#   new git branch
###############################################################################

function git_branch_from_pull_request() {
  local bnm="pr-$1"

  if [[ -n "$2" ]]; then
    bnm="$2"
  fi

  gf origin "pull/$1/head:${bnm}" && gco "${bnm}"
}

###############################################################################
# Add files to git index by a pattern
#
# Arguments:
#   pattern
# Returns:
#   files added to the index
###############################################################################

function git_add_pattern() {
  g ls-files -co --exclude-standard | grep "$1" | xargs git add
}

###############################################################################
# Clone a git repository then change into the directory
#
# Arguments:
#   repository
#   [path]
# Returns:
#   cloned repository location
###############################################################################

function git_fetch_change_directory() {

  #
  # Cut path from repository name
  #

  local pth="${1##*/}"

  pth="${pth%.*}"

  #
  # Set path manually, if passed as second argument
  #

  if [[ -n "$2" ]]; then
    local pth="$2"
  fi

  #
  # Clone the repository using gh
  #

  gh clone "$1" && cd "${pth}"
}

###############################################################################
# WordPress Aliases
###############################################################################

alias -g wpa='~/src/wp/apps'
alias -g wpp='~/src/wp/plugs'
alias -g apacheroots='~/Sites/www/dev/1/wp-content/themes/roots'

###############################################################################
# Homebrew Aliases
###############################################################################

alias brl='brew list'
alias bri='brew info'
alias brh='brew home'
alias brs='brew search'
alias brup='brew update'
alias brug='brew upgrade'
alias brin='brew install'
alias brun='brew uninstall'

alias brcl='brew cask list'
alias brci='brew cask info'
alias brce='brew cask edit'
alias brch='brew cask home'
alias brcs='brew cask search'
alias brcc='brew cask create'
alias brcin='brew cask install'
alias brcun='brew cask uninstall'
alias brcls=brew_cask_list_since

###############################################################################
# Meteor Aliases
###############################################################################

alias m='meteor'
alias mdbg='NODE_OPTIONS="--debug-brk" mrt run'

###############################################################################
# Bower Aliases
###############################################################################

alias bower='noglob bower'

###############################################################################
# Vagrant Aliases
###############################################################################

alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias vr='vagrant reload'
alias vd='vagrant destroy'
alias vp='vagrant provision'
alias vpu='vassh'\
' sudo WP_TESTS_DIR="/home/vagrant/svn/wp-tests" vendor/bin/phpunit'

###############################################################################
# Sublime Aliases
###############################################################################

alias epp='ep "${PWD##*/}"'
alias ep=sublp

###############################################################################
# Taskwarrior Aliases
###############################################################################

alias tl='task ls'
alias ta='task add'
function to() { task "$1" done }
function td() { task "$1" delete }

###############################################################################
# Interactive Program Aliases
###############################################################################

alias v=vim
alias bc='bc -l'
alias chat='finch'
alias irc='weechat'
alias pod='podbeuter'
alias rss='newsbeuter'
alias pandora='pianobar'
alias soundcloud='cloudruby'
alias youtube='gtk-youtube-viewer'
alias nw='~/Applications/node-webkit.app/Contents/MacOS/node-webkit'

###############################################################################
# Non-Interactive Program Aliases
###############################################################################

alias t=type
alias hs=homeshick
alias skel=skelgen
alias se=smartextract
alias sha1='openssl sha1'

###############################################################################
# List Aliases
###############################################################################

alias lsd='ls -Ad .*'
alias lss='ls -al | grep .-\>'

#
# List numerical permissions
#

function lsmod() {
  ls -l | awk '{k=0;for(i=0;i<=8;i++) \
    k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}'
}

#
# List open files
#

alias pp='sudo lsof -i'

###############################################################################
# Change Directory Aliases
###############################################################################

alias ...='cd ../..'
alias -- -='cd -' # FIXME: Not working in zsh prezto

###############################################################################
# Shell/Dotfiles Aliases
###############################################################################

alias cl='c; l'
alias -g zpr='~/.zprezto'

###############################################################################
# Internet Aliases
###############################################################################

alias snginx='nginx -s stop'
alias flush='sudo killall -HUP mDNSResponder'
alias priv='privoxy "/usr/local/etc/privoxy/config"'

#
# Local IP
#

alias localip='ipconfig getifaddr en0'
alias ip='dig +short "myip.opendns.com" "@resolver1.opendns.com"'
function ips() {
  ifconfig -a \
  | grep -o \
    'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' \
  | sed -e 's/inet6* //'
}

#
# Remote IP
#

alias whois='whois -h "whois-servers.net"'

#
# Dnsmasq
#

alias -g masq='"$(brew --prefix)/etc/dnsmasq.conf"'
function remasq() {
  sudo launchctl stop 'homebrew.mxcl.dnsmasq' \
  && sudo launchctl start 'homebrew.mxcl.dnsmasq'
}

###############################################################################
# Clipboard Aliases
###############################################################################

alias -g vv='"$(pbp)"'
alias cpy='tr -d "\n" | pbcopy'
alias pubkey='more ~"/.ssh/id_rsa.pub" | cpy | echo "Key copied to clipboard."'

###############################################################################
# Delete Aliases
###############################################################################

#
# Recursively delete `.DS_Store` files
#

alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'

#
# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
#

alias emptytrash='sudo rm -rfv /Volumes/*/.Trashes;'\
'sudo rm -rfv ~/.Trash/*;'\
'sudo rm -rfv /private/var/log/asl/*.asl'

###############################################################################
# URL Aliases
###############################################################################

#
# URL-encode string
#

alias urlencode='python -c'\
' "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

#
# URL-decode string
#

alias urldecode='python -c'\
' "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1]);"'

###############################################################################
# Load/Unload Aliases
###############################################################################

alias reload='exec "${SHELL}" -l'

alias kextl='sudo kextload "/System/Library/Extensions/AppleUSBTopCase'\
'.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext"'

alias kextu='sudo kextunload "/System/Library/Extensions/AppleUSBTopCase'\
'.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext" > /dev/null 2>&1'

###############################################################################
# Mac OS X Aliases
###############################################################################

alias ss='open "/System/Library/Frameworks/ScreenSaver'\
'.framework/Versions/A/Resources/ScreenSaverEngine.app"'

alias dbon='defaults write "com.apple.dashboard" "mcx-disabled" -boolean NO'\
' && killall Dock'

alias dboff='defaults write "com.apple.dashboard" "mcx-disabled" -boolean YES'\
' && killall Dock'

alias sloff='sudo launchctl unload -w "/System/Library/LaunchDaemons/com'\
'.apple.metadata.mds.plist"'

alias slon='sudo launchctl load -w "/System/Library/LaunchDaemons/com'\
'.apple.metadata.mds.plist"'

###############################################################################
# Dash.app Lookup
#
# Arguments:
#   query string
# Returns:
#   none
###############################################################################

function da() {
  o "dash://$1"
}

###############################################################################
# Search Mac OS X Dictionary
#
# Arguments:
#   word part
# Returns:
#   matching words
###############################################################################

function ws() {
  grep --color -i "$1" '/usr/share/dict/words'
}

###############################################################################
# List casks added since a human-readable time
#
# Arguments:
#   since
# Returns:
#   list of casks
###############################################################################

function brew_cask_list_since() {
  local since='5 days'

  if [[ -n "$*" ]]; then
    since="$*"
  fi

  cd "${TAPS}/phinze-cask" && git log \
    --since="${since}" --name-status --pretty='format:' 'Casks/' \
    | grep '^A' | sed 's!^.*Casks/\(.*\).rb$!\1!'
}

###############################################################################
# Generate phpunit-skelgen CLI args using a single input
#
# Arguments:
#   class
#   [path]
# Returns:
#   location of test
#
# Expects to run from 'src/YourPackage' like so:
#   $ skelgen My_Class          # single argument
#   $ skelgen My_Class My/Class # two arguments; second is an optional path
#
# These examples are equivelant and both return:
#   > Wrote skeleton for "My_ClassTest" to
#   >  "../../tests/My/ClassTest.php".
###############################################################################

function skelgen() {
  local ns="${PWD##*/}\\"
  local tst='../../tests/'
  local out="$(echo "${1%.php}" | tr '_' '/')"
  local class="$(echo "${1%.php}" | tr '/' '_')"

  local src="${out}"

  if [[ -n "$2" ]]; then
    out="$2"
  fi

  if $(echo "${out}" | grep --quiet '/'); then
    local begin="$(echo "${out}" | cut -d/ -f1)"
  fi

  mkdir -p "${tst}${begin}"

  phpunit-skelgen --bootstrap '../../vendor/autoload.php' --test \
    -- "${ns}${class}" "${src}.php" "${ns}${class}Test" "${tst}${out}Test.php"
}

###############################################################################
# Opens a Sublime Text project and prints all folder paths
#
# Arguments:
#   filename
# Returns:
#   project folder paths
###############################################################################

function sublp() {
  local proj="~/.sublime-project/$1.sublime-project"

  #
  # Open Sublime project
  #

  subl --project "${proj}"

  #
  # Print project folders
  #

  awk -F'[,:]' \
    '{for(i=1;i<=NF;i++){if($i~/path\042/){print $(i+1)}}}' \
    "${proj}"
}

###############################################################################
# Shortens GitHub URL
#
# Arguments:
#   GitHub URL
#   vanity URL
# Returns:
#   short/vanity URL
###############################################################################

function ghio() {
  curl -i 'http://git.io' -F "url=https://github.com/$1" -F "code=$2"
}

###############################################################################
# Converts YouTube to GIF
#
# Arguments:
#   YouTube URL
# Returns:
#   created gif location
###############################################################################

function ytgif() {
  local tmp='.ytgif'
  local flv="${tmp}/yt.flv"
  local rnd="${tmp}/${RANDOM}"

  youtube-dl -o "${flv}" "$1"

  local ytsize="$(wc -c < "${flv}")"

  mplayer "${flv}" \
    -endpos "$[ytsize * .75]b" \
    -sstep 30 \
    -vo "jpeg:outdir=${rnd}" ':smooth=30:progressive' \
    -vf 'scale=320:240' \
    -nosound

  convert \
    -delay 30 \
    -loop 0 \
    "${rnd}/*.jpg" \
    'yt.gif'

  rm -rf "${rnd}"
  rm -ri '.ytgif'

  echo 'yt.gif has been created'
}

###############################################################################
# Extracts or mounts files
#
# nparikh.org/notes/zshrc.txt
#
# Arguments:
#   path to archive
# Returns:
#   location of extracted files
###############################################################################

smartextract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar -jxvf "$1"                    ;;
      *.tar.gz)  tar -zxvf "$1"                    ;;
      *.bz2)     bunzip2 "$1"                      ;;
      *.dmg)     hdiutil mount "$1"                ;;
      *.gz)      gunzip "$1"                       ;;
      *.tar)     tar -xvf "$1"                     ;;
      *.tbz2)    tar -jxvf "$1"                    ;;
      *.tgz)     tar -zxvf "$1"                    ;;
      *.zip)     unzip "$1"                        ;;
      *.ZIP)     unzip "$1"                        ;;
      *.pax)     cat "$1" | pax -r                 ;;
      *.pax.Z)   uncompress "$1" --stdout | pax -r ;;
      *.Z)       uncompress "$1"                   ;;
      *)         echo "'$1' cannot be extracted/mounted via smartextract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

###############################################################################
# Back up a file
#
# commandlinefu.com/commands/view/7294/backup-a-file-with-a-date-time-stamp
#
# Arguments:
#   file
# Returns:
#   backed up file location
###############################################################################

buf() {
  local oldname="$1"

  if [[ -n "${oldname}" ]]; then
    local datepart="$(date +%Y-%m-%d)"
    local firstpart="$(echo "${oldname}" | cut -d '.' -f 1)"
    local newname="$(echo "${oldname}" \
      | sed s/"${firstpart}"/"${firstpart}.${datepart}"/)"

    cp -R "${oldname}" "${newname}"

    echo "${newname} has been created."
  fi
}

###############################################################################
# Relink target-file to source-file
#
# github.com/adamv/dotfiles/blob/master/install#L3-L16
#
# Arguments:
#   target
#   path
# Returns:
#   linked file location
###############################################################################

relink() {
  if [[ -h "$1" ]]; then

    #
    # Recreate symbolic link
    #

    echo "Relinking $1"

    rm "$1"
    ln -sn "$2" "$1"

  elif [[ ! -e "$1" ]]; then

    #
    # Create new symbolic link
    #

    echo "Linking $1 to $2"
    ln -sn "$2" "$1"

  else

    #
    # Skip creating symbolic link
    #

    echo "$1 exists as a real file, skipping."

  fi
}

###############################################################################
# Change working directory to the top-most Finder window location
#
# Arguments:
#   none
# Returns:
#   none
###############################################################################

function cdf() {
  local cmd='tell app "Finder" to POSIX path of (insertion location as alias)'

  cd "$(osascript -e "${cmd}")"
}

###############################################################################
# More sensible `tree`
#
# Arguments:
#   arguments for tree
# Returns:
#   tree output in less
###############################################################################

function treep() {
  if command -v tree>'/dev/null' 2>&1; then
    tree -CN "$@" | less -r
  fi
}

###############################################################################
# Create a data URL from a file
#
# Arguments:
#   path
# Returns:
#   data url
###############################################################################

function dataurl() {
  local mimeType="$(file -b --mime-type "$1")"

  if [[ "${mimeType}" == 'text/*' ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi

  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

###############################################################################
# Count number of characters and words in string
#
# Arguments:
#   text
# Returns:
#   number of characters and words
###############################################################################

function txtcount() {
  if [[ "$#" != 0 ]]; then
    local chars="$(printf "$@" | wc -m | tr -d ' ')"
    local words="$(printf "$@" | wc -w | tr -d ' ')"

    printf "Number of characters: \e[1m${chars}\e[0m\n"
    printf "Number of words: \e[1m${words}\e[0m\n"
  else
    printf "No text supplied.\n"
  fi
}

###############################################################################
# Get gzip size of file
#
# Arguments:
#   file
# Returns:
#   size of file
###############################################################################

function gzipsize() {
  gzip -c "$@" | wc -c | sed -e 's/^ *//g' -e 's/ *$//g';
}

###############################################################################
# Clear the screen with scissors symbols
#
# Arguments:
#   none
# Returns:
#   symbols equal to terminal columns
###############################################################################

function c() {
  local s="$(printf "%-$(($(tput cols) / 2))s")"

  echo "${fg[magenta]}${s// / ✂}${reset_color}"

  clear
}

###############################################################################
# Move files to the Mac OS X trash
#
# Arguments:
#   paths
# Returns:
#   none
###############################################################################

function mvt() {
  mv "$@" ~'/.Trash'
}

###############################################################################
# Search all files in the current directory for a string
#
# Arguments:
#   string
# Returns:
#   files containing the string
###############################################################################

function fs() {
  find . -print0 | xargs -0 grep "$*"
}

###############################################################################
# Remove a sensitive file from git history
#
# Arguments:
#   path
# Returns:
#   status
###############################################################################

function git_remove_sensitive_file() {
  git filter-branch --force --index-filter \
    'git rm --cached --ignore-unmatch "$1"' \
    --prune-empty --tag-name-filter cat -- --all
}

###############################################################################
# Cleanup and reclaim space in a git repository
#
# Arguments:
#   none
# Returns:
#   cleanup status
###############################################################################

function git_reclaim() {
  rm -rf .git/refs/original/
  git reflog expire --expire=now --all
  git gc --prune=now
  git gc --aggressive --prune=now
}
