:set guifont=Monospace\ 10
:set guifont=Courier\ 10\ Pitch
:set encoding=utf-8
:set fileencoding=utf-8

:let g:netrw_browsex_viewer= "gnome-open"

"------------------------------------------------------------------------------------------
set nobackup
set modeline

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
"VimBudy
if $USER=="lerouxy"
  set statusline=%f%h%m%r\ \ \ \ <<<%{$ENV_CC_NAME}>>>%=0x%B-%b\ (%l,%c%V\ %P)
  set tabline=%t
  set laststatus=2
  set ruler
endif

"------------------------------------------------------------------------------------------
"Tag
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"amenu <silent> Misc.&ASCII <Plug>CT_CharTable
set tags=/home/lerouxy/ccviews/blue/AwoxSoftware\ ./tags\ $HOME/tags
set showfulltag

"------------------------------------------------------------------------------------------
"Tag
set path+=$MA_COMMON_HOME/*/*/src,../obj,../obj.dxx

"------------------------------------------------------------------------------------------
"mark
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"------------------------------------------------------------------------------------------
"Syntax
syntax on
if has ("gui_running")
else
  "set t_Co=8
  "set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
  "set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
  "colorscheme evening
endif

"------------------------------------------------------------------------------------------
"gdb
":syntax enable          " enable syntax highlighting
":set previewheight=12   " set gdb console initial height
":run macros/gdb_mappings.vim  " source key mappings listed in this
"" document
":set asm=0              " don't show any assembly stuff
":set gdbprg=/local/work/lerouxy/host/usr/bin/gdb

"------------------------------------------------------------------------------------------
" redraw current at window top    ==> F1
" redraw current at window center ==> F2
" redraw current at window bottom ==> F3
nmap <F1> z
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

nmap <F5> :call ToggleLineNumbering ()

"------------------------------------------------------------------------------------------
" Folder ==> F6
function! ToggleFoldEnable ()
  if &foldenable
    set nofoldenable
  else
    set foldenable
  endif
endfun

set foldmethod=indent
set nofoldenable
nmap <F6> :call ToggleFoldEnable ()

"------------------------------------------------------------------------------------------
" comment ==> F7
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

nmap <F7> :call ToggleComment ()j

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
set shiftwidth=2  "Number of spaces to use for each step of (auto)indent"

"------------------------------------------------------------------------------------------
"jumps to the last known position in a file
autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

"------------------------------------------------------------------------------------------
abbreviate mNoir   \e[1;30m
abbreviate mRouge  \e[1;31m
abbreviate mVert   \e[1;32m
abbreviate mJaune  \e[1;33m
abbreviate mBleu   \e[1;34m
abbreviate mViolet \e[1;35m
abbreviate mBleu   \e[1;36m
abbreviate mBlanc  \e[1;37m
abbreviate mNorm   \e[0m

"------------------------------------------------------------------------------------------
execute pathogen#infect()
execute pathogen#helptags()

"- Syntastic ------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_cpp_config_file = ".syntastic.config"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ["cpp", "hpp"],
    \ "passive_filetypes": [] }

colorscheme morning
