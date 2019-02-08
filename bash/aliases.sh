alias c='clear'
alias h='history'

# PS
alias psg="ps aux | grep $1"

# Better Vim
alias vim='mvim -v -w ~/.vimlog "$@"'
alias vi='vim'
alias v='vim'
alias vwrite='vim -u ~/.vim-writing'

# tmux
alias tx='tmuxinator'
alias tat='tmux new-session -As `basename $PWD`'

# Vagrant
alias vg='vagrant'

# Moving around
alias ..='cd ..'
alias cdb='cd -'

# Show human friendly numbers and colors
alias a='ls -lrthG'
alias df='df -h'
alias ll='ls -alGh'
# alias ls='ls -Gh'
alias ls='exa -lah --git'
alias du='du -h -d 1'

# show me files matching "ls grep"
alias lsg='ll | grep'

# edit all files that match
vigrep () {
  vi $(grep -Ril $1 $2)
}

pretty_json () {
  curl $1 | python -mjson.tool
}

alias g='ack'

# Alias Editing
alias ae='vi ~/.dotfiles/bash/aliases.sh' #alias edit
alias ar='. ~/.dotfiles/bash/aliases.sh'  #alias reload

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

# Bundler
alias b="bundle exec"
alias be="bundle exec"

# Rails
alias r="rails"
alias rc="rails console"
alias rs="rails server"
alias resetdb="bundle exec rake db:migrate:reset && bundle exec rake db:seed"
alias dbmrt="dbmr RAILS_ENV=test"

# Typos
alias dc="cd"
alias gti="cd"

# Git
alias g="git status"
