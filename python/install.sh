# install pyenv
set -x
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

easy_install SpoofMAC

sudo easy_install pip
sudo pip install requests[security] # for grip
sudo pip install \
  grip \
  vim-vint \
  ansible \
  black \
  pylint \
  pyre \
  isort \
  aws \
  yapf

set +x
