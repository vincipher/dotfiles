# ~/.zshrc - Clean and commented for Arch Linux with Starship prompt

########## Zsh Options ##########
setopt autocd                   # Change directory just by typing its name
setopt interactivecomments      # Allow comments in interactive mode
setopt magicequalsubst          # Enable filename expansion in assignments (e.g., var=*)
setopt nonomatch                # Suppress error if a glob doesn't match anything
setopt notify                   # Notify about background job status
setopt numericglobsort          # Sort globbed files numerically
setopt promptsubst              # Allow command substitution in prompts

WORDCHARS=${WORDCHARS//\/}      # Don't treat / as part of a word for cursor movement
PROMPT_EOL_MARK=""              # Hide the % sign at end of each prompt line

########## Keybindings ##########
bindkey -e                      # Use Emacs-style keybindings
bindkey ' ' magic-space         # Do history expansion on space
bindkey '^U' backward-kill-line # Ctrl+U clears the line

# Navigation and editing keys (for better terminal experience)
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
compinit -d ~/.cache/zcompdump   # Cache file to speed up future shell loads

# Completion styling
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

setopt hist_expire_dups_first   # Remove duplicates when trimming history
setopt hist_ignore_dups         # Ignore duplicate entries
setopt hist_ignore_space        # Don't record commands that start with a space
setopt hist_verify              # Show command before running after expansion

alias history="history 0"       # Show full history with `history`

########## `time` Command Output ##########
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

########## Aliases ##########

# File/Directory listing with `lsd` (if installed)
alias ls='lsd'
alias ll='lsd -l'
alias lt='lsd -l --tree'
alias lat='lsd -la --tree'
alias l='lsd -F'
alias la='lsd -AF'
alias lah='lsd -lAF'
alias tt='lsd -lah --tree'
alias tree='lsd -lh --tree'
# Directory & File Management
alias md='mkdir -p'
alias rd='rmdir'
alias rmf='rm -rf'

# Clipboard shortcuts
alias c='xsel -ib'             # Copy to clipboard
alias p='xsel -ob'             # Paste from clipboard

# Git shortcuts
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


# Directory navigation
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
alias ports='netstat -tulanp'
alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

# Alias for yazi or ranger
if command -v yazi >/dev/null 2>&1; then
    alias rr='yazi'
elif command -v ranger >/dev/null 2>&1; then
    alias rr='ranger'
else
    alias rr='echo "Neither yazi nor ranger is installed."'
fi


# Pacman (core system)
if command -v pacman &>/dev/null; then
  alias update='sudo pacman -Syu'
  alias cleanup='pacman -Qdtq | xargs -r sudo pacman -Rns'
  alias ins='sudo pacman -S'
  alias rem='sudo pacman -Rns'
  alias se='pacman -Ss'
  alias qi='pacman -Qi'
  alias files='pacman -Ql'
  alias owns='pacman -Qo'
fi

# Yay (AUR + repo)
if command -v yay &>/dev/null; then
  alias y='yay'
  alias yup='yay -Syu'
  alias yclean='yay -Qdtq | xargs -r yay -Rns'
  alias ys='yay -Ss'
  alias ysi='yay -Si'
  alias yins='yay -S'
  alias yrem='yay -R'
fi


########## Dircolors / LS_COLORS ##########
# Enables color output for tools like `ls` and `completion`
if command -v dircolors &>/dev/null; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:"
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

########## Plugins ##########

# Syntax highlighting (make sure zsh-syntax-highlighting is installed)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Command autosuggestions from history
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# Suggest packages when command is not found (requires pkgfile)
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

########## External Tools ##########

# Starship prompt
eval "$(starship init zsh)"
# zoxide: smarter cd replacement
eval "$(zoxide init zsh)"
# Atuin: better shell history
eval "$(atuin init zsh)"
# The Fuck: correct previous command
#eval "$(thefuck --alias)"

