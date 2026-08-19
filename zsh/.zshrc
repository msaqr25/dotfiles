# ============================================================
#  ZSH Configuration
# ============================================================

# ------------------------------------------------------------
#  Instant Prompt (Powerlevel10k)
#  Must stay close to the top of ~/.zshrc.
#  Anything that needs console input must go ABOVE this block.
# ------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------
#  Homebrew
# ------------------------------------------------------------
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ------------------------------------------------------------
#  Zinit (Plugin Manager)
# ------------------------------------------------------------
# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------------------------------------
#  Plugins
# ------------------------------------------------------------
# Powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ZSH plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# OMZ snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# ------------------------------------------------------------
#  Completions
# ------------------------------------------------------------
autoload -Uz compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------
#  History
# ------------------------------------------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ------------------------------------------------------------
#  Keybindings
# ------------------------------------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[OA' fzf-history-widget

# ------------------------------------------------------------
#  Completion Styling
# ------------------------------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ------------------------------------------------------------
#  Shell Integrations (fzf, zoxide)
# ------------------------------------------------------------
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# ------------------------------------------------------------
#  Aliases
# ------------------------------------------------------------
alias c='clear'
alias py='python3'
alias g='lazygit'

# ------------------------------------------------------------
#  File System (eza)
# ------------------------------------------------------------
if command -v eza &> /dev/null; then
  alias ls='eza -alh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# FZF file search with bat preview
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# zoxide-powered cd wrapper
if command -v zoxide &> /dev/null; then
  alias cd="zd"
  zd() {
    if [ $# -eq 0 ]; then
      builtin cd ~ && return
    elif [ -d "$1" ]; then
      builtin cd "$1"
    else
      z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
    fi
  }
fi

# ------------------------------------------------------------
#  Dev Tools (uv, atuin, direnv)
# ------------------------------------------------------------
# uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# direnv
eval "$(direnv hook zsh)"

# ------------------------------------------------------------
#  PATH
# ------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------------------------
#  Docker
#  Added by Docker Desktop for Docker CLI completions.
# ------------------------------------------------------------
fpath=(/Users/saqr/.docker/completions $fpath)
# autoload -Uz compinit
# compinit

# ------------------------------------------------------------
#  Node Version Manager (nvm)
# ------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"              # loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # loads nvm bash_completion
