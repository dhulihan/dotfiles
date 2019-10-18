set -e
brew install tmux
brew install tmux-xpanes
brew install git
brew install zsh
brew install macvim
brew install go
brew install ack
brew install rbenv ruby-build rbenv-vars
brew install ssh-copy-id
brew install mosh
brew install wget
brew install wdiff
brew install macvim
brew install terminal-notifier
brew install cmake
brew install direnv
# brew install ctags # swapping out for universal-ctags
brew install tmate
brew install openssl
brew install libyaml
brew install libffi
brew install cmake
brew install jq
brew install watch
brew install markdown
brew install cowsay
brew install fortune
brew install coreutils
brew install findutils
brew install gnu-sed
brew install elixir
brew install riak
brew install tree
brew install kubernetes-cli
brew install kubernetes-helm
brew install graphviz
#brew install terraform
brew install tfenv
brew install editorconfig
brew install ncdu
brew install python
brew install pg_top
brew install mpv
brew install direnv
brew install kubernetes-cli
brew install iftop
brew install mysql
brew install dep
brew install tidy-html5
brew install protobuf
brew install direnv
brew install tree
brew install git-secrets
brew install libcouchbase
brew install pv
brew install postgresql
brew install sngrep
brew install sipp
brew install ansible
brew install ngrep
brew install grpcurl
brew install restic
brew install gifsicle
brew install curl
brew install baresip 
brew install telnet
brew install lolcat
brew install nsq
brew install ncdu
brew install fd
brew install caddy
brew install prettier
brew install sipcalc
brew install ipcalc
brew install lua
brew install luarocks
brew install erlang
brew install proctools
brew install pssh
brew install kubectx

brew install node@10
brew link --force node@10

#brew install gimp

# install universal-ctags, which has golang support
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
brew install burntsushi/ripgrep/ripgrep-bin

# Hack fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
brew cask install font-source-code-pro

# wireshark
brew cask install wireshark

# gcloud
brew tap caskroom/cask
brew cask install google-cloud-sdk

# kubeval
brew tap garethr/kubeval
brew install kubeval

brew cask install minikube

#brew cask install gitify

brew install neovim/neovim/neovim

brew tap wata727/tflint
brew install tflint

brew cask install macvim

# Sierra
brew install reattach-to-user-namespace

# java stuff
brew cask install java
brew install logstash

brew cask install imagemagick
brew cask install ffmpeg

set +e
say "brew is done"
