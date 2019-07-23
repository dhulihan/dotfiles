alias reload!='source ~/.zshrc'
alias reload_d!='source ~/.zshrc'

# Serve current directory on port (default 3000)
# Usage: serve 80
function serve {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}
