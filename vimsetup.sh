#!/bin/sh

## Get this script's location
LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

RED='\033[0;31m'
NC='\033[0m' # No Color


echo -e "Downloading the vim.plug Plugin manager:\n"

## https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\nPreparing directories"




if [ ! -f ~/.vimrc ]
then
	echo "Creating new \".vimrc\" into your home directory."
	cat ${LOCATION}/vimrc > ~/.vimrc

else
	echo -e "${RED}WARNING.${NC} \".vimrc\" is already present in your home directory."
	echo "Set up the  vimrc manually!"
	echo "Use ${LOCATION}/vimrc"
	echo "Then, in vim run :PlugInstall manually"
	exit 1
fi

if [ -f ~/.vim/ ]
then
	echo -e "${RED}WARNING.$NC There is already .vim directory. Do you want to continue? (y/n)"
	read answer
	case $answer in
		y | Y | yes | Yes ) continue;;
		*) echo "Stopping now. remove .vim (and .vimrc) and rerun the script.";
			echo "Or manually run:";
			echo "cp -r ${LOCATION}/.vim/rc* ~/.vim/";
			echo "Then, in vim run :PlugInstall manually";
			exit 1;;
	esac
fi

## Copying the config files into ~/.vim/
cp -r ${LOCATION}/.vim/rc* ~/.vim/


echo "Checking if nodejs is installed, which is necessary for coc"
if [ ! $(command -v node) ]
then 
	echo -e "${RED} WARNING. ${NC} nodejs (node) wasn't found. Please install manually to use coc (autocompletion)."
fi

echo -e "\n\n\n"
echo    "Installing Plugins to vim."
echo -e "${RED}Ignore the first error message regarding colorscheme${NC}"

vim +'PlugInstall --sync' +qa

echo    "Finished."
