":set guifont=Courier\ 10\ Pitch
":set guifont=Monospace\ 10
:set encoding=utf-8
:set fileencoding=utf-8

"------------------------------------------------------------------------------------------
set nobackup
set modeline
set nocompatible

"------------------------------------------------------------------------------------------
set guitablabel=%m\ %t

"------------------------------------------------------------------------------------------
" netrw
let g:netrw_browsex_viewer= "xdg-open"

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_preview = 1

"------------------------------------------------------------------------------------------
"man pages
"runtime ftplugin/man.vim

"------------------------------------------------------------------------------------------
let mapleader = ","

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
function! OpenHeaderFile()
    let l:current_file = expand('%:p:r')

    if filereadable(l:current_file . '.hpp')
        execute 'vs ' . l:current_file . '.hpp'
    elseif filereadable(l:current_file . '.h')
        execute 'vs ' . l:current_file . '.h'
    else
        echo "Aucun fichier .hpp ou .h trouvé."
    endif
endfunction

nnoremap <F7> :call OpenHeaderFile()<CR>

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
  au BufReadPost  *.bin,*ttf,*TTF if &bin | %!xxd
  au BufReadPost  *.bin,*ttf,*TTF set ft=xxd | endif
  au BufWritePre  *.bin,*ttf,*TTF if &bin | %!xxd -r
  au BufWritePre  *.bin,*ttf,*TTF endif
  au BufWritePost *.bin,*ttf,*TTF if &bin | %!xxd
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
nnoremap <Leader>g [I

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
" hexadecimal 2 decimal ==> F6
command! -nargs=? -range H2D call s:H2D(<line1>, <line2>, '<args>')
function! s:H2D(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

"------------------------------------------------------------------------------------------
" decimal 2 hexadecimal ==> F6
command! -nargs=? -range D2H call s:D2H(<line1>, <line2>, '<args>')
function! s:D2H(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

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
let g:ale_cpp_clangtidy_extra_options = '--config-file=/home/yannick/.clangtidy'

let g:ale_linters= {'c': ['ccls'], 'cpp': ['ccls', 'clangtidy'], 'yaml': ['yamllint'], 'python': ['pylsp']}
let g:ale_linters_ignore= {'cpp': ['clangtidy']}
"let g:ale_linters_explicit=1

let g:ale_fixers = {'cpp': ['clang-format']}
let g:ale_fix_on_save = 1

nnoremap <C-RightMouse> :ALEGoToDefinition -tab<CR>
nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>
nmap gd :ALEGoToDefinition<CR>
nmap gt :ALEGoToDefinition -tab<CR>
nmap gr :ALEFindReferences<CR>

"
set noendofline
set nofixendofline
