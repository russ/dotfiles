parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ →\ \1/'
}

# Bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# vi mode, of course
export EDITOR=vim
# set -o vi

# Shell
export SHELL=/bin/bash

# Term
export TERM=screen-256color-bce

# Paths
export CDPATH=".:~:~/Dropbox/Projects"
export PATH="~/.dotfiles/bin:$PATH"

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Colors the way I like em
export LSCOLORS=BxGxFxdxCxDxDxhbadBxBx

# Larger bash history (allow 32k entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# Make some commands not show up in history
# export HISTIGNORE="ls:ls *"

export EVENT_NOKQUEUE=1
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

# Prompt
export PS1='\[\e[1;32m\][\[\e[1;35m\]\[\e[1;32m\]\[\e[1;32m\]\[\e[1;36m\]\w\[\e[1;33m\]$(parse_git_branch)\[\e[1;32m\]]$ \[\e[0m\]'

# JRuby
export JRUBY_OPTS=--1.9

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
