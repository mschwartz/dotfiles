" File              : /home/mschwartz/.vimrc
" Author            : Michael Schwartz <mykesx@gmail.com>
" Date              : 21.06.2018
" Last Modified Date: 21.06.2018
" Last Modified By  : Michael Schwartz <mykesx@gmail.com>
set nocompatible 
set secure exrc
set encoding=utf-8
scriptencoding utf-8

"set fileformat=unix
"set ma
filetype off
set tags=./tags
set autoread
au FocusGained,BufEnter * :checktime
set foldmethod=marker
set updatetime=100
set signcolumn=yes
set iskeyword+=_

map <leader>f :Format<cr>
" set leader
let mapleader=","
let g:mapleader=","

if (exists('+termguicolors'))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Speelling
iab eciton ection
iab aDireciton aDirection
iab mDireciton aDirection
iab direciton direction
iab Direciton Direction
iab DIRECITON DIRECTION
iab colleciton collection
iab COLLECITON COLLECTION

" auto commands

autocmd! 

" for arduino
autocmd BufNewFile,BufReadPost *.c,*.cpp,*.h,*.ino,*.pde set filetype=cpp
autocmd BufNewFile,BufReadPost *.md,*.wiki set filetype=markdown
autocmd BufNewFile,BufReadPost *.fth,*.4th,*.meta set filetype=forth
autocmd BufNewFile,BufReadPost .vimrc,*.vim set filetype=vim
autocmd BufNewFile,BufReadPost *.asm,*.inc set filetype=asm

"autocmd BufNewFile,BufReadPost .html,*.js let delimitMate_matchPairs="{:},[:],(:),<:>"

autocmd FocusLost  * call feedkeys("\<esc>")

function! HeaderToggle() " bang for overwrite when saving vimrc
let file_path = expand("%")
let file_name = expand("%<")
let extension = split(file_path, '\.')[-1] " '\.' is how you really split on dot
let err_msg = "There is no file "

if extension == "c" || extension == "cpp"
  let next_file = join([file_name, ".h"], "")

  if filereadable(next_file)
    :e %<.h
  else
    echo join([err_msg, next_file], "")
  endif
elseif extension == "h"
  let next_file = join([file_name, ".cpp"], "")

  if filereadable(next_file)
    :e %<.cpp
    return
  endif
  let next_file = join([file_name, ".c"], "")
  if filereadable(next_file)
    :e %<.c
    return
  else
    echo join([err_msg, next_file], "")
  endif
endif
endfunction
map <leader>h :call HeaderToggle()<cr>

" for go
"autocmd BufEnter,BufNewFile,BufReadPost *.go call SetGoOptions()
"autocmd BufEnter,BufNewFile,BufReadPost *.go map <leader>r :GoRun<cr>
"function SetGoOptions() 
"  set filetype=go
"  map <leader>r :GoRun<cr>
"  map <leader>b :GoBuild<cr>
"endfunction 

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

map <leader>u <esc>guiw
map <leader>U <esc>gUiw

map <C-n> :NERDTreeToggle<CR>
map <C-_> <leader>cij
map <C-\> :Ack! 

imap jj <Esc>
imap jk <Esc>
imap kkk <Esc>
nmap <F1> :echo<CR>
vnoremap <C-c> "+y
map <C-v> "+P

"
" Plugins
" 
call plug#begin('~/.vim/plugged')
    nmap <silent> <leader>p :PlugInstall<cr>

Plug 'chaoren/vim-wordmotion'
"  let g:wordmotion_spaces = '_-.'
  let g:wordmotion_spaces = '_,'
  onoremap W :<C-U>normal! vWh<cr>
  nmap dw de
  nmap cw ce

Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
"Plug 'jgdavey/tslime.vim'

Plug 'tmux-plugins/vim-tmux-focus-events'


Plug 'tpope/vim-repeat'

Plug 'Shougo/vimproc.vim'
"Plug 'puremourning/vimspector'

Plug 'vimwiki/vimwiki'
Plug 'suan/vim-instant-markdown'

Plug 'fadein/vim-FIGlet'

Plug 'alpertuna/vim-header'
    let g:header_field_author = 'Michael Schwartz'
    let g:header_field_author_email = 'mykesx@gmail.com'
    let g:header_auto_add_header = 0
    " broken on macos
    "map <f4>:AddHeader<cr>

Plug 'mileszs/ack.vim'
      if executable('ag') 
        let g:ackprg = 'ag --vimgrep'
      endif

"Plugin 'wincent/command-t'
"    let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

Plug 'ctrlpvim/ctrlp.vim'
  map <leader>t <esc>:CtrlP<cr>

Plug 'NLKNguyen/papercolor-theme'

Plug 'jlanzarotta/bufexplorer'

Plug 'wesQ3/vim-windowswap'

"Plugin 'tpope/vim-obsession'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'xolox/vim-misc'

Plug 'mschwartz/vim-easytags'
"    let g:easytags_dynamic_files = 2
"    let g:easytags_suppress_ctags_warning=1
    let g:easytags_include_members = 1
    let g:easytags_languages = {
      \   'javascript': {
      \       'cmd': 'jsctags',
      \       'args': ['-f'],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   },
      \   'dart': {
      \     'cmd': 'ctags',
      \       'args': [],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   },
      \   'cpp': {
      \     'cmd': 'ctags',
      \       'args': [],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   },
      \   'c++': {
      \     'cmd': 'ctags',
      \       'args': [],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   },
      \   'asm': {
      \     'cmd': 'ctags',
      \       'args': [],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   }
      \}

Plug 'majutsushi/tagbar'
    nmap <C-b> :TagbarToggle<CR>

Plug 'xolox/vim-session'
    let g:session_autoload = 'prompt'
    let g:session_autosave = 'yes'
    let g:session_autosave_to = 'default'
    let g:session_verbose_messages = 0

"Plug 'rstacruz/vim-closer'
"Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
    let delimitMate_matchpairs = "{:},[:],(:)"

"Plugin 'jiangmiao/auto-pairs'

" mode line
Plug 'itchyny/lightline.vim'
  let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] 
        \   ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'fugitive#head',
        \   'filename': 'LightlineFilename'
        \ },
        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

"    let g:lightline.enable = {
"          \ 'statusline': 1,
"          \ 'tabline': 1
"          \ }

"    set showtabline=2
"    let g:lightline.component_expand = {
"    \  'linter_checking': 'lightline#ale#checking',
"    \  'linter_warnings': 'lightline#ale#warnings',
"    \  'linter_errors': 'lightline#ale#errors',
"    \  'linter_ok': 'lightline#ale#ok'
"    \ }

"    let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

Plug 'mengelbrecht/lightline-bufferline'
"  let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}

Plug 'edkolev/tmuxline.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Language Support
"Plugin 'vim-syntastic/syntastic'
Plug 'neoclide/coc.nvim', { 'tag': '*', 'branch': 'release'}
  command! -nargs=0 Format :call CocAction('format')

function! COC_configure()
  map <leader>f :Format<cr>
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  call COC_configure()
  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <leader><c-r> coc#refresh()

  " Remap keys for gotos
  nmap <silent> <C-]> <Plug>(coc-definition)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)A
  vmap <silent> gf <Plug>(coc-format-selected)
  " Remap for rename current word
  nmap gm <Plug>(coc-rename)
  " Show documentation in preview window
  nmap <silent> gh :call CocAction('doHover')<CR>
  nmap <silent> gc :CocList diagnostics<CR>
  nmap <silent> go :CocList outline<CR>
  nmap <silent> gs :CocList -I symbols<CR>

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)
endfunction

Plug 'dart-lang/dart-vim-plugin'
let dart_html_in_string = v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1


autocmd FileType cpp call CPP_config()
  function! CPP_config()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=0
    setlocal expandtab
    " use <tab> for trigger completion and navigate to the next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <slient><expr> <Tab> 
      \ pumvisible() ? "\<C-n>" : 
      \ <SID>check_back_space() ? "<Tab>" : 
      \ coc#refresh()
"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" :  <SID>check_back_space() ? "\<Tab>" : coc#refresh()
"    call COC_configure()

  endfunction

"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'vim-scripts/forth.vim'
Plug 'Shirk/vim-gas'

"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
"    let g:tern_show_argument_hints='on_hold'
"    let g:tern_map_keys=1

Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Quramy/tsuquyomi'
"Plug 'mxw/vim-jsx'
"    let g:jsx_ext_required = 0
Plug 'https://github.com/ekalinin/Dockerfile.vim'
Plug 'https://github.com/stephpy/vim-yaml'

Plug 'leshill/vim-json'
Plug 'mustache/vim-mustache-handlebars'
Plug 'digitaltoad/vim-pug'
Plug 'dNitro/vim-pug-complete'
Plug 'heavenshell/vim-jsdoc'
"nmap <leader>j :JsDoc<cr>
Plug 'othree/jsdoc-syntax.vim'
Plug 'dart-lang/dart-vim-plugin'
"Plug 'dart-lang/dart.vim'
"Plugin 'othree/xml.vim'
"Plug 'alvan/vim-closetag'
"    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.js'
"    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
"    let g:closetag_filetypes = 'html,xhtml,phtml,javascript,jsx'
"    let g:closetag_xhtml_filetypes = 'xhtml,jsx'
"    let g:closetag_emptyTags_caseSensitive = 1
"    let g:closetag_regions = {
"        \ 'typescript.tsx': 'jsxRegion,tsxRegion',
"        \ 'javascript.jsx': 'jsxRegion',
"        \ }
"Plug 'itmammoth/doorboy.vim'

" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

Plug 'Yggdroot/indentLine'

Plug 'editorconfig/editorconfig-vim'"

"Plugin 'nathanaelkane/vim-indent-guides'
    "let g:indent_guides_enable_on_vim_startup = 1
    "let g:indent_guides_guide_size = 1
    "let g:indent_guides_start_level = 2

"""""" test runner
"Plugin 'janko-m/vim-test'
    "let g:test#javascript#jest#file_pattern = '\.test\.js$'
    "nmap <silent> <leader>tt :TestSuite<cr>
    "nmap <silent> <leader>t. :TestFile<cr>

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

" NERDTree
Plug 'scrooloose/nerdtree'
"let g:NERDTreeShowHidden = 1
"let NERDTreeShowHidden=1
let g:NERDTreeIgnore=['.git', 'node_modules', '\.o$', '\.a$', '.depend']
"autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'Xuyuanp/nerdtree-git-plugin'
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

"source ~/github/mschwartz/clion-cmake.vim/plugin/clion-cmake.vim
"Plug 'mschwartz/clion-cmake.vim'
  map <leader>x  <esc>:CMakeClean<cr>
  map <leader>b  <esc>:CMakeRelease<cr>
  map <leader>d  <esc>:CMakeDebug<cr>
  map <leader>r  <esc>:CMakeRun<cr>

Plug 'posva/vim-vue'

"Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
"Plug 'dbgx/lldb.nvim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" End of Plugins
call plug#end()


filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
autocmd FileType asm set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

"autocmd FileType cpp 
"        \ setlocal tabstop=2 |
"        \ setlocal shiftwidth=2 |
"        \ setlocal softtabstop=0 |
"        \ setlocal expandtab


autocmd FileType sh setlocal formatoptions-=t

nnoremap S :%s//g<Left><Left>

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=120
" set colorcolumn=+1

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
set directory=$HOME/.vim/swapfiles//
set undodir=~/.vim/undo-dir
set undofile
set number relativenumber
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
set cmdheight=3
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
if !has('nvim')
	set viminfo='10,\"100,:20,%,n~/.viminfo
"    set viminfo+=~/.vim/viminfo
endif


"Format the statusline
function! CurDir()
    let curdir = substitute(getcwd(), '$HOME', "~/", "g")
    return curdir
endfunction

"set statusline=%#Warningmsg#
""  set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %{VCSCommandGetStatusLine()}}

set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" variable settings

let g:ackprg = 'ag --nogroup --nocolor --column'

set laststatus=2
set statusline+=%F

augroup reload_vimrc
    autocmd!
    autocmd bufwritepost ~/.vimrc nested source ~/.vimrc
augroup END

"let g:lightline = {
"    \ 'active': {
"    \   'left': [ [ 'mode', 'paste' ],
"    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
"    \ },
"    \ 'component_function': {
"    \   'fugitive': 'LightLineFugitive',
"    \   'readonly': 'LightLineReadonly',
"    \   'modified': 'LightLineModified',
"    \   'filename': 'LightLineFilename'
"    \ },
"    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
"    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
"    \ }


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
  return "FOO"
  return expand("%:p")
"  return expand("%:p")
"    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
"                \ ('' != expand('%:p') ? expand('%:p') : '[No Name]') .
"                \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

set background=dark
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

" enable true color
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
"set t_Co=256
map <Esc>[0c <C-RIGHT>
map <Esc>[0d <C-LEFT>>
    
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd FileType typescript set formatprg=prettier\ --stdin
command! -nargs=0 Prettier :CocCommand prettier.formatFile

function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

map <C-\> <Esc>:Ack 

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

Plug 'dart-lang/dart-vim-plugin'
function DART_config()
  set filetype=dart
  map <leader>f :DartFmt<cr>
endfunction

au BufRead,BufNewFile *.dart call DART_config()
autocmd FileType dart  set formatprg=dartfmt

" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

autocmd FileType asm call ASM_config()
  function! ASM_config()
"    iunmap <tab>
"    CocDisable
"    iunmap <tab>
    setlocal tabstop=20
    setlocal shiftwidth=20
    setlocal softtabstop=0
    setlocal expandtab
    silent! iunmap <leader>x
    silent! iunmap <leader>b
    silent! iunmap <leader>d
    silent! iunmap <leader>r
    silent! unmap <leader>x
    silent! unmap <leader>b
    silent! unmap <leader>d
    silent! unmap <leader>r
"    iunmap <tab>
  endfunction

" key bindings
nmap <F1> :echo<cr>
imap <F1> :echo<cr>
imap <F1> <C-o>:echo<cr>
nmap <C-h> :TmuxNavigateLeft<cr>
nmap <C-j> :TmuxNavigateDown<cr>
nmap <C-k> :TmuxNavigateUp<cr>
nmap <C-l> :TmuxNavigateRight<cr>
imap <C-h> :TmuxNavigateLeft<cr>
imap <C-j> :TmuxNavigateDown<cr>
imap <C-k> :TmuxNavigateUp<cr>
imap <C-l> :TmuxNavigateRight<cr>

map <C-h> :TmuxNavigateLeft<cr>
map <C-j> :TmuxNavigateDown<cr>
map <C-k> :TmuxNavigateUp<cr>
map <C-l> :TmuxNavigateRight<cr>

set rtp+=/opt/homebrew/opt/fzf
