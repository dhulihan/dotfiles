# fix `command not found: compdef`
debug "autoloading compinit"
autoload -U compinit && compinit

debug "loading kubernetes completion"
if command -v kubectl > /dev/null ; then
	source <(kubectl completion zsh)
fi
debug "loaded kubernetes completion"
