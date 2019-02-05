# install plugins
vim -c ":source ~/.vimrc | PluginInstall | q"

vim -c ":GoInstallBinaries | q"

# additional plugin installation steps
cd ~/.vim/bundle/YouCompleteMe
python3 install.py \
    --go-completer \
    --clang-completed \
    --java-completer \
    --ts-completer
