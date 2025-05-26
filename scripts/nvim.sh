#!/usr/bin/env bash
set -x

ln -si $HOME/dotfiles/.vimrc $HOME/.vimrc
mkdir -p $XDG_CONFIG_HOME/nvim/lua
ln -si $HOME/dotfiles/nvim2/config.lua $XDG_CONFIG_HOME/nvim/lua/config.lua
ln -si $HOME/dotfiles/nvim2/filetype.vim $XDG_CONFIG_HOME/nvim/filetype.vim
ln -si $HOME/Dropbox/important/.wakatime.cfg $HOME/.wakatime.cfg

rm -f $XDG_CONFIG_HOME/nvim/init.vim
echo "
set runtimepath+=$HOME/.vim,$HOME/.vim/after
set packpath+=$HOME/.vim
source $HOME/.vimrc
set undodir=$HOME/.vim/undofiles
lua require('config')
" >| $XDG_CONFIG_HOME/nvim/init.vim

chmod a-w $XDG_CONFIG_HOME/nvim/init.vim
