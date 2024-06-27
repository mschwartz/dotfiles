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
"set colorcolumn=+1

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
set directory=$HOME/.config/nvim/swapfiles/
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

if !exists('g:vscode')
"
" Plugins
" 
call plug#begin('~/.local/share/nvim/plugged')
    nmap <silent> <leader>p :PlugInstall<cr>

"
""" Editing helpers
"

if (!exists('g:vscode'))
"
""" Theme
"
Plug 'NLKNguyen/papercolor-theme'
Plug 'hoob3rt/lualine.nvim'
"Plug 'itchyny/lightline.vim'
"  let g:lightline = {
"        \ 'colorscheme': 'PaperColor',
"        \ 'active': {
"        \   'left': [ [ 'mode', 'paste' ],
"        \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] 
"        \   ]
"        \ },
"        \ 'component_function': {
"        \   'gitbranch': 'fugitive#head',
"        \   'filename': 'LightlineFilename'
"        \ },
"        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
"      \ }
" restore last cursor position when opening a file again
Plug 'farmergreg/vim-lastplace'

" color match parens/braces/etc.
Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1

"Plug 'jiangmiao/auto-pairs'
"Plug 'cohama/lexima.vim'

" insert matching delimeters
Plug 'raimondi/delimitmate'

" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'

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
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg)
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:bg .' guifg='. a:fg
endfunction

call NERDTreeHighlightFile('forrh', 'green', 'black')

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




"Plug 'ryanoasis/vim-devicons'
"    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vue'] = '﵂'

Plug 'kyazdani42/nvim-web-devicons'
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
"let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['fth']  = 'F'


"
""" Search/fuzzy/grep
"
Plug 'mileszs/ack.vim'
      if executable('ag') 
        let g:ackprg = 'ag --vimgrep'
      endif

Plug 'ctrlpvim/ctrlp.vim'
  map <leader>t <esc>:CtrlP<cr>

Plug 'dyng/ctrlsf.vim'
  let g:ctrlsf_position = 'bottom'
  let g:ctrlsf_default_view_mode = 'compact'
  let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

"
""" TMUX
"
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'tmux-plugins/vim-tmux-focus-events'

"
""" React/JSX
"
Plug 'chemzqm/vim-jsx-improve'

"
""" LSP
"
Plug 'neovim/nvim-lspconfig'
  " Jump to definition
  nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
  " Jump to definition
  nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
  " Open code actions using the default lsp UI, if you want to change this please see the plugins above
  nnoremap <leader>ca <Cmd>lua vim.lsp.buf.code_action()<CR>
  " Open code actions for the selected visual range
Plug 'hrsh7th/nvim-compe'
  " https://github.com/hrsh7th/nvim-compe#vim-script-config
  set completeopt=menuone,noselect

  let g:compe = {}
  let g:compe.enabled = v:true
  let g:compe.autocomplete = v:true
  let g:compe.debug = v:false
  let g:compe.min_length = 1
  let g:compe.preselect = 'enable'
  let g:compe.throttle_time = 80
  let g:compe.source_timeout = 200
  let g:compe.resolve_timeout = 800
  let g:compe.incomplete_delay = 400
  let g:compe.max_abbr_width = 100
  let g:compe.max_kind_width = 100
  let g:compe.max_menu_width = 100
  let g:compe.documentation = v:true

  let g:compe.source = {}
  let g:compe.source.path = v:true
  let g:compe.source.buffer = v:true
  let g:compe.source.calc = v:true
  let g:compe.source.nvim_lsp = v:true
  let g:compe.source.nvim_lua = v:true
  let g:compe.source.vsnip = v:true
  let g:compe.source.ultisnips = v:true
  let g:compe.source.luasnip = v:true
  let g:compe.source.emoji = v:true


"
""" Flutter/Dart
"

"
""" pug
"
"Plug 'digitaltoad/vim-pug', {'for': ['jade', 'pug'] }
Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'digitaltoad/vim-pug'
"Plug 'dNitro/vim-pug-complete'
"au BufRead,BufNewFile *.pug setfiletype html

"
""" forth
"
au BufRead,BufNewFile *.fth setfiletype forth
autocmd FileType forth set tabstop=4 shiftwidth=4 softtabstop=4


call plug#end()


if (exists('+termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
colorscheme PaperColor
endif
"""
""" lsp configurations
"""
""" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#denols
"""

if !exists('g:vscode')
" require'lspconfig'.tsserver.setup{}
>>>>>>> 2640c9c4ef53ae7c3c612b3439c8066afb4d2b86
lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  forth = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Forth"
  },
  fth = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Forth"
  }
 };

 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["fth"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

require'lualine'.setup{ 
  options = { theme = 'auto'}
}
 require'lspconfig'.bashls.setup{}
 require'lspconfig'.ccls.setup{}
 require'lspconfig'.cmake.setup{}
 require'lspconfig'.tsserver.setup{}
 require'lspconfig'.pylsp.setup{}
 require'lspconfig'.vimls.setup{}
 require'lspconfig'.yamlls.setup{}
 require'lspconfig'.dartls.setup{ cmd = { "dart", "./snapshots/analysis_server.dart.snapshot", "--lsp"  } }
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
  
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab toj
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
<<<<<<< HEAD
=======
end
>>>>>>> 2640c9c4ef53ae7c3c612b3439c8066afb4d2b86

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
end
EOF
<<<<<<< HEAD

end

=======

endif

>>>>>>> 2640c9c4ef53ae7c3c612b3439c8066afb4d2b86
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

if exists('g:vscode')
nmap <leader>s :Write<cr>
nmap <leader>ci <cmd>call VSCodeCall('editor.action.commentLine')<cr>
else
nmap <leader>s :w!<cr>
endif

map <leader>j :j<cr>
"map <leader>c :CtrlSF 

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

map <leader>} ysiw}
map <leader>{ ysiw{
map <leader>] ysiw]
map <leader>[ ysiw[
map <leader>" ysiw"
map <leader>' ysiw'
map <leader>) ysiw)
map <leader>( ysiw(


if exists('g:vscode')
map <leader>f <cmd>call VSCodeNotify('editor.action.formatDocument')<cr>
else
map <C-n> :NERDTreeToggle<CR>
map <leader>. <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
map <leader>f <esc>:lua vim.lsp.buf.formatting()<cr>
map <C-]> :lua vim.lsp.buf.definition()<cr>
endif

map <leader>u <esc>guiw
map <leader>U <esc>gUiw

map <C-_> <leader>cij
map <C-\> :Ack! 

imap jj <Esc>
imap jk <Esc>
imap kkk <Esc>
nmap <F1> :echo<CR>
vnoremap <C-c> "+y
map <C-v> "+P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""
""" SPELLING
"""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iab eciton ection
iab aDireciton aDirection
iab mDireciton aDirection
iab direciton direction
iab Direciton Direction
iab DIRECITON DIRECTION
iab colleciton collection
iab COLLECITON COLLECTION
