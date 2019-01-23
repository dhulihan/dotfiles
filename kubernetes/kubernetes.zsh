# fix `command not found: compdef`
autoload -U compinit && compinit

if command -v kubectl > /dev/null ; then
	source <(kubectl completion zsh)
fi
