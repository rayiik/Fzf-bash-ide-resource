
_kitty_completions() {
    local src
    local limit
    # Send all words up to the word the cursor is currently on
    let limit=1+$COMP_CWORD
    src=$(printf "%s
" "${COMP_WORDS[@]: 0:$limit}" | kitty +complete bash)
    if [[ $? == 0 ]]; then
        eval ${src}
    fi
}

complete -o nospace -F _kitty_completions kitty

