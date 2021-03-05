# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PROJECTS="$HOME/Projects"
export DOTFILES="$PROJECTS/dotfiles"

export EDITOR='emacs'
export VEDITOR='emacs'

if [ -n "$INSIDE_EMACS" ]; then
  export TERM=dumb
else
  export TERM=xterm-256color
fi

export PATH="~/.local/bin:$PATH"
export PATH="/home/russ/.asdf/installs/python/3.7.2/bin:$PATH"
export PATH="/home/russ/go/bin:$PATH"
export PATH="$PATH":"$HOME/.pub-cache/bin"

# all of our zsh files
typeset -U config_files
# config_files=($DOTFILES/*/*.zsh)
config_files=($DOTFILES/zsh/*.zsh)

# load extra path files
for file in ${(M)config_files:#*/path.zsh}; do
  source "$file"
done

# load antibody plugins
source <(antibody init)
antibody bundle < $DOTFILES/zsh/plugins.txt

# load everything but the path and completion files
for file in ${${config_files:#*/zshrc.zsh}:#*/completion.zsh}; do
  source "$file"
done

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
kitty + complete setup zsh | source /dev/stdin

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}; do
  source "$file"
done

. $HOME/.asdf/asdf.sh
# . $HOME/.asdf/completions/asdf.bash
. /usr/share/z/z.sh

unset config_files updated_at

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

## GNUPG Yubikey setup
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/russ/Projects/edgeo/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/russ/Projects/edgeo/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/russ/Projects/edgeo/node_modules/tabtab/.completions/sls.zsh ]] && . /home/russ/Projects/edgeo/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/russ/Projects/edgeo/node_modules/tabtab/.completions/slss.zsh ]] && . /home/russ/Projects/edgeo/node_modules/tabtab/.completions/slss.zsh
