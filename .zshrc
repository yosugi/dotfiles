PROMPT='[%n@%c]$ '
#LANG=C
EDITOR=vim

setopt autopushd
alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
alias V="bindkey -v"
alias E="bindkey -e"

alias la="ls -a"
alias ll="ls -al"
alias view='vim -R'

bindkey -v               # vi key bindings
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^D' delete-char-or-list
bindkey '^U' kill-whole-line
bindkey '^K' kill-line
bindkey '^H' backward-delete-char
bindkey '^R' history-incremental-search-backward
bindkey '^Y' yank
bindkey '^J' push-line
bindkey '^Q' push-line
bindkey -a 'q' push-line

bindkey -a '/' history-incremental-search-forward
bindkey -a '?' history-incremental-search-backward

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# mkdir ~/.zsh; cd ~/.zsh
# git clone git://github.com/rupa/z.git
. ~/.zsh/z/z.sh
precmd() {
  _z --add "$(pwd -P)"
}

autoload -U colors; colors

function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        echo "[%{$color%}$name%{$reset_color%}]"
}

setopt prompt_subst

RPROMPT='`rprompt-git-current-branch`'

zstyle ':completion:*:*:git:*' script ~/.git-completion.sh

function search() {
if [ $# -lt 1 ] ; then
    print "error: few args!"
    return 0
elif [ $# -eq 1 ] ; then
    arg_path="."
    arg_pattern="*"
    arg_word=$1
elif [ $# -eq 2 ] ; then
    arg_path="."
    arg_pattern=$1
    arg_word=$2
else
    arg_path=$1
    arg_pattern=$2
    arg_word=$3
fi
find $arg_path -name $arg_pattern -print | xargs grep -n $arg_word
}

function isearch() {
if [ $# -lt 1 ] ; then
    print "error: few args!"
    return 0
elif [ $# -eq 1 ] ; then
    arg_path="."
    arg_pattern="*"
    arg_word=$1
elif [ $# -eq 2 ] ; then
    arg_path="."
    arg_pattern=$1
    arg_word=$2
else
    arg_path=$1
    arg_pattern=$2
    arg_word=$3
fi
find $arg_path -name $arg_pattern -print | xargs grep -in $arg_word
}

# google search by w3m
function google() {
local str opt
if [ $ != 0 ]; then
    for i in $*; do
        str="$str+$i"
    done
    str=`echo $str | sed 's/^\+//'`
    opt='search?num=50&hl=ja&lr=lang_ja'
    opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

# alc search by w3m
function alc() {
if [ $ != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
    w3m "http://www.alc.co.jp/"
fi
}

stty stop undef
stty start undef
stty kill undef
stty lnext undef
stty intr undef

hash -d tmp=/tmp
hash -d log=/var/log
