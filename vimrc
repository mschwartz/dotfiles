call pathogen#infect()
set tabstop=4
set shiftwidth=4
set ls=2
set showcmd
set hlsearch
set incsearch
set ruler
set nobackup
set number
set ignorecase
set smartcase
set title
set ttyfast
set modeline
set modelines=3
set mouse=a
syntax on
syntax enable
set background=light
"colorscheme solarized
" solarized options 
let g:solarized_termcolors = 16 
"let g:solarized_visibility = "high" 
"let g:solarized_contrast = "high" 
colorscheme solarized 
"Show menu with possible tab completions
set wildmenu
"Ignore these files when completing names and in Explorer
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

"colorscheme blue
"colorscheme darkslategray
set autoindent
set smartindent
filetype on
au BufRead,BufNewFile *.sjs		setfiletype javascript

"cd ~/pwp2
let Tlist_Use_Right_Window = 1
map <F8> <ESC>:NERDTreeToggle<CR>
map <F5> <ESC>:NERDTree<CR>B
map <F11> <ESC>:TlistToggle<CR>
map <F12> <ESC>:Ex<CR>
set cursorline
"set guioptions=acg
map <C-DOWN> <C-W><Down>
map <C-UP> <C-W><Up>
map <C-LEFT> <C-W><Left>
map <C-RIGHT> <C-W><Right>
map <C-X> "+x
map <C-C> "+y
map <C-V> "+gP
map <A-2> <C-W>s
map <A-1> <C-W>c<F5><C-W><Right>
map <A-0> <C-W>o<F5><C-W><Right>
map <C-s> <ESC>:w<CR>
map <C-F> <ESC>:1,$!jsbeautifier.js<CR>
"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-P>:call PhpDocSingle()<CR>
"vnoremap <C-P>:call PhpDocRange()<CR>
"set nowrap
if has("gui_running")
	set lines=75
	set columns=160
"	set guifont=DejaVu\ Sans\ Mono\ 8
"	colorscheme ChocolateLiquor
	set guioptions-=T
else
	set t_Co=256
"	set wrap!
"	colorscheme tabula
	map <Esc>[0c <C-RIGHT>
	map <Esc>[0d <C-LEFT>>
endif
"set statusline=%<%f\ %{VCSCommandGetStatusLine()}\ %h%m%r%=%l,%c%V\ %P

"map <MouseDown> <C-Y>
"map <S-MouseDown> <C-U>
"map <MouseUp> <C-E>
"map <S-MouseUp> <C-D>
"map <M-Esc>[62~ <MouseDown>
"map! <M-Esc>[62~ <MouseDown>
"map <M-Esc>[63~ <MouseUp>
"map! <M-Esc>[63~ <MouseUp>
"map <M-Esc>[64~ <S-Mousemow>
"map! <M-Esc>[64~ <S-MouseDown>
"map <M-Esc>[65~ <S-MouseUp>
"map! <M-Esc>[65~ <S-MouseUp>
"map! <Esc>[A <C-E>
"map! <Esc>[B <C-Y>
"map! <M-Esc>[A <C-E>
"map! <M-Esc>[B <C-Y>

" ---------------------------------------------------------------------

"Enable filetype plugin
filetype plugin on
"filetype indent on

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

map <leader>t :helptags ~/.vim/doc<cr>
"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
"set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
"set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch


  """"""""""""""""""""""""""""""
  " Statusline
  """"""""""""""""""""""""""""""
  "Always hide the statusline
  set laststatus=2

  function! CurDir()
     let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
     return curdir
  endfunction

  "Format the statusline
  set statusline=%#Warningmsg#
"  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c\ %{VCSCommandGetStatusLine()}


"Switch to current dir
map <leader>cd :cd %:p:h<cr>

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Command-/ to toggle comments
map <D-/> <plug>NERDCommenterToggle<CR>
imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

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
