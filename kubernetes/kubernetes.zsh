# fix `command not found: compdef`
debug "autoloading compinit"
autoload -U compinit && compinit

if command -v kubectl > /dev/null ; then
	debug "Kubernetes completion"
	source <(kubectl completion zsh)
fi
