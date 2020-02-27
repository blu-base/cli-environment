#!/bin/bash
## If not running interactively, don't do anything. CYGWIN
[[ "$-" != *i* ]] && return


# If not running interactively, don't do anything. Debian
#[ -z "$PS1" ] && return



## Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

## MinTTY Terminal Colors (CYGWIN)
#source ~/.mintty/mintty-colors-solarized/mintty-solarized-dark.sh

# Set directory colors
eval `dircolors ~/.dir_colors`

## mintty Terminal Size
if [ "$TERM" = "MINTTY" ]
then
	HEIGHT=60
	WIDTH=200
	echo -en "\e[8;${HEIGHT};${WIDTH}t"
fi

## Make bash append rather than overwrite the history on disk
shopt -s histappend


## Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


## Aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

## Functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi


