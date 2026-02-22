" =========================
" Basic Settings
" =========================

set nocompatible              " Disable old vi compatibility
set number                    " Show line numbers
set relativenumber            " Relative line numbers
set tabstop=4                 " A tab = 4 spaces
set shiftwidth=4
set expandtab                 " Use spaces instead of tabs
set smartindent
set autoindent
set wrap                      " Wrap long lines
set cursorline
set showcmd
set wildmenu
set hidden
set clipboard=unnamedplus     " Use system clipboard
set ignorecase
set smartcase
set incsearch
set hlsearch
set termguicolors
set mouse=a

syntax on
filetype plugin indent on

" =========================
" Better Keybindings
" =========================

let mapleader=" "

" Save
nnoremap <leader>w :w<CR>

" Quit
nnoremap <leader>q :q<CR>

" Clear search highlight
nnoremap <leader>h :nohlsearch<CR>

" Easier split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" =========================
" Nice Colorscheme
" =========================
colorscheme catppuccin_mocha
