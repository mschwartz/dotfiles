set nocompatible 
filetype off

" set leader
let mapleader=","
let g:mapleader=","

" key bindings
nmap <leader>w :w!<cr>
map <leader>s :source ~/.vimrc<cr>
map <leader>e :e! ~/.vimrc<cr>
map <leader>f :ALEFix<cr>
map <leader>pi :PluginInstall<cr>
map <leader>ip <esc>iimport PropTypes from 'prop-types'<cr><esc>
map <leader>ir <esc>iimport React, {Component} from 'react'<cr><esc>
map <C-n> :NERDTreeToggle<CR>
imap jj <Esc>
nmap <F1> :echo<CR>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Plugins
" 
Plugin 'vundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mileszs/ack.vim'
Plugin 'wincent/command-t'
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-obsession'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_autosave_to = 'default'
let g:session_verbose_messages = 0
Plugin 'Raimondi/delimitMate'

" mode line
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Language Support
"Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys=1

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'leshill/vim-json'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'digitaltoad/vim-pug'
Plugin 'dNitro/vim-pug-complete'
Plugin 'heavenshell/vim-jsdoc'
nmap <leader>j :JsDoc<cr>
Plugin 'othree/jsdoc-syntax.vim'
Plugin 'itmammoth/doorboy.vim'

" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String
Plugin 'Yggdroot/indentLine'

"Plugin 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1
"let g:indent_guides_start_level = 2

"""""" ale
Plugin 'w0rp/ale'
" Put this in vimrc or a plugin file of your own.
" After this is configured, :ALEFix will try and fix your JS code with ESLint.

let g:ale_fixers = {
            \   'javascript': ['eslint'],
            \}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1

" Enable completion where available.
let g:ale_completion_enabled = 1

"""""" test runner
"Plugin 'janko-m/vim-test'
"let g:test#javascript#jest#file_pattern = '\.test\.js$'
"nmap <silent> <leader>tt :TestSuite<cr>
"nmap <silent> <leader>t. :TestFile<cr>
nmap <silent> <leader>p :PluginInstall<cr>

Plugin 'scrooloose/nerdcommenter'

" NERDTree
Plugin 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let s:brown = "905532"
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExactMatchHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['js'] = s:brown
let g:NERDTreeExtensionHighlightColor['yml'] = ''
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = ''


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" End of Plugins
call vundle#end()
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
"

" VIM options
set autoread
set clipboard=unnamed
set ls=1
set showcmd
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set hlsearch
set incsearch
set ruler
set nobackup
set directory=$HOME/.vim/swapfiles//
set undodir=~/.vim/undo-dir
set undofile
set number
set ignorecase
set title
set ttyfast
set modeline
set modelines=3
set mouse=a
syntax enable
set wildmenu
set cursorline
set so=7
set cmdheight=2
set lz
set hid
set whichwrap+=<,>,h,l
set noerrorbells
set novisualbell
set t_vb=
set showmatch
set mat=2

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
'

"Format the statusline
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/mschwartz/', "~/", "g")
    return curdir
endfunction

"set statusline=%#Warningmsg#
""  set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %{VCSCommandGetStatusLine()}}

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" variable settings

let g:ackprg = 'ag --nogroup --nocolor --column'
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

augroup reload_vimrc
    autocmd!
    autocmd bufwritepost ~/.vimrc nested source ~/.vimrc
augroup END

let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \ }


function! LightLineModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! LightLineReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "⭤"
    else
        return ""
    endif
endfunction

function! LightLineFugitive()
    if exists('*fugitive#head')
        let _ = fugitive#head()
        return strlen(_) ? ("\ue0a0 " . _) : ''
    endif
    return ''
"    return exists('*fugitive#head') ? ("\ue0a0" . fugitive#head()) : ''
endfunction

function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
                \ ('' != expand('%:f') ? expand('%:f') : '[No Name]') .
                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

set background=light
colorscheme PaperColor

let javascript_enable_domhtmlcss=1

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

set t_Co=256
map <Esc>[0c <C-RIGHT>
map <Esc>[0d <C-LEFT>>
    
set encoding=utf-8
scriptencoding utf-8

autocmd FileType javascript set formatprg=prettier\ --stdin

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

