# Dotfiles

Personal configuration files managed with GNU Stow.

---

## Requirements

Install required programs:

```bash
sudo apt update
sudo apt install git lazygit stow make gcc curl wget fastfetch unzip
```

Install Python tools:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh # Install uv
uv tool install ruff ty # Python type checker, linter and formatter
```

---

## Clone Repo

```bash
git clone git@github.com:msaqr25/dotfiles.git
cd dotfiles
```

---

## Zsh

### Pre-setup

```bash
sudo apt install zsh fzf fd-find eza zoxide
chsh -s $(which zsh) # Change default shell to Zsh
```

### Apply

```bash
stow zsh
```

---

## Vim

### Pre-setup

```bash
sudo apt install vim-gtk3 # Vim with system clipboard support
git clone https://github.com/catppuccin/vim.git ~/.vim/pack/vendor/start/catppuccin # Install Catppuccin theme for vim
```

### Apply

```bash
stow vim
```

---

## Tmux

Config target:

```
~/.config/tmux/tmux.conf
```

### Pre-setup

```bash
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

### Apply

```bash
stow tmux
```

---

## Remove

```bash
stow -D zsh
stow -D vim
stow -D tmux
```
