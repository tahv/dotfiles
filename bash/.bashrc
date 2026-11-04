START_NS=$(date +%s%N)

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

# print startup time
TOTAL_MS=$(( ($(date +%s%N) - START_NS) / 1000000 ))
echo "Loaded .bashrc in: $(( TOTAL_MS / 1000 ))s $(( TOTAL_MS % 1000 ))ms"
unset START_NS TOTAL_MS
