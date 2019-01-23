# Don't share history
setopt no_share_history

# Make up/dn traverse local history instead of global
#bindkey "^[P" up-line-or-local-history
#bindkey "^[N" down-line-or-local-history

#up-line-or-local-history() {
    #zle set-local-history 1
    #zle up-line-or-history
    #zle set-local-history 0
#}
#zle -N up-line-or-local-history
#down-line-or-local-history() {
    #zle set-local-history 1
    #zle down-line-or-history
    #zle set-local-history 0
#}
