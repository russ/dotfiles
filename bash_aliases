# PS
alias psg="ps aux | grep $1"

# Better Vim
alias vim='mvim -v'
alias vi='vim'

# Moving around
alias ..='cd ..'
alias cdb='cd -'

# Show human friendly numbers and colors
alias df='df -h'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias du='du -h -d 1'

# show me files matching "ls grep"
alias lsg='ll | grep'

# Alias Editing
alias ae='vi ~/.dotfiles/bash_aliases' #alias edit
alias ar='. ~/.dotfiles/bash_aliases'  #alias reload

# Bash Options Editing
alias boe='vi ~/.dotfiles/bash_options' 
alias bor='. ~/.dotfiles/bash_options' 

# .bash_profile editing
alias bp='vi ~/.bash_profile'
alias br='. ~/.bash_profile'

# Common bash functions
alias less='less -r'
alias more='less'
alias tf='tail -f'
alias l='less'
alias lh='ls -alt | head' # see the last modified files
alias fn="find . -name"
alias screen='TERM=screen screen'

# Zippin
alias gz='tar -zcvf'

# Kill
alias ka9='killall -9'
alias k9='kill -9'

# This trick makes sudo understand all my aliases
alias sudo='sudo '

# Vagrant
alias v="vagrant"

# Bundler
alias b="bundle exec"

# Rails
alias r="rails"
alias rc="rails console"
