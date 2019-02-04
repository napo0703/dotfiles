typeset -U PATH CDPATH FPATH MANPATH

# ENV
export EDITOR=`which vim`
[[ -f /usr/local/bin/vim ]] && export EDITOR=/usr/local/bin/vim
export TERM=xterm-256color
export LISTMAX=0
export CLICOLOR=1
export LSCOLORS=exfxbxdxcxhegedabagahcdx
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=32:bd=34:cd=34:su=42:sg=46:tw=42:ow=34;42:or=40;31'
export ZLS_COLORS=$LS_COLORS

# LANG
local JA=ja_JP.UTF-8
local EN=en_US.UTF-8
export LANG=$JA
export LC_CTYPE=$EN
export LC_NUMERIC=$EN
export LC_TIME=$EN
export LC_COLLATE=$JA
export LC_MONETARY=$JA
export LC_MESSAGES=$EN
export LC_PAPER=$EN
export LC_NAME=$JA
export LC_ADDRESS=$JA
export LC_TELEPHONE=$JA
export LC_MEASUREMENT=$JA
export LC_IDENTIFICATION=$JA
export LC_ALL=ja_JP.UTF-8

# GIT
export GIT_EDITOR=$EDITOR

# History and Completeion
autoload -U compinit
compinit -u
autoload -Uz colors ; colors
autoload -Uz history-search-end
autoload -U compinit && compinit

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000000
SAVEHIST=100000

if [[ ! -z `compaudit` ]]; then
  compaudit | xargs chmod g-w
fi

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

zstyle ':completion:*' use-cache true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:approximate:*' max-errors 1
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:default' menu select auto
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:::::' completer _complete _approximate

autoload -U zmv
autoload -U zfinit
zmodload zsh/complist
zmodload zsh/zftp

# Configuration
limit coredumpsize 102400
#setopt prompt_subst
setopt NO_beep
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt hist_ignore_dups
setopt autopushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_menu
setopt extended_history
setopt equals
setopt magic_equal_subst
setopt hist_verify
setopt numeric_glob_sort
setopt print_eight_bit
setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt noautoremoveslash
setopt complete_aliases
setopt glob_complete

# Prompt
COMPPATH=''
SUDOPATH=''
for it in `echo $PATH | sed -e 's/:/ /g'`; do
  if [[ sbin = `basename $it` ]]; then
    SUDOPATH="$SUDOPATH $it"
  else
    SUDOPATH="$SUDOPATH $it"
    COMPPATH="$COMPPATH $it"
  fi
done

case ${UID} in
  0)
    zstyle ':completion:*' command-path `echo $SUDOPATH`
    PROMPT="%{${fg[magenta]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}#%{${reset_color}%} "
    ;;
  *)
    zstyle ':completion:*' command-path `echo $COMPPATH`
    zstyle ':completion:*:sudo:*' command-path `echo $SUDOPATH`
    case ${OSTYPE} in
      darwin*)
        PROMPT="%{${fg[cyan]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
        ;;
      linux*)
        case ${HOST} in
          p*)
            PROMPT="%{${fg[green]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
            ;;
          *)
            PROMPT="%{${fg[yellow]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
            ;;
        esac
        ;;
    esac
    ;;
esac
PROMPT2="%B%{${fg[magenta]}%}%_#%{${reset_color}%}%b "
SPROMPT="%B%{${fg[magenta]}%}%r is correct? [n,y,a,e] :%{${reset_color}%}%b "

case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# Aliases and Functions
#alias ls="ls -vF --color"
alias dir="dir --color"
alias cp="cp -iv"
alias mv="mv -iv"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"
alias dotfilevisible="defaults write com.apple.finder AppleShowAllFiles -boolean true"
alias dotfileinvisible="defaults write com.apple.finder AppleShowAllFiles -boolean false"
alias javac="javac -J-Dfile.encoding=UTF-8"
alias java="java -Dfile.encoding=UTF-8"
alias -s js="js"
alias -s coffee="(){coffee -p $1 | js}"
alias pip3="nocorrect pip3"
alias nicovideo-dl="nicovideo-dl -u napo0703@gmail.com"
alias gl="git log --stat --graph --decorate"
alias glq="git --no-pager log --stat --decorate -n 1"
alias gs="git status"
alias gt="git log --oneline --graph --date=format:'%Y-%m-%d %H:%M' --pretty='format:%C(yellow)%h %C(green)%ad %C(blue)%an%C(red)%d %C(reset)%s'"
alias gtq="clear;git --no-pager log --oneline --graph --date=format:'%Y-%m-%d %H:%M' --pretty='format:%C(yellow)%h %C(green)%ad %C(blue)%an%C(red)%d %C(reset)%s' -n 20"
alias gc="git checkout"
alias gcd="git checkout develop"
alias gd="git diff"
alias gdd="git diff develop...@"
alias gdn="git diff --name-only"
alias gddn="git diff develop...@ --name-only"
alias gb="git branch"
alias gpoh="git push origin HEAD"
alias clean_unity="import_rider;rm -r /Users/Shared/Unity/JetBrains*;cp -r unity/Assets/Plugins/Editor/JetBrains* /Users/Shared/Unity/;git reset --hard;git clean -f -d;"
alias import_rider="mkdir unity/Assets/Plugins/Editor; cp -r /Users/Shared/Unity/JetBrains unity/Assets/Plugins/Editor/JetBrains"
alias cphash="git rev-parse HEAD;git rev-parse HEAD | pbcopy;"
alias cpbranch="git rev-parse --abbrev-ref @;git rev-parse --abbrev-ref @ | pbcopy;"
alias sed="gsed"

# Git Prompt
__git_files() { _files }
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "^"
  zstyle ':vcs_info:git:*' unstagedstr "*"
  zstyle ':vcs_info:git:*' formats '[%s](%b) %c%u'
  zstyle ':vcs_info:git:*' actionformats '[%s](%b|%a) %c%u'
fi
function _update_vcs_info_msg() {
  psvar=()
  LANG=C vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"
RPROMPT="$RPROMPT %{${fg[blue]}%}[%/]%{${reset_color}%}"

if [ ! -z "`which tmux`" ]; then
  if [ $SHLVL = 1 ]; then
    if [ $(( `ps aux | grep tmux | grep $USER | grep -v grep | wc -l` )) != 0 ]; then
      echo -n 'Attach tmux session? [Y/n]'
      read YN
      [[ $YN = '' ]] && YN=y
      [[ $YN = y ]] && tmux attach
    fi
  fi
fi

if [[ "$TMUX" != "" ]] then
  alias pbcopy="ssh 127.0.0.1 pbcopy"
  alias pbpaste="ssh 127.0.0.1 pbpaste"
fi

# Android-SDK
export PATH=$PATH:~/Library/Android/sdk/platform-tools
export PATH=$PATH:~/Library/Android/sdk/tools
export ANDROID_HOME=$PATH:~/Library/Android/sdk

# The fuck
eval "$(thefuck --alias)"

# AWS CLI
#source /usr/local/share/zsh/site-functions/_aws

# z
. `brew --prefix`/etc/profile.d/z.sh
compctl -U -K _z_zsh_tab_completion ${_Z_CMD:-z}

# GCP
export PATH=$PATH:~/Library/google-cloud-sdk/bin

# Terminal
set_terminal_profile() {
  # set profile
  /usr/bin/osascript <<SCRIPT
tell application "Terminal"
    set current settings of first window to settings set "$1"
  end tell
SCRIPT
}

# Tab
tabs -4
