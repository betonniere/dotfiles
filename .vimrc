":set guifont=Courier\ 10\ Pitch
":set guifont=Monospace\ 10
:set encoding=utf-8
:set fileencoding=utf-8

:let g:netrw_browsex_viewer= "gnome-open"

"------------------------------------------------------------------------------------------
set nobackup
set modeline
set nocompatible

"------------------------------------------------------------------------------------------
set guitablabel=%m\ %t

"------------------------------------------------------------------------------------------
"man pages
"runtime ftplugin/man.vim

"------------------------------------------------------------------------------------------
let mapleader = ","

"------------------------------------------------------------------------------------------
"Network utilities
:let loaded_netrw = 1

"------------------------------------------------------------------------------------------
"Allow mouse on xterm
set mouse=a

"------------------------------------------------------------------------------------------
"Display as much as possible the last line and hex code of unprintable char
set display=lastline,uhex

"------------------------------------------------------------------------------------------
" wrap
set sidescroll=5
set listchars=precedes:<,extends:>
set nowrap

"------------------------------------------------------------------------------------------
"Open .cpp's .hpp in a left pane
map <F7> :vs %:p:s,.h$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

"------------------------------------------------------------------------------------------
"open new file from the same directory
if has("unix")
    map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map <Leader>e :e <C-R>=expand("%:p:h") . "\" <CR>
endif
map <Leader>cd :cd <C-R>=expand("%:p:h") <CR>

"------------------------------------------------------------------------------------------
"grep
function! Grep(target, exp)
  let l:cmd = "cd " . expand("%:p:h")
  exe l:cmd

  copen

  if a:target == "fgc"
    let l:cmd = "vimgrep " . a:exp . " *.cpp *.c"
  elseif a:target == "fgh"
    let l:cmd = "vimgrep " . a:exp . " *.hpp *.h"
  elseif a:target == "fgall"
    let l:cmd = "vimgrep " . a:exp . " *"
  endif

  exe l:cmd
endfunction

cab fgc   Fgc
cab fgh   Fgh
cab fgall Fgall
command -nargs=1 Fgc   call Grep("fgc", "/" . <f-args> . "/")
command -nargs=1 Fgh   call Grep("fgh", <f-args>)
command -nargs=1 Fgall call Grep("fgall", <f-args>)

"------------------------------------------------------------------------------------------
" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre   *.bin,*ttf,*TTF let &bin=1
  au BufReadPost  *.bin,*ttf,*TTF if &bin | %!/home/lerouxy/local/bin/xxd
  au BufReadPost  *.bin,*ttf,*TTF set ft=xxd | endif
  au BufWritePre  *.bin,*ttf,*TTF if &bin | %!/home/lerouxy/local/bin/xxd -r
  au BufWritePre  *.bin,*ttf,*TTF endif
  au BufWritePost *.bin,*ttf,*TTF if &bin | %!/home/lerouxy/local/bin/xxd
  au BufWritePost *.bin,*ttf,*TTF set nomod | endif
augroup END

"------------------------------------------------------------------------------------------
filetype plugin indent on
filetype plugin on

"------------------------------------------------------------------------------------------
"function parameters alignment
set cinoptions=(0,w1=0

"------------------------------------------------------------------------------------------
if $TERM=="xterm"
"  set guioptions-=T
endif
set guioptions+=b

"------------------------------------------------------------------------------------------
"No XIM
set imdisable

"------------------------------------------------------------------------------------------
set virtualedit=all

"------------------------------------------------------------------------------------------
map <Leader>g [I

"------------------------------------------------------------------------------------------
"Case matching
set ignorecase smartcase

"------------------------------------------------------------------------------------------
"delete line
nmap <Del> dd

"------------------------------------------------------------------------------------------
"Tab and trailing spaces
set list
set listchars+=tab:>.,trail:.

"------------------------------------------------------------------------------------------
"mark
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"------------------------------------------------------------------------------------------
"gdb
if v:version >= 800
  :packadd termdebug
endif

"------------------------------------------------------------------------------------------
" redraw current at window top    ==> F1
" redraw current at window center ==> F2
" redraw current at window bottom ==> F3
nmap <F1> z<CR>
nmap <F2> z.
nmap <F3> z-

"------------------------------------------------------------------------------------------
" Runtime Macro
nmap <F4>  @a
nmap <F9>  @b
nmap <F10> @c
nmap <F11> @d
nmap <F12> @e

"------------------------------------------------------------------------------------------
" Toggle line numbering ==> F5
function! ToggleLineNumbering ()
  if &nu
    set nonu
  else
    set nu
  endif
endfun

nmap <F5> :call ToggleLineNumbering ()<CR>

"------------------------------------------------------------------------------------------
" comment ==> F6
function! ToggleComment ()
  let line_number  = line(".")
  let current_line = getline (".")

  let start_comment = matchend (current_line, '/\* ')
  let end_comment   = match (current_line, ' \*\/$')
  if ((start_comment == -1) || (end_comment == -1))
    let new_line = "/\* " . current_line . " \*\/"
    call setline (line_number, new_line)
  else
    let new_line = strpart (current_line, start_comment, end_comment - start_comment)
    call setline (line_number, new_line)
  endif
endfun

nmap <F6> :call ToggleComment ()<CR>
j

"------------------------------------------------------------------------------------------
" .
nmap ; .
vnoremap ; :normal .<CR> 

"------------------------------------------------------------------------------------------
" Search
highlight IncSearch ctermfg=green ctermbg=blue guifg=green guibg=blue
set hlsearch
set incsearch

"------------------------------------------------------------------------------------------
" CTRL T
"set highlight=8r,db,es,hs,mb,Mr,nb,rs,sr,tb,vr,wi
set expandtab     "Tab == space
set tabstop=2
set shiftwidth=3  "Number of spaces to use for each step of (auto)indent"

"------------------------------------------------------------------------------------------
"jumps to the last known position in a file
autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

colorscheme morning

"- Airline --------------------------------------------------------------------------------
let g:airline#extensions#ale#enabled    = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_theme           = 'wombat'
let g:airline_powerline_fonts = 1

"- Ale ------------------------------------------------------------------------------------
let g:ale_enabled            = 1
let g:ale_lint_on_enter      = 1
let g:ale_completion_enabled = 1
let g:ale_open_list          = 1
let g:ale_list_window_size   = 1
let g:ale_sign_error         = '💣 '
let g:ale_sign_warning       = '🚧 '
nnoremap <C-RightMouse> :ALEGoToDefinition -tab<CR>
nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>
nmap gd :ALEGoToDefinition<CR>
nmap gt :ALEGoToDefinition -tab<CR>
nmap gr :ALEFindReferences<CR>

"
set noendofline
set nofixendofline
