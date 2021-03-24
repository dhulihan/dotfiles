set -e
brew install ack
brew install baresip
brew install bat
brew install ewm-ng
brew install bvi
brew install caddy
brew install cmake
brew install cmake
brew install coreutils
brew install cowsay
# brew install ctags # swapping out for universal-ctags
brew install curl
brew install dep
brew install direnv
brew install direnv
brew install direnv
brew install editorconfig
brew install elixir
brew install eqnxio/equinox/release-tool
brew install erlang
brew install etcd
brew install fd
brew install findutils
brew install fortune
brew install fzy
brew install gifsicle
#brew install gimp
brew install gh
brew install git
brew install git-secrets
brew install gnu-sed
brew install go
brew install goreleaser/tap/goreleaser
brew install graphviz
brew install grpcurl
brew install hyperkit
brew install id3lib
brew install id3tool
brew install iftop
brew install ipcalc
brew install jq
brew install k3d
brew install kubectx
brew install kubernetes-cli
brew install kubernetes-cli
brew install kubernetes-helm
brew install libcouchbase
brew install libffi
brew install libyaml
brew install lolcat
brew install lua
brew install luarocks
brew install macvim
brew install macvim
brew install markdown
brew install mosh
brew install mpv
brew install mysql
brew install packer
brew install pgformatter
brew install ncdu
brew install ncdu
brew install ngrep
brew install nsq
brew install openssl
brew install opencv
brew install operator-sdk
brew install peco
brew install pg_top
brew install pkgconfig
brew install pyenv
brew install pipenv
brew install postgresql
brew install prettier
brew install proctools
brew install protobuf
brew install pssh
brew install pv
brew install python
brew install python3
brew install rbenv ruby-build rbenv-vars
brew install redis
brew install restic
brew install riak
brew install ripgrep
brew install sipcalc
brew install sipp
brew install sox
brew install sngrep
brew install ssh-copy-id
brew install telnet
brew install terminal-notifier
#brew install terraform
brew install tfenv
brew install tidy-html5
brew install tmate
brew install tmux
brew install tmux-xpanes
brew install tree
brew install vault
brew install watch
brew install wdiff
brew install wget
brew install yarn
brew install youtube-dl
brew install zsh

brew install node@10
brew link --force node@10

# install universal-ctags, which has golang support
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Hack fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
brew cask install font-source-code-pro

brew cask install ngrok

brew tap homebrew/cask-fonts
brew cask install font-cascadia

# grump
brew tap dhulihan/grump
brew install grump

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

brew cask install bitbar
brew cask install macvim

# Sierra
brew install reattach-to-user-namespace

# java stuff
brew cask install java
brew install logstash

brew cask install imagemagick
brew cask install ffmpeg

brew install graphicsmagick

brew tap filippo.io/age https://filippo.io/age
brew install age

brew cask install vlc

brew install derailed/k9s/k9s
brew install rainbarf

# go-swagger
brew tap go-swagger/go-swagger
brew install go-swagger

# kudo
brew tap kudobuilder/tap
brew install kudo-cli

# buf
brew tap bufbuild/buf
brew install buf

# rectangle windows manager
brew cask install rectangle

# monitor control
brew install --cask monitorcontrol

brew install achannarasappa/tap/ticker

# brew install netdata

# lagrange gemini GUI client
brew tap skyjake/lagrange
brew install lagrange

# amfora gemini CLI client
brew tap makeworld-the-better-one/tap
brew install amfora

# bloom grpc client
brew install --cask bloomrpc

brew tap johanhaleby/kubetail && brew install kubetail

set +e
say "brew is done"
