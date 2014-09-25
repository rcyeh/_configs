# .bashrc

#export PROMPT_COMMAND='if [ $? -ne 0 ]; then ERROR_FLAG=1; else ERROR_FLAG=; fi;'
export PS1='\[\033k\033\\\]\h/\l \w $ '
HOSTNAMEF=$(hostname -f)
TTYNUM=$(tty | sed -e 's%/dev/%%; s%/%-%g; s% %%g;')
export PROMPT_COMMAND='printf "\033]0;%s/%s:%s\007" "${HOSTNAMEF%%.*}" "${TTYNUM}" "${PWD/#$HOME/~}"'
function settitle() {
  echo "\033]0;$*\007"
}

# User specific aliases and functions

function yahoo() {
    curl "http://finance.yahoo.com/q?s=$1&ql=1" 2> /dev/null | perl -n -e 'next unless /<div class="yfi_[_rt]*quote_summary"/; s/<[^>]*tradenow.*//; s/<[^>]+id="([^>"]+)"[^>]*>/\n$1\t/g; s/<[^>]*>/ /g; s/  +/ /g; print; ';
}

function exegy_qual()
{
    while a=$1 && shift; do
        echo "${a} =" $(( ${a} / 256 / 256 / 256 )) $(( ${a} / 256 / 256 % 256 )) $(( ${a} / 256 % 256 )) $(( ${a} % 256 ))
        for a in $(( ${a} / 256 / 256 / 256 )) $(( ${a} / 256 / 256 % 256 )) $(( ${a} / 256 % 256 )) $(( ${a} % 256 )); do
            if (( ${a} > 0 )); then
                grep " X[QT]Q_.* (${a})" ${EXEGY_HOME}/include/xqual.h
            fi
        done
    done
}

alias gitlg='git log --graph --all --oneline --decorate --date=short --pretty=format:"%ad (%aN) %h %s %d"'
alias todo='vim ${HOME}/ryeh/todo.txt'

export PATH="${HOME}/ryeh/anaconda/bin:$PATH"
export PYTHONPATH=${HOME}/ryeh/anaconda/lib/python2.7/site-packages:${HOME}/ryeh/lib/python2.7/site-packages
# export PATH="${HOME}/ryeh/anaconda/envs/py3k/bin:${PATH}"
# export PYTHONPATH=${HOME}/ryeh/anaconda/envs/py3k/lib/python3.4/site-packages:${HOME}/ryeh/envs/py3k/lib/python3.4/site-packages
# export CONDA_DEFAULT_ENV=py3k

umask 0

export PAGER=less

HISTFILE="$(date +%Y%m%d)-${HOSTNAMEF}-${TTYNUM}"
export HISTFILE="${HOME}/share/.bh/${HISTFILE:0:6}/${HISTFILE}"
unset HISTFILESIZE
mkdir -p $(dirname ${HISTFILE})


