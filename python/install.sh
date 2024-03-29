# install pyenv
set -x
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

easy_install SpoofMAC

easy_install pip
pip install requests[security] # for grip
pip install \
  grip \
  eyeD3 \
  vim-vint \
  ansible \
  black \
  pylint \
  pyre \
  isort \
  aws \
  grpcio-tools \
  neovim \
  pandas \
  pyarrow \
  pynvim \
  sqlfluff \
  sqlfmt \
  yapf

set +x
