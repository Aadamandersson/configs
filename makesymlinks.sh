#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

vundle_path=""
if [[ "$OSTYPE" == "msys" ]]; then
	vundle_path=$HOME/.vim/bundle/Vundle.vim
	if [[ ! -d "$vundle_path" ]]; then
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	fi
else
	vundle_path=~/.vim/bundle/Vundle.vim
	if [[ ! -d "$vundle_path" ]]; then
		git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	fi
fi
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc"    # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
