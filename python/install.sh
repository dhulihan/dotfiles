# install pyenv
set -x
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

easy_install SpoofMAC

easy_install pip
pip install requests[security] # for grip
pip install \
  grip \
  vim-vint \
  ansible \
  black \
  pylint \
  pyre \
  isort \
  aws \
  grpcio-tools \
  yapf

set +x
