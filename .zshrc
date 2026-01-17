# Historial
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups

#Autocompletado
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Colores
autoload -Uz colors && colors

#Aliases útiles
alias ls='colorls -a'
alias ll='colorls -la'
alias la 'colorls -l'
alias grep='grep --color=auto'
alias c='clear'
alias q='exit'
alias v='nano'
alias update='sudo pacman -Syu'

#keybindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#Starship prompt
eval "$(starship init zsh)"
