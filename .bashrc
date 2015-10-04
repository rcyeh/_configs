# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsf='find * -type f -print'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="/opt/anaconda/envs/py3k/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export EDITOR=/usr/bin/vim

# # .bashrc
# 
# #export PROMPT_COMMAND='if [ $? -ne 0 ]; then ERROR_FLAG=1; else ERROR_FLAG=; fi;'
# export PS1='\[\033k\033\\\]\h/\l \w $ '
# HOSTNAMEF=$(hostname -f)
# TTYNUM=$(tty | sed -e 's%/dev/%%; s%/%-%g; s% %%g;')
# export PROMPT_COMMAND='printf "\033]0;%s/%s:%s\007" "${HOSTNAMEF%%.*}" "${TTYNUM}" "${PWD/#$HOME/~}"'
# function settitle() {
#   echo "\033]0;$*\007"
# }
# 
# # User specific aliases and functions
# 
function yahoo() {
    curl "http://finance.yahoo.com/q?s=$1&ql=1" 2> /dev/null | perl -n -e 'next unless /<div class="yfi_[_rt]*quote_summary"/; s/<[^>]*tradenow.*//; s/<[^>]+id="([^>"]+)"[^>]*>/\n$1\t/g; s/<[^>]*>/ /g; s/  +/ /g; print; ';
}
# 
# function exegy_qual()
# {
#     while a=$1 && shift; do
#         echo "${a} =" $(( ${a} / 256 / 256 / 256 )) $(( ${a} / 256 / 256 % 256 )) $(( ${a} / 256 % 256 )) $(( ${a} % 256 ))
#         for a in $(( ${a} / 256 / 256 / 256 )) $(( ${a} / 256 / 256 % 256 )) $(( ${a} / 256 % 256 )) $(( ${a} % 256 )); do
#             if (( ${a} > 0 )); then
#                 grep " X[QT]Q_.* (${a})" ${EXEGY_HOME}/include/xqual.h
#             fi
#         done
#     done
# }
# 
alias gitlg='git log --graph --all --oneline --decorate --date=short --pretty=format:"%ad (%aN) %h %s %d"'
# # export PATH="${HOME}/ryeh/anaconda/envs/py3k/bin:${PATH}"
# # export PYTHONPATH=${HOME}/ryeh/anaconda/envs/py3k/lib/python3.4/site-packages:${HOME}/ryeh/envs/py3k/lib/python3.4/site-packages
# # export CONDA_DEFAULT_ENV=py3k
# 
# umask 0
# 
# export PAGER=less
# 
# HISTFILE="$(date +%Y%m%d)-${HOSTNAMEF}-${TTYNUM}"
# export HISTFILE="${HOME}/share/.bh/${HISTFILE:0:6}/${HISTFILE}"
# unset HISTFILESIZE
# mkdir -p $(dirname ${HISTFILE})
# 
# 
