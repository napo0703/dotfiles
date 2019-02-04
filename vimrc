" Orginal by @geta6

" Default setting
if filereadable("/etc/vim/vimrc")
  source /etc/vim/vimrc
endif

" NeoBundle
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'thinca/vim-quickrun'
  " Shell
  NeoBundle 'Shougo/vimproc', {'build':{
        \ 'mac': 'make -f make_mac.mak',
        \ 'unix': 'make -f make_unix.mak'
        \ }}
  NeoBundle 'Shougo/vimshell'
  " Utility
  NeoBundle 'AnsiEsc.vim'
  NeoBundle 'banyan/recognize_charcode.vim'
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'Shougo/unite.vim'
  " Syntax
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'sheerun/vim-polyglot'
  NeoBundle 'GutenYe/json5.vim'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'digitaltoad/vim-jade'
  NeoBundle "sudar/vim-arduino-syntax"
  NeoBundle 'udalov/kotlin-vim'
  " Extend
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'slindberg/vim-colors-smyck'
  NeoBundle 'w0ng/vim-hybrid'
  NeoBundle 'jonathanfilip/vim-lucius'
  call neobundle#end()
endif
" Program

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
endif


"
" Global configuration
"
set ambiwidth=double
set laststatus=2
set showcmd
set showmatch
set matchtime=1
set ignorecase
set smartcase
set ruler
set number
set notitle
set autowrite
set hidden
set scrolloff=5
set history=1000
set autoread
set incsearch
set hlsearch
set nowrap
set t_ut=y
set t_Co=256
set wildmenu
set wildchar=<tab>
set wildmode=list:full
"set wildignorecase
set complete+=k
set guifont=Ricty\ 15
set clipboard+=unnamed
set lazyredraw
set ttyfast
set ttyscroll=3
set undodir=~/.vim/undo
set undofile
set colorcolumn=100
set virtualedit=all

nmap <ESC><ESC> ;nohlsearch<CR><ESC>
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

if has('virtualedit') && &virtualedit =~# '\<all\>'
  nnoremap <expr> <SID>($-if-right-of-$)  (col('.') >= col('$') ? '$' : '')
  nnoremap        <SID>(noremap-p)        p
  nmap p <SID>($-if-right-of-$)<SID>(noremap-p)
endif

"
" Indentation
"
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent


"
" Key remap
"
nnoremap ; :
"set virtualedit=block
set backspace=indent,eol,start
set t_kD=[3~
set list
set listchars=tab:›\ ,eol:\ ,trail:~


"
" Move to last edited line
"
au BufWritePost * mkview
autocmd BufReadPost * loadview


"
" File handling
"
set fileencodings=utf-8
set fileformats=unix,dos
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformat=unix
filetype plugin on
au BufRead,BufNewFile *.ru      set ft=ruby
au BufRead,BufNewFile *.twig    set ft=jinja.html
au BufRead,BufNewFile *.less    set ft=less
au BufRead,BufNewFile *.slim    set ft=slim
au BufRead,BufNewFile *.json    set ft=json
au BufRead,BufNewFile *.bowerrc set ft=json
au BufRead,BufNewFile *.txt     set ft=markdown
au BufRead,BufNewFile *.txt     set foldmethod=marker
au BufRead,BufNewFile *.scala   set ft=java.scala
au BufRead,BufNewFile *.yml     set foldmethod=syntax
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/configs/* set ft=nginx
au BufRead,BufNewFile Procfile set ft=ruby
autocmd BufWritePre * :%s/\s\+$//ge


"
" Module configuration
"
cnoremap <C-p> <Up>
cnoremap <Up>  <C-p>
cnoremap <C-n> <Down>
cnoremap <Down>  <C-n>

nnoremap <silent> ,is :VimShell<CR>

let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
noremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

inoremap <expr><Up> neocomplcache#close_popup()."\<Up>"
inoremap <expr><Down> neocomplcache#close_popup()."\<Down>"
inoremap <expr><Left> neocomplcache#close_popup()."\<Left>"
inoremap <expr><Right> neocomplcache#close_popup()."\<Right>"

"
" Lightline
"
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'u' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

autocmd FileType quickrun AnsiEsc

"
" Coloring
"
syntax enable
set background=dark
colorscheme lucius
function! ActivateInvisibleIndicator()
  hi SpecialKey cterm=NONE ctermfg=darkgray guifg=darkgray
  hi ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=#FF0000
  match ZenkakuSpace /　/
endfunction
augroup InvisibleIndicator
  autocmd!
  autocmd BufEnter * call ActivateInvisibleIndicator()
augroup END

filetype plugin indent on
NeoBundleCheck
