# ~/.zshrc - Clean and optimized for Fedora with Starship

########## Zsh Options ##########
setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst

WORDCHARS=${WORDCHARS//\/}
PROMPT_EOL_MARK=""

########## Keybindings ##########
bindkey -e
bindkey ' ' magic-space
bindkey '^U' backward-kill-line

bindkey '^[[3;5~' kill-word
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[Z' undo

########## Command Completion ##########
autoload -Uz compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

########## History ##########
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

alias history="history 0"

########## `time` Command Output ##########
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

########## Aliases ##########

# lsd (if installed)
alias ls='lsd'
alias ll='lsd -l'
alias lt='lsd -l --tree'
alias lat='lsd -la --tree'
alias l='lsd -F'
alias la='lsd -AF'
alias lah='lsd -lAF'
alias tt='lsd -lah --tree'
alias tree='lsd -lh --tree'

# File management
alias md='mkdir -p'
alias rd='rmdir'
alias rmf='rm -rf'

# Clipboard (Fedora uses xclip more commonly)
alias c='xclip -selection clipboard'
alias p='xclip -selection clipboard -o'

# Git
alias gs="git status -sb"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gw="git switch"
alias gb="git branch"
alias gcm="git checkout main"
alias gundo='git reset --soft HEAD~1'
alias gamend='git commit --amend --no-edit'
alias glog='git log --graph --pretty=format:"%C(auto)%h%d %s %C(blue)%cr %C(green)(%an)" --all'

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....='cd ../../..'

# Misc
alias cl="clear"
alias by="exit"
alias v='nvim'
alias lg='lazygit'
alias tx='tmux'
alias py='python3'
alias ports='ss -tulanp'   # better than netstat
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# File manager fallback
if command -v yazi >/dev/null 2>&1; then
    alias rr='yazi'
elif command -v ranger >/dev/null 2>&1; then
    alias rr='ranger'
else
    alias rr='echo "Neither yazi nor ranger is installed."'
fi

########## Fedora Package Management (DNF) ##########
if command -v dnf &>/dev/null; then
  alias update='sudo dnf upgrade --refresh'
  alias install='sudo dnf install'
  alias remove='sudo dnf remove'
  alias search='dnf search'
  alias info='dnf info'
  alias cleanup='sudo dnf autoremove'
fi

########## Dircolors ##########
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

########## Plugins ##########

# Fedora plugin paths (via dnf packages)
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# command-not-found (Fedora version)
if [ -f /usr/share/zsh/site-functions/command-not-found ]; then
    source /usr/share/zsh/site-functions/command-not-found
fi

########## External Tools ##########

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
# eval "$(thefuck --alias)"
