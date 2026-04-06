# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Profile
export MAC_PROFILE=$(cat ~/.mac-profile 2>/dev/null || echo "personal")

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Shell options
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

autoload -Uz compinit
compinit

# Tooling
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# Aliases
alias ls='eza'
alias ll='eza -lah --group-directories-first --git'
alias la='eza -la --group-directories-first'
alias lt='eza --tree --level=2'

alias cat='bat'
alias grep='rg'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias cd='z'
export PATH="$HOME/.local/bin:$MAC_SETUP_ROOT/dotfiles/bin:$PATH"

# Plugins
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Keybindings
bindkey -s '^f' 'tmux-sessionizer\n'
