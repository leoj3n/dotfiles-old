#
# Executes commands at the start of an interactive session.
#

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi

readonly TAPS="$(brew --repository)/Library/Taps"
readonly CASKROOM="/opt/homebrew-cask/Caskroom"
readonly VLC="${CASKROOM}/vlc/2.1.1/VLC.app/Contents/MacOS/VLC"

source "${HOME}/.homesick/repos/homeshick/homeshick.sh"

fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

export PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"

autoload -U colors
colors

################################################
# Lists casks added since a human-readable time
# Arguments:
#   since
# Returns:
#   list of casks
################################################
function brew_cask_list_since() {
  local since="5 days"

  if [[ -n "$*" ]]; then
    since="$*"
  fi

  cd "${TAPS}/phinze-cask" && git log \
    --since="${since}" --name-status --pretty="format:" "Casks/" \
    | grep '^A' | sed 's!^.*Casks/\(.*\).rb$!\1!'
}

# ZSH Online Help

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# WP-CLI Bash Completions

autoload bashcompinit
bashcompinit
source $HOME/.composer/vendor/wp-cli/wp-cli/utils/wp-completion.bash

# Git Bash Completion

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  #. $(brew --prefix)/etc/bash_completion
fi

# Aliases

## Git Aliases

alias ngh="/usr/local/bin/gh"
alias gcam="gca -m"
alias gfa="gf --all"
alias gpul="gp -u leoj3n"
alias gpuo="gp -u origin"
alias gpuom="gp -u origin master"
alias gih="g update-index --assume-unchanged"
alias gis="g update-index --no-assume-unchanged"
alias gdh='git ls-files -v | grep "^h " | cut -d" " -f2-'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gic="gcase"
alias gRe="git remote set-url"
alias gpr="g pull-request"
alias giaa="gia --all"

#function gpr() { ngh pr --fetch $3 --user $1 --repo $2; }

function gbp() { gf origin pull/$1/head:$2; } # PR, branchname

function giap() { # pattern
  g ls-files -co --exclude-standard | grep $1 | xargs git add
}

## Hub Aliases

eval "$(gh alias -s)"
# eval "$(hub alias -s)"

alias ghu='go get -u github.com/jingweno/gh'

## WordPress Aliases

alias apps="cd ~/wp/apps"
alias plugs="cd ~/wp/plugs"
alias apacheroots="cd /Users/leoj/Sites/www/dev/1/wp-content/themes/roots"

alias reroots="rm -rf roots.io && gfc -p retlehs/roots.io"\
" && cd roots.io && vu"

## Homebrew Aliases

alias brl="brew list"
alias bri="brew info"
alias brh="brew home"
alias brs="brew search"
alias brin="brew install"
alias brun="brew uninstall"
alias brup="brew update"
alias brug="brew upgrade"

alias brcl="brew cask list"
alias brci="brew cask info"
alias brch="brew cask home"
alias brcs="brew cask search"
alias brcc="brew cask create"
alias brce="brew cask edit"
alias brcin="brew cask install"
alias brcun="brew cask uninstall"
alias brcls=brew_cask_list_since

## Meteor Aliases

alias m="meteor"

## Bower Aliases

alias bower='noglob bower'

## Other Aliases

alias v="vassh"
alias t="type"
alias hs="homeshick"
alias cl="c; l"
function c() { s="$(printf "%-$(($(tput cols) / 2))s")"; echo "${fg[magenta]}${s// / ✂}${reset_color}"; clear; }
function mvt() { mv "$*" ~/.Trash }
alias ta="task add"
alias tls="task ls"
function td() { task $1 delete }
function tdo() { task $1 done }
alias rss="newsbeuter"
alias pod="podbeuter"
alias ep="sublp"
alias epp="ep "${PWD##*/}""
alias se="smartextract"
alias ...="cd ../.."
# alias -- -="cd -" # not working in zsh prezto
alias lsd="ls -Ad .*"
alias lss="ls -al | grep .-\>"
alias vu="vagrant up"
alias vs="vagrant ssh"
alias vh="vagrant halt"
alias vr="vagrant reload"
alias vd="vagrant destroy"
alias vp="vagrant provision"
alias vpu='v sudo WP_TESTS_DIR=/home/vagrant/svn/wp-tests vendor/bin/phpunit'
alias pp="sudo lsof -i"
alias zpr="cd ~/.zprezto"
alias skel="skelgen"
alias snginx="nginx -s stop"
alias priv="privoxy /usr/local/etc/privoxy/config"
alias masq="$(brew --prefix)/etc/dnsmasq.conf"
alias remasq="sudo launchctl stop homebrew.mxcl.dnsmasq && sudo launchctl"\
" start homebrew.mxcl.dnsmasq"

alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key "\
"copied to pasteboard.'"

alias kextl="sudo kextload /System/Library/Extensions/AppleUSBTopCase"\
".kext/Contents/PlugIns/AppleUSBTCKeyboard.kext"

alias kextu="sudo kextunload /System/Library/Extensions/AppleUSBTopCase"\
".kext/Contents/PlugIns/AppleUSBTCKeyboard.kext > /dev/null 2>&1"

alias flush="sudo killall -HUP mDNSResponder" # Flush Directory Service cache
alias whois="whois -h whois-servers.net"
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"

alias ss="open /System/Library/Frameworks/ScreenSaver"\
".framework/Versions/A/Resources/ScreenSaverEngine.app"

alias dbon="defaults write com.apple.dashboard mcx-disabled -boolean NO"\
" && killall Dock"

alias dboff="defaults write com.apple.dashboard mcx-disabled -boolean YES"\
" && killall Dock"

alias sloff="sudo launchctl unload -w /System/Library/LaunchDaemons/com"\
".apple.metadata.mds.plist"

alias slon="sudo launchctl load -w /System/Library/LaunchDaemons/com"\
".apple.metadata.mds.plist"

# Functions

## Uppercase the first letter of a git-indexed-file filename

function gcase() {
  local foo=$1
  g mv --force $foo "$(tr '[:lower:]' '[:upper:]' <<< ${foo:0:1})${foo:1}"
}

## E-T Phone Home

function h() {
  cd ~/$1
}

## Dash.app lookup

function da() {
  open dash://$1
}

## list with numerical permissions

function lsmod() {
  ls -l | awk '{k=0;for(i=0;i<=8;i++) \
    k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf("%0o ",k);print}'
}

## Generates phpunit-skelgen CLI args using a single input
# Expects to run from 'src/YourPackage' like so:
#
# $ skelgen My_Class          # single argument
# $ skelgen My_Class My/Class # two arguments; second is an optional path
#
# These commands are equivelant and both return:
#
# > Wrote skeleton for "My_ClassTest" to
# >  "../../tests/My/ClassTest.php".

function skelgen() {
  local ns=${PWD##*/}"\\"
  local class=$(echo ${1%.php} | tr "/" "_")
  local out=$(echo ${1%.php} | tr "_" "/")
  local src=out

  if [ ! "x$2" = "x" ]; then
    local out=$2
  fi

  if $(echo $out | grep --quiet "/"); then
    local begin=$(echo $out | cut -d/ -f1)
  fi

  local tst="../../tests/"
  mkdir -p $tst$begin

  phpunit-skelgen --bootstrap "../../vendor/autoload.php" --test \
    -- $ns$class $src".php" $ns$class"Test" $tst$out"Test.php"
}

## Opens a Sublime Text project and prints directory paths metadata

function sublp() {
  local proj=~/.sublime-project/$1.sublime-project
  subl --project $proj

  # print project folders
  awk -F"[,:]" '{for(i=1;i<=NF;i++){if($i~/path\042/){print $(i+1)} } }' $proj
}

## Shortens GitHub URL

function ghio() {
  curl -i http://git.io -F "url=https://github.com/"$1 $code -F "code=${2}"
}

## Converts YouTube -> Gif

function ytgif() {
  local tmp=".ytgif"
  local flv="$tmp/yt.flv"
  local rnd="$tmp/$RANDOM"

  youtube-dl -o "$flv" $1

  local ytsize=$(wc -c < $flv)

  mplayer $flv -endpos $[ytsize*.75]"b" -sstep 30 -vo jpeg:outdir="$rnd" \
    :smooth=30:progressive -vf scale=320:240 -nosound

  convert -delay 30 -loop 0 "$rnd/*.jpg" yt.gif

  rm -rf "$rnd"
  rm -ri .ytgif
}

## Extracts or mounts files
# nparikh.org/notes/zshrc.txt

smartextract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar -jxvf $1                    ;;
      *.tar.gz)  tar -zxvf $1                    ;;
      *.bz2)     bunzip2 $1                      ;;
      *.dmg)     hdiutil mount $1                ;;
      *.gz)      gunzip $1                       ;;
      *.tar)     tar -xvf $1                     ;;
      *.tbz2)    tar -jxvf $1                    ;;
      *.tgz)     tar -zxvf $1                    ;;
      *.zip)     unzip $1                        ;;
      *.ZIP)     unzip $1                        ;;
      *.pax)     cat $1 | pax -r                 ;;
      *.pax.Z)   uncompress $1 --stdout | pax -r ;;
      *.Z)       uncompress $1                   ;;
      *)         echo "'$1' cannot be extracted/mounted via smartextract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

## Backs up a file
# commandlinefu.com/commands/view/7294/backup-a-file-with-a-date-time-stamp

buf() {
  local oldname=$1
  if [ "$oldname" != "" ]; then
    local datepart=$(date +%Y-%m-%d)
    local firstpart=`echo $oldname | cut -d "." -f 1`
    local newname=`echo $oldname | sed s/$firstpart/$firstpart.$datepart/`
    cp -R ${oldname} ${newname}
  fi
}

## Relinks target-file to source-file
# https://github.com/adamv/dotfiles/blob/master/install#L3-L16

relink() {
  if [[ -h "$1" ]]; then
    echo "Relinking $1"
    # Symbolic link? Then recreate.
    rm "$1"
    ln -sn "$2" "$1"
  elif [[ ! -e "$1" ]]; then
    echo "Linking $1 to $2"
    ln -sn "$2" "$1"
  else
    echo "$1 exists as a real file, skipping."
  fi
}
