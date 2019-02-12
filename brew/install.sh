brew install \
git \
zsh \
macvim \
go \
ack \
rbenv ruby-build rbenv-vars \
ssh-copy-id \
wget \
wdiff \
macvim \
terminal-notifier \
cmake \
direnv \
ctags \ # exuberant
tmate \
openssl \
libyaml \
libffi \
curl --with-openssl \
cmake \
jq \
watch \
markdown \
cowsay \
fortune \
coreutils \
elixir \
riak \
logstash \
tree \
kubernetes-cli \
kubernetes-helm \
graphviz \
gimp \
terraform \
editorconfig \
ncdu \
python \
pg_top \
mpv \
direnv \
kubernetes-cli \
iftop \
mysql \
dep \
tidy-html5 \
protobuf \
direnv \
tree \
git-secrets \
libcouchbase \
postgresql \
sngrep \
ansible \
ngrep \
grpcurl \
erlang

brew cask install java

brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
brew install burntsushi/ripgrep/ripgrep-bin

# Hack fonts
brew tap caskroom/fonts
brew cask install font-hack-nerd-font

# wireshark
brew cask install wireshark

# gcloud
brew tap caskroom/cask
brew cask install google-cloud-sdk

# kubeval
brew tap garethr/kubeval
brew install kubeval

brew cask install minikube


brew install neovim/neovim/neovim

brew tap wata727/tflint
brew install tflint

brew install macvim --with-override-system-vim
brew link curl --force
brew linkapps

# Sierra
brew install reattach-to-user-namespace

say "brew is done"
