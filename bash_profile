# Load secret stuff that I don't want to share with the world on github :)
if [ -e ~/.secrets ]; then
  . ~/.secrets
fi

. ~/.dotfiles/bash_aliases
. ~/.dotfiles/bash_options
. ~/.dotfiles/osx
. ~/.dotfiles/ruby

eval "$(rbenv init -)"
