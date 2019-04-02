#!/bin/sh

#dotfiles link
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

#install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#brew install
brew install zsh vim tmux z gnu-sed

#install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
