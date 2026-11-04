bind 'set bell-style none'
alias ls="ls --color=auto"
alias ll="ls -lahF"
alias vim="nvim"

[ -x "$(command -v starship)" ] && eval "$(starship init bash)"

# cd to dev directories
cdd() { cd "d:/dev/$1" ; }
_cdd_completions() {
    if [ "${#COMP_WORDS[@]}" != "2" ]; then return; fi
    local dirs=$(find "d:/dev" -mindepth 1 -maxdepth 1 -type d,l -printf '%f\n')
    COMPREPLY=($(compgen -W "$dirs" "${COMP_WORDS[1]}" ));
}
complete -F _cdd_completions cdd
