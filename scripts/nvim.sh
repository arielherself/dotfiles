#!/usr/bin/env bash
set -x

ln -si $HOME/dotfiles/.vimrc $HOME/.vimrc
mkdir -p $XDG_CONFIG_HOME/nvim/lua
ln -si $HOME/dotfiles/nvim2/config.lua $XDG_CONFIG_HOME/nvim/lua/config.lua
ln -si $HOME/dotfiles/nvim2/filetype.vim $XDG_CONFIG_HOME/nvim/filetype.vim

echo "
set runtimepath+=$HOME/.vim,$HOME/.vim/after
set packpath+=$HOME/.vim
source $HOME/.vimrc
set undodir=$HOME/.vim/undofiles
lua require('config')
" >| $XDG_CONFIG_HOME/nvim/init.vim
