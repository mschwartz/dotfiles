set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set nocompatible 
set secure exrc
set encoding=utf-8
scriptencoding utf-8

"source ~/.vimrc

"
" VIM options
"
set wildmode=longest,list,full
set guicursor=
set ttyfast
set nowrap
set autoread
set nolazyredraw
set backspace=2

set textwidth=120
set colorcolumn=+1

call matchadd('ColorColumn', '\%81v', 100)

if $TMUX ==''
  set clipboard=unnamed
endif

set ls=1
set showcmd
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab

" searching
set smartcase
set hlsearch
set incsearch

set ruler
set nobackup
set directory=$HOME/.config/nvim/swapfiles//
set undodir=~/.config/nvim/undo-dir
set undofile
set number relativenumber
set ignorecase
set title
set ttyfast
"set modeline
"set modelines=3
set mouse=a
syntax enable
set wildmenu
set cursorline
set so=7
set cmdheight=3
set lz
set hid
set whichwrap+=<,>,h,l
set noerrorbells
set novisualbell
set t_vb=
set showmatch
set mat=2

<<<<<<< HEAD
" Plugins
" 
call plug#begin('~/.local/share/nvim/plugged')
    nmap <silent> <leader>p :PlugInstall<cr>

Plug 'scrooloose/nerdcommenter'
    let g:NERDCustomDelimiters = { 
          \ 'S': { 'left': '#' },
          \ 's': { 'left': '#' },
          \ 'asm': { 'left': ';' }
          \ }

    " Use compact syntax for prettified multi-line comments
    "let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'start'
    let g:NERDCustomDelimiters = { 'forth': { 'left': '\ ','right': '' } }

    " Allow commenting and inverting empty lines (useful when commenting a region)
    "let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    "let g:NERDTrimTrailingWhitespace = 1

call plug#end()

=======
>>>>>>> 88b56184da37ec481ba778ec2f8fe338feec0e8e
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""
""" KEY BINDINGS
"""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-f> :CtrlSF 

" set leader
let mapleader=","
let g:mapleader=","

<<<<<<< HEAD
nmap <leader>s :w<cr>
=======
nmap <leader>s :w!<cr>
>>>>>>> 88b56184da37ec481ba778ec2f8fe338feec0e8e
map <leader>j :j<cr>
map <leader>c :CtrlSF 

"map <leader>ai :ALEInfo<cr>
"map <leader>ad :ALEDetail<cr>
"map <leader>f :ALEFix<cr>
"  map <leader>s :source ~/.vimrc<cr>
map <leader>e3 :e! ~/.config/i3/config<cr>
map <leader>ea :e! ~/dotfiles/zsh/aliases.zsh<cr>
map <leader>eb :e! ~/dotfiles/config/i3/i3blocks.conf<cr>
map <leader>ee :e! ~/dotfiles/zsh/env.zsh<cr>
map <leader>ef :e! ~/dotfiles/zsh/functions.zsh<cr>
map <leader>ep :e ~/dotfiles/config/polybar/config<cr>
map <leader>er :e! ~/dotfiles/config/ranger/rc.conf<cr>
map <leader>en :e! ~/.config/nvim/init.vim<cr>
map <leader>ev :e! ~/.vimrc<cr>
map <leader>et :e! ~/dotfiles/tmux.conf<cr>
map <leader>ez :e! ~/.zshrc<cr>
map <leader>l :nohlsearch<cr>
map <leader>pi :PluginInstall<cr>
map <leader>ip <esc>iimport PropTypes from 'prop-types'<cr><esc>
map <leader>ir <esc>iimport React, {useState, useEffect, useRef} from 'react'<cr><esc>
map <leader>iu <esc>iimport useConfig from "@/common/hooks/useConfig";<cr><esc>
map <leader>itc <esc>otry {<cr>}<cr>catch(e) {<cr>console.log('exception', e)<cr><esc>ddjddkkkk==ko
map <leader>v <esc>:read !xsel<cr>
"map <leader>. <esc>@:

<<<<<<< HEAD
nmap <leader>s :Write<cr>

"nmap <leader>ci <cmd>call VSCodeCall('editor.action.commentLine')<cr>
map <leader>ci <cmd>call VSCodeCall('editor.action.addCommentLine')<cr>
=======
>>>>>>> 88b56184da37ec481ba778ec2f8fe338feec0e8e
map <leader>} ysiw}
map <leader>{ ysiw{
map <leader>] ysiw]
map <leader>[ ysiw[
map <leader>" ysiw"
map <leader>' ysiw'
map <leader>) ysiw)
map <leader>( ysiw(

map <leader>. <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
<<<<<<< HEAD
"map <leader>f <esc>:lua vim.lsp.buf.formatting()<cr>
map <leader>f <cmd>call VSCodeCall('editor.action.format')<cr>
=======
map <leader>f <esc>:lua vim.lsp.buf.formatting()<cr>
>>>>>>> 88b56184da37ec481ba778ec2f8fe338feec0e8e

map <leader>u <esc>guiw
map <leader>U <esc>gUiw

map <C-n> :NERDTreeToggle<CR>
map <C-_> <leader>cij
map <C-\> :Ack! 
map <C-]> :lua vim.lsp.buf.definition()<cr>

imap jj <Esc>
imap jk <Esc>
imap kkk <Esc>
nmap <F1> :echo<CR>
vnoremap <C-c> "+y
map <C-v> "+P

<<<<<<< HEAD
=======
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
>>>>>>> 88b56184da37ec481ba778ec2f8fe338feec0e8e

filetype plugin indent on

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
autocmd FileType asm set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

augroup reload_init_vim
    autocmd!
    autocmd bufwritepost ~/.config/nvim/init.vim nested source ~/.config/nvim/init.vim
augroup END

