# gimme them bins
export PATH="$HOME/.rbenv/bin:$PATH"
export RBENV_ROOT="$HOME/.rbenv"

# init according to man page
if (( $+commands[rbenv] ))
then
  eval "$(rbenv init -)"
fi
