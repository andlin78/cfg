######################
### Terminal setup ###
######################

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

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
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

###################
### zplug setup ###
###################

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

########################################
### Settings for zsh-autosuggestions ###
########################################

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
bindkey '^ ' autosuggest-accept
bindkey '^^M' autosuggest-execute

#######################
### Start powerline ###
#######################

if hash powerline-daemon 2>/dev/null; then
	powerline-daemon -q 2> /dev/null
	source /usr/share/powerline/bindings/zsh/powerline.zsh 2> /dev/null
fi

###############
### Aliases ###
###############

alias ls='ls --color'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

#######################################
### Display screenfetch and weather ###
#######################################
#
if [ "$TTY" = "$SSH_TTY" ]; then
  if hash screenfetch 2>/dev/null; then
	clear
	echo
	screenfetch
	tput sc # save cursor position

	while [ $((++i)) -lt 9 ]; do tput cuu1; done

	tput cuf 30 # Move colums right

	while IFS= read -r Wttr; do
  		printf "$Wttr"
  		tput cud1 # Down one line
  		tput cuf 30 # Move columns right
  		LineCnt=$((++LineCnt))
	done < <(curl -s "wttr.in/Uddevalla?lang=sv" | head -n7 | tail -n6)

	tput rc # Recall cursor position
	echo
  fi
fi
