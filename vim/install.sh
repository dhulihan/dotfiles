#!/bin/bash

# vundle
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install plugins (currently broken, run manually)
#vim -c ":source ~/.vimrc | PluginInstall | q"
#vim -c ":GoInstallBinaries | q"

# additional plugin installation steps
#cd ~/.vim/bundle/YouCompleteMe
#python3 install.py \
    #--go-completer \
    #--clang-completed \
    #--java-completer \
    #--ts-completer
