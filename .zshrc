PROMPT='[%n@%~]$ '
#LANG=C
EDITOR=vim
# screen で最後に打ったコマンドをタイトルに表示
preexec () {
  1="$1 " # deprecated.
  echo -ne "\ek${${(s: :)1}[0]}\e\\"
}


setopt autopushd
alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
alias V="bindkey -v"
alias E="bindkey -e"

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

. ~/work/github/z/z.sh

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

        echo "%{$color%}$name%{$reset_color%}"
}

setopt prompt_subst

RPROMPT='[`rprompt-git-current-branch`]'
