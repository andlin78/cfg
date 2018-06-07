# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/pi/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install



# Check if zplug is installed
# Requires git & awk (not mawk)
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# Essential
source ~/.zplug/init.zsh

zplug "joel-porquet/zsh-dircolors-solarized"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load

#####################################
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

powerline-daemon -q 2> /dev/null
source /usr/share/powerline/bindings/zsh/powerline.zsh 2> /dev/null

alias ls='ls --color'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
