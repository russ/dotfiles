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

export ARCHFLAGS="-arch x86_64"

# Shell
export SHELL=/bin/bash

# Term
export TERM="xterm-256color"

# Paths
export CDPATH=".:~:~/Projects:~/Dropbox/Projects"
export PATH="~/.dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/local/php5/bin:$PATH"

# case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Colors the way I like em
export LSCOLORS=BxGxFxdxCxDxDxhbadBxBx

# Larger bash history (unlimited)
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoredups

# Make some commands not show up in history
# export HISTIGNORE="ls:ls *"

export EVENT_NOKQUEUE=1
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
export COPYFILE_DISABLE=true

# Prompt
# export PS1='\[\e[1;32m\][\[\e[1;35m\]\[\e[1;32m\]\[\e[1;32m\]\[\e[1;36m\]\w\[\e[1;33m\]$(parse_git_branch)\[\e[1;32m\]]$ \[\e[0m\]'
export PS1='\[\e[1;36m\]\w\[\e[1;32m\]$(parse_git_branch)\[\e[1;32m\] ✪ \[\e[0m\]'
# function _update_ps1() {
#   export PS1="$(~/Projects/powerline-shell/powerline-shell.py $?) "
# }
# export PROMPT_COMMAND="_update_ps1"

# JRuby
export JRUBY_OPTS=--1.9

# Gopath
export GOPATH=~/go

# Terraform Path
export TERRAFORM_BIN=/usr/local/bin/terraform

# Tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
