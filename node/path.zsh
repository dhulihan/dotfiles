export PNPM_HOME="$HOME/Library/pnpm"
export PATH="./node_modules/.bin:$PATH"

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
