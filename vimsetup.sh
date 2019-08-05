#!/bin/sh

## Get this script's location
LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


## Downloading the vim.plug Plugin manager
## https://github.com/junegunn/vim-plug
##
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


## Getting the colorscheme solarized

git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
cp  ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
cp  ~/.vim/bundle/vim-colors-solarized/autoload/togglebg.vim ~/.vim/autoload/

## Copying the config files into ~/.vim/
cp -r ${LOCATION}/.vim/rcplugins ~/.vim/
cp -r ${LOCATION}/.vim/rcfiles ~/.vim/



if [ ! -f ~/.vimrc ]
then
	echo "Creating new \".vimrc\" into your home directory."
	cat ${LOCATION}/vimrc > ~/.vimrc

else
	echo "WARNING. \".vimrc\" is already present in your home directory."
	echo "Set up the  vimrc manually!"
	echo "{LOCATION}/vimrc"
fi




echo -e "\n\n\n"
echo "Finally, open vim and run PlugInstall to download plugins, and check with PlugStatus."
