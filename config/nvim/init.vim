set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set nocompatible 
set secure exrc
set encoding=utf-8
scriptencoding utf-8

"source ~/.vimrc

" set leader
let mapleader=","
let g:mapleader=","

nmap <leader>s :w!<cr>
map <leader>j :j<cr>
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
map <leader>. <esc>@:

map <leader>f <esc>:lua vim.lsp.buf.formatting()<cr>

map <leader>u <esc>guiw
map <leader>U <esc>gUiw

map <C-n> :NERDTreeToggle<CR>
map <C-_> <leader>cij
map <C-\> :Ack! 

"
" Plugins
" 
call plug#begin('~/.local/share/nvim/plugged')
    nmap <silent> <leader>p :PlugInstall<cr>

""" Editing helper 
Plug 'fadein/vim-FIGlet'
Plug 'jlanzarotta/bufexplorer'
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}
Plug 'tpope/vim-repeat'
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

"    
""" NERDTree
"
Plug 'scrooloose/nerdtree'
"let g:NERDTreeShowHidden = 1
"let NERDTreeShowHidden=1
let g:NERDTreeIgnore=['.git', 'node_modules', '\.o$', '\.a$', '.depend']
"autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let s:brown = "905532"
    let g:NERDTreeExtensionHighlightColor = {}
    let g:NERDTreeExactMatchHighlightColor = {}
    let g:NERDTreeExtensionHighlightColor['js'] = s:brown
    let g:NERDTreeExtensionHighlightColor['yml'] = ''
    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = ''

Plug 'ryanoasis/vim-devicons'
"    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
"    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = '﵂'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let s:brown = "905532"
    let g:NERDTreeExtensionHighlightColor = {}
    let g:NERDTreeExactMatchHighlightColor = {}
    let g:NERDTreeExtensionHighlightColor['js'] = s:brown
    let g:NERDTreeExtensionHighlightColor['yml'] = ''
    let g:NERDTreeExactMatchHighlightColor['.gitignore'] = ''

Plug 'mileszs/ack.vim'
      if executable('ag') 
        let g:ackprg = 'ag --vimgrep'
      endif

Plug 'ctrlpvim/ctrlp.vim'
  map <leader>t <esc>:CtrlP<cr>


Plug 'kyazdani42/nvim-web-devicons'

Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'tmux-plugins/vim-tmux-focus-events'

"
""" LSP
"
Plug 'neovim/nvim-lspconfig'

"
""" Theme
"
Plug 'NLKNguyen/papercolor-theme'
Plug 'hoob3rt/lualine.nvim'

call plug#end()


set background=dark
colorscheme PaperColor
lua require('lualine').setup()

"""
""" lsp configurations
"""
""" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#denols
"""

lua << EOF
 require'lspconfig'.bashls.setup{}
 require'lspconfig'.ccls.setup{}
 require'lspconfig'.cmake.setup{}
 require'lspconfig'.dartls.setup{}
 require'lspconfig'.denols.setup{}
 require'lspconfig'.pyls.setup{}
 require'lspconfig'.vimls.setup{}
 require'lspconfig'.yamlls.setup{}
EOF

lua << EOF
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buffer.formatting()<CR>", opts);

end
EOF

filetype plugin indent on

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
autocmd FileType asm set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
