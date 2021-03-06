"  VimRC used by pctao@pcsh.org s8912@cs.nccu.edu.tw

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
call pathogen#runtime_append_all_bundles() 

" http://vim.wikia.com/wiki/VimTip1576
if &term =~ "xterm"
  set title
  set t_ts=k
  set t_fs=\
  "256 color --
  let &t_Co=256
  " restore screen after quitting
  set t_ti="\<Esc>7\<Esc>[r\<Esc>[?47h" t_te="\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf="\<Esc>[3%p1%dm"
    let &t_Sb="\<Esc>[4%p1%dm"
  else
    let &t_Sf="\<Esc>[3%dm"
    let &t_Sb="\<Esc>[4%dm"
  endif
endif


map ,e :e <C-R>=expand("%:p:h") . "/" <CR> 
map j jzz
map k kzz
"set t_Co=256
"set t_Sf=[1;3%p1%dm
"set t_Sb=[1;4%p1%dm
set bs=2
set ruler          " show the cursor position all the time
set nu
set showcmd        " display incomplete commands
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" set dictionary=/usr/share/dict/words

" Key
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
nnoremap <silent> <Leader>k mk:exe 'match Search /<Bslash>%'.line(".").'l/'<CR>


" Search
set incsearch      " do incremental searching
set hlsearch       " Also switch on highlighting the last used search pattern.

" Formatting
set nocindent
set smartindent
set smarttab
set noexpandtab
autocmd FileType make     set noexpandtab

" Visual
set nolist
set listchars=tab:>-,trail:-,eol:$,extends:>,precedes:<
set showmatch
set mat=5
set wildmenu       " command-line completion operates in an enhanced mode
set cursorline
set cursorcolumn
if $DISPLAY != ''
colorscheme wombat256
"colorscheme calmar256-light
"colorscheme 256-jungle
else
	colorscheme default
endif
colorscheme wombat256
"set background=dark
"highlight Comment ctermfg=DarkCyan
"highlight SpecialKey ctermfg=Yellow
"highlight Normal guifg=#ffffff guibg=#000000
"highlight Search ctermfg=Black

" StatusLine
set laststatus=2
" http://vim.wikia.com/wiki/VimTip1573
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction
if has('statusline')
  set statusline=%#Question#                   " set highlighting
  set statusline+=%-2.2n\                      " buffer number
  set statusline+=%#WarningMsg#                " set highlighting
  set statusline+=%f\                          " file name
  set statusline+=%#Question#                  " set highlighting
  set statusline+=%h%m%r%w\                    " flags
  set statusline+=%{(exists('g:loaded_fugitive')?fugitive#statusline():'')}  " fugitive git status
  set statusline+=%{(exists('g:loaded_rvm')?rvm#statusline():'')}  " rvm
  set statusline+=%{strlen(&ft)?&ft:'none'},   " file type
  set statusline+=%{(&fenc==\"\"?&enc:&fenc)}, " encoding
  set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
  set statusline+=%{&fileformat},              " file format
  set statusline+=%{&spelllang},               " language of spelling checker
  set statusline+=%{SyntaxItem()}              " syntax highlight group under cursor
  set statusline+=%=                           " ident to the right
  set statusline+=0x%-8B\                      " character code under cursor
  set statusline+=%-7.(%l,%c%V%)\ %<%P         " cursor position/offset
endif
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white

let mapleader = "," 
" NERDTree
nnoremap <leader>d :NERDTree<CR>
" Tlist
let Tlist_Ctags_Cmd='~/bin/ctags'
nnoremap <silent> <F3> :TlistToggle<CR>
" Fuzzy Finder
nnoremap <leader>t :FufFile<CR>
nnoremap <leader>b :FufBuffer<CR>
let g:fuzzy_ignore = "*.log"
let g:fuzzy_matching_limit = 70
" snipMate
let g:snips_author = 'TaopaiC'
let g:SuperTabMappingForward="<C-n>"
" matchit
filetype plugin on
" rails
command! Rroutes  :Redit  config/routes.rb
command! RTroutes :RTedit config/routes.rb

syntax on
au FileType javascript so ~/.vim/syntax/javascript.vim
au FileType javascript so ~/.vim/indent/javascript.vim

"setl omnifunc=nullcomplete#Complete
"autocmd FileType *          setl omnifunc=nullcomplete#Complete
"autocmd FileType python     setl omnifunc=pythoncomplete#Complete
"autocmd FileType javascript setl omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html       setl omnifunc=htmlcomplete#CompleteTags noci
"autocmd FileType css        setl omnifunc=csscomplete#CompleteCSS noci
"autocmd FileType xml        setl omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php        setl omnifunc=phpcomplete#CompletePHP
"autocmd FileType c          setl omnifunc=ccomplete#Complete

if has("autocmd")
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType c,cpp  call FT_C()
  autocmd FileType java   call FT_JAVA()
  autocmd FileType php    call FT_PHP()
  autocmd FileType ruby   call FT_RUBY()
  autocmd FileType eruby  call FT_RUBY()
  autocmd FileType html   call FT_RUBY()

  function FT_COMMON()
"    set foldmethod=indent
"    set foldlevelstart=99
    set softtabstop=4
    set shiftwidth=4
    set tags=./tags,tags,../tags,~/workspace/tags
    set formatoptions=tcqr
  endfunction "FT_COMMON

  function FT_RUBY()
    call FT_COMMON()
    set softtabstop=2
    set shiftwidth=2
    set expandtab
  endfunction "FT_RUBY

  function FT_PHP()
    call FT_COMMON()
    au FileType php so ~/.vim/indent/php.vim
    inoremap <C-H> <ESC>:call PhpDocSingle()<CR>i
    nnoremap <C-H> :call PhpDocSingle()<CR>
    vnoremap <C-H> :call PhpDocRange()<CR> 
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType php set dictionary=~/tmp/a.txt
  endfunction "FT_PHP

  function FT_C()
    call FT_COMMON()
    abbr #b ************************************************************
    "加大型註解用, /#b 以及 #b/
  endfunction "FT_C

  function FT_JAVA()
    call FT_COMMON()
    compiler jikes
  endfunction "FT_JAVA

endif "has("autocmd")
autocmd FileType eruby      set ft=eruby.html

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,big5,latin1,enc-cn,gb2312
set termencoding=utf-8
set ffs=unix,dos
set ff=unix

" let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
" if &term == "screen"
" 	set t_ts=^[k
" 	set t_fs=^[\
" endif
" if &term == "screen" || &term == "xterm" || &term == "xterm-256color"
" 	set t_ts=^[k
" 	set t_fs=^[\
" 	set title
" endif

"if $TERM == "screen"
"set title
"set t_ts=k
"set t_fs=\
"auto BufEnter * :set title | let &titlestring = 'v:' . expand('%')
"auto VimLeave * :set notitle
"endif

set secure
