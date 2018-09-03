" File              : /home/mschwartz/.vimrc
" Author            : Michael Schwartz <mykesx@gmail.com>
" Date              : 21.06.2018
" Last Modified Date: 21.06.2018
" Last Modified By  : Michael Schwartz <mykesx@gmail.com>
set nocompatible 
"set fileformat=unix
"set ma
filetype off

" for arduino
autocmd BufNewFile,BufReadPost *.cpp,*.h,*.ino,*.pde set filetype=cpp
autocmd BufNewFile,BufReadPost *.md,*.wiki set filetype=markdown
autocmd BufNewFile,BufReadPost *.fth,*.4th set filetype=forth

" set leader
let mapleader=","
let g:mapleader=","

" key bindings
nmap <F1> <nop>
imap <F1> <nop>
nmap <leader>s :w!<cr>
map <leader>j :j<cr>
map <leader>ai :ALEInfo<cr>
map <leader>ad :ALEDetail<cr>
map <leader>f :ALEFix<cr>
"  map <leader>s :source ~/.vimrc<cr>
map <leader>e3 :e! ~/.config/i3/config<cr>
map <leader>ea :e! ~/dotfiles/zsh/aliases.zsh<cr>
map <leader>eb :e! ~/dotfiles/config/i3/i3blocks.conf<cr>
map <leader>ee :e! ~/dotfiles/zsh/env.zsh<cr>
map <leader>ef :e! ~/dotfiles/zsh/functions.zsh<cr>
map <leader>ev :e! ~/.vimrc<cr>
map <leader>et :e! ~/dotfiles/tmux.conf<cr>
map <leader>ez :e! ~/.zshrc<cr>
map <leader>l :nohlsearch<cr>
map <leader>pi :PluginInstall<cr>
map <leader>ip <esc>iimport PropTypes from 'prop-types'<cr><esc>
map <leader>ir <esc>iimport React, {Component} from 'react'<cr><esc>
map <leader>itc <esc>otry {<cr>}<cr>catch(e) {<cr>console.log('exception', e)<cr><esc>ddjddkkkk==ko
map <leader>v <esc>:read !xsel<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-_> <leader>cij
map <C-\> :Ack! 
imap jj <Esc>
imap jk <Esc>
imap kkk <Esc>
nmap <F1> :echo<CR>


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"
" Plugins
" 
Plugin 'vundleVim/Vundle.vim'
    nmap <silent> <leader>p :PluginInstall<cr>

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'vimwiki/vimwiki'
Plugin 'suan/vim-instant-markdown'

Plugin 'fadein/vim-FIGlet'
Plugin 'alpertuna/vim-header'
    let g:header_field_author = 'Michael Schwartz'
    let g:header_field_author_email = 'mykesx@gmail.com'
    let g:header_auto_add_header = 0
    " broken on macos
    "map <f4>:AddHeader<cr>

Plugin 'mileszs/ack.vim'
      if executable('ag') 
        let g:ackprg = 'ag --vimgrep'
      endif

Plugin 'wincent/command-t'
    let g:CommandTWildIgnore=&wildignore . ",*/node_modules"
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'wesQ3/vim-windowswap'
"Plugin 'tpope/vim-obsession'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
    let g:easytags_languages = {
      \   'javascript': {
      \       'cmd': 'jsctags',
      \       'args': ['-f'],
      \       'fileoutput_opt': '-f',
      \       'stdout_opt': '-f-',
      \       'recurse_flag': '-R'
      \   }
      \}

Plugin 'majutsushi/tagbar'
    nmap <C-b> :TagbarToggle<CR>

Plugin 'xolox/vim-session'
    let g:session_autoload = 'prompt'
    let g:session_autosave = 'yes'
    let g:session_autosave_to = 'default'
    let g:session_verbose_messages = 0

Plugin 'Raimondi/delimitMate'
"Plugin 'jiangmiao/auto-pairs'

" mode line
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/tmuxline.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Language Support
"Plugin 'vim-syntastic/syntastic'
"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_auto_trigger = 0
Plugin 'vim-scripts/forth.vim'
Plugin 'ternjs/tern_for_vim'
    let g:tern_show_argument_hints='on_hold'
    let g:tern_map_keys=1

Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'mxw/vim-jsx'
    let g:jsx_ext_required = 0
Plugin 'leshill/vim-json'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'digitaltoad/vim-pug'
Plugin 'dNitro/vim-pug-complete'
Plugin 'heavenshell/vim-jsdoc'
"nmap <leader>j :JsDoc<cr>
Plugin 'othree/jsdoc-syntax.vim'
Plugin 'itmammoth/doorboy.vim'

" Highlight ES6 template strings
hi link javaScriptTemplateDelim String
hi link javaScriptTemplateVar Text
hi link javaScriptTemplateString String

Plugin 'Yggdroot/indentLine'

Plugin 'editorconfig/editorconfig-vim'"

"Plugin 'nathanaelkane/vim-indent-guides'
    "let g:indent_guides_enable_on_vim_startup = 1
    "let g:indent_guides_guide_size = 1
    "let g:indent_guides_start_level = 2

"""""" ale
Plugin 'w0rp/ale'
if expand("$ARDUBOY_TOOLCHAIN") != ""
    let g:ale_cpp_gcc_executable='$HOME/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/bin/avr-g++'
    let g:ale_cpp_gcc_options='-c -std=gnu++11 -O6
      \ -mmcu=atmega32u4 
      \ -DF_CPU=16000000L 
      \ -DARDUINO=10612 
      \ -DARDUINO_AVR_ARDUBOY 
      \ -DARDUINO_ARCH_AVR  
      \ -DARDUBOY_10 -DUSB_VID=0x2341 
      \ -DUSB_PID=0x8036 
      \ -DUSB_MANUFACTURER="Unknown"
      \ -DUSB_PRODUCT="Arduboy"
      \ -I$HOME/gArduino/libraries/Arduboy2/src 
      \ -I$HOME/.arduino15/packages/arduino/hardware/avr/1.6.20/cores/arduino 
      \ -I$HOME/.arduino15/packages/arduino/hardware/avr/1.6.20/variants/leonardo
      \ -I$HOME/.arduino15/packages/arduino/hardware/avr/1.6.20/libraries/EEPROM/src
      \ -I$HOME/.arduino15/packages/arduino/tools/avr-gcc/4.9.2-atmel3.5.4-arduino2/avr/include
      \'
    set path+=~/.arduino15/packages/arduino/hardware/avr/1.6.20/cores/arduino
endif

if expand("$ORDOIDGO_TOOLCHAIN") != ""
    let g:ale_cpp_gcc_executable='$ODROIDGO_TOOLCHAIN/xtensa-esp32-elf-g++'
    let g:ale_cpp_gcc_options='-c -std=gnu++11 -O6
      \ $ARDUINO_ROOT/hardware/espressif/esp32/tools/xtensa-esp32-elf/bin/xtensa-esp32-elf-g++
      \ -DESP_PLATFORM 
      \ -DMBEDTLS_CONFIG_FILE="mbedtls/esp_config.h" 
      \ -DHAVE_CONFIG_H -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/config 
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/bluedroid
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/app_trace
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/app_update
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/bootloader_support
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/bt
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/driver
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/esp32
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/esp_adc_cal
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/ethernet
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/fatfs
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/freertos
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/heap
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/jsmn
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/log
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/mdns
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/mbedtls
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/mbedtls_port
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/newlib
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/nvs_flash
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/openssl
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/spi_flash
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/sdmmc
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/spiffs
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/tcpip_adapter
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/ulp
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/vfs
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/wear_levelling
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/xtensa-debug-module
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/coap
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/console
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/expat
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/json
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/lwip
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/newlib
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/nghttp
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/soc
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/tools/sdk/include/wpa_supplicant 
      \ -std=gnu++11 
      \ -fno-exceptions 
      \ -Os 
      \ -g3 
      \ -Wpointer-arith 
      \ -fexceptions 
      \ -fstack-protector 
      \ -ffunction-sections 
      \ -fdata-sections
      \ -fstrict-volatile-bitfields
      \ -mlongcalls 
      \ -nostdlib 
      \ -w 
      \ -Wno-error=unused-function 
      \ -Wno-error=unused-but-set-variable 
      \ -Wno-error=unused-variable 
      \ -Wno-error=deprecated-declarations 
      \ -Wno-unused-parameter 
      \ -Wno-sign-compare 
      \ -fno-rtti 
      \ -MMD 
      \ -c 
      \ -DF_CPU=240000000L 
      \ -DARDUINO=10805 
      \ -DARDUINO_ODROID_ESP32 
      \ -DARDUINO_ARCH_ESP32 
      \ -DARDUINO_BOARD="ODROID_ESP32" 
      \ -DARDUINO_VARIANT="odroid_esp32"  
      \ -DESP32 
      \ -DCORE_DEBUG_LEVEL=0 
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/cores/esp32
      \ -I$ARDUINO_ROOT/hardware/espressif/esp32/variants/odroid_esp32
      \'
    " set path to all ESP-IDF includes here!
    set path+=$ODROID_TOOLCHAIN
endif
    " Put this in vimrc or a plugin file of your own.
    " After this is configured, :ALEFix will try and fix your JS code with ESLint.
    let g:ale_linters = {
                \   'javascript': ['eslint'],
                \   'json': ['eslint'],
                \   'typescript': ['tslint'],
                \   'objc': ['clang'],
                \   'cpp': ['clang-format'],
                \   'h': ['clang-format'],
                \}
    let g:ale_fixers = {
                \   'javascript': ['eslint', 'prettier'],
                \   'json': ['eslint', 'prettier'],
                \   'typescript': ['tslint', 'prettier'],
                \   'objc': ['clang'],
                \   'cpp': ['clang-format'],
                \   'h': ['clang-format'],
                \}

"                \   'cpp': [ 'g++' ],
    " Set this setting in vimrc if you want to fix files automatically on save.
    " This is off by default.
    let g:ale_fix_on_save = 1

    " Enable completion where available.
    let g:ale_completion_enabled = 1

    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1

"""""" test runner
"Plugin 'janko-m/vim-test'
    "let g:test#javascript#jest#file_pattern = '\.test\.js$'
    "nmap <silent> <leader>tt :TestSuite<cr>
    "nmap <silent> <leader>t. :TestFile<cr>

Plugin 'scrooloose/nerdcommenter'
    " Use compact syntax for prettified multi-line comments
    "let g:NERDCompactSexyComs = 1

    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'start'

    " Allow commenting and inverting empty lines (useful when commenting a region)
    "let g:NERDCommentEmptyLines = 1

    " Enable trimming of trailing whitespace when uncommenting
    "let g:NERDTrimTrailingWhitespace = 1

" NERDTree
Plugin 'scrooloose/nerdtree'
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore=['.git', 'node_modules', '.o$', '.a$', '.depend']
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
autocmd FileType cpp set tabstop=2 shiftwidth=2 softtabstop=0 expandtab

"
" VIM options
"
set ttyfast
set nowrap
set autoread
set nolazyredraw
set backspace=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


map <C-\> <Esc>:Ack 
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

