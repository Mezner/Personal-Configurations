P4CONFIG=.p4config
export P4CONFIG

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == "Linux" ]]; then
    platform='linux'
elif [[ "$unamestr" == CYGWIN* ]]; then
    platform='cygwin'
fi
function openex {
    /cygdrive/c/Windows/explorer.exe /e,`cygpath -w "$1"`
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# unset TMP and TEMP in Cygwin as Windows environment variables are
# case insensitive.
if [[ $platform == 'cygwin' ]]; then
    unset TMP
    unset TEMP
fi
