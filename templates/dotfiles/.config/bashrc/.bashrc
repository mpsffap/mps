#!/bin/bash
# shellcheck disable=SC1090,SC1091
#--- Interactive shells only --------------------------------------------------
# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac
# set variable identifying the chroot you work in (used in the prompt below)
if [ "${debian_chroot:-}" = "" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi
#--- Prompt -------------------------------------------------------------------
if [[ -f ~/.config/bashrc/.bashrc_colors ]] ; then
    source ~/.config/bashrc/.bashrc_colors 
fi
if [[ -f ~/.config/bashrc/.bashrc_distro ]] ; then
    source ~/.config/bashrc/.bashrc_colors 
fi
if [[ -f ~/.config/bashrc/.bashrc_prompt ]] ; then
    source ~/.config/bashrc/.bashrc_prompt 
fi
#--- History ------------------------------------------------------------------
HISTSIZE=99999
HISTFILESIZE=99999
HISTFILE=~/.config/bashrc/.bash_history
BASH_LOGOUT=~/.config/bashrc/.bash_logout
HISTCONTROL=ignoreboth # don't put duplicate lines in the history.
shopt -s histappend    # append to the history file, don't overwrite it
shopt -s checkwinsize  # update the values of LINES and COLUMNS.
#--- Aliases ------------------------------------------------------------------
if [[ -f ~/.config/bashrc/.bashrc_prompt ]] ; then
    source ~/.config/bashrc/.bashrc_alias_common 
fi
if [[ -f ~/.config/bashrc/.bashrc_prompt ]] ; then
    source ~/.config/bashrc/.bashrc_alias_custom
fi
#--- Bash completion ----------------------------------------------------------
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
#--- Environment Variable -----------------------------------------------------
LOCALESTR=en_US.UTF-8
export PATH=$PATH:~/mps/snippets:~/.local/bin
export SUDO_ASKPASS=/usr/bin/ssh-askpass
export EDITOR=nvim
export TERM=xterm-kitty
export SHELL=/bin/bash
export DISPLAY=:0
export XDG_CONFIG_HOME=$HOME/.config
export SYSTEMD_PAGER="cat"
export LC_ALL="$LOCALESTR"
export LC_LANG="$LOCALESTR"
export LANG="$LOCALESTR"
export LANGUAGE="$LOCALESTR"
export DOTNET_ROOT=$HOME/.dotnet
export GDK_DPI_SCALE=1.5
export GDK_SCALE=1.5
export QT_FONT_DPI=144
export QT_SCALE_FACTOR=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
#--- Zoxide -------------------------------------------------------------------
eval "$(zoxide init bash)"


if [[ -d  "$HOME/.cargo/env" ]]; then
. "$HOME/.cargo/env"
fi
