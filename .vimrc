"------------------------------------------------------------------------------------------
" Configuration de la police pour l'interface graphique (GUI)
" Choix entre Courier 10 Pitch ou Monospace 10 (commenté)
":set guifont=Courier\ 10\ Pitch
":set guifont=Monospace\ 10

" Encodage par défaut pour les fichiers et l'interface
" UTF-8 pour une compatibilité maximale (caractères spéciaux, C++20, etc.)
:set encoding=utf-8
:set fileencoding=utf-8

"------------------------------------------------------------------------------------------
" Options générales de Vim
set nobackup          " Désactive la création de fichiers de backup (~)
set modeline          " Autorise les modelines (configuration par fichier)
set nocompatible      " Désactive la compatibilité avec vi (comportement moderne)

"------------------------------------------------------------------------------------------
" Sécurise le chargement des fichiers .vimrc locaux (pour les projets)
set secure

"------------------------------------------------------------------------------------------
" Configuration des onglets dans l'interface graphique
" Affiche le nom du fichier et un indicateur de modification
set guitablabel=%m\ %t

"------------------------------------------------------------------------------------------
" Configuration de netrw (explorateur de fichiers intégré)
" Ouvre les fichiers avec xdg-open (Linux)
let g:netrw_browsex_viewer= "xdg-open"
let g:netrw_liststyle = 3  " Style de liste (arbre)
let g:netrw_banner = 0     " Désactive la bannière
let g:netrw_preview = 1    " Active l'aperçu des fichiers

"------------------------------------------------------------------------------------------
" Configuration pour les pages de manuel (man)
"runtime ftplugin/man.vim  " Décommenter si besoin de support avancé pour les man

"------------------------------------------------------------------------------------------
" Définition de la touche leader (ici ',')
let mapleader = ","

"------------------------------------------------------------------------------------------
" Activation de la souris (utile en mode graphique ou terminal moderne)
set mouse=a

"------------------------------------------------------------------------------------------
" Affichage amélioré de la dernière ligne et des caractères non imprimables
set display=lastline,uhex

"------------------------------------------------------------------------------------------
" Configuration du défilement et de l'affichage
set sidescroll=5     " Défilement horizontal par 5 colonnes
set listchars=precedes:<,extends:>  " Caractères pour les lignes longues
set nowrap            " Désactive le retour à la ligne automatique

"------------------------------------------------------------------------------------------
" Fonction pour ouvrir le fichier d'en-tête (.hpp ou .h) associé à un .cpp
" Utile pour le développement C++ (GTK3, traitement du signal, etc.)
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
" Mapping sur F7 pour un accès rapide
nnoremap <F7> :call OpenHeaderFile()<CR>

"------------------------------------------------------------------------------------------
" Ouverture rapide de fichiers dans le même répertoire que le fichier courant
" Utile pour naviguer dans les projets C++/GTK3
if has("unix")
    map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map <Leader>e :e <C-R>=expand("%:p:h") . "\" <CR>
endif
" Changement de répertoire courant vers celui du fichier
map <Leader>cd :cd <C-R>=expand("%:p:h") <CR>

"------------------------------------------------------------------------------------------
" Fonction de recherche avancée (grep) dans les fichiers C++/C
" fgc: recherche dans les .cpp/.c
" fgh: recherche dans les .hpp/.h
" fgall: recherche dans tous les fichiers
function! Grep(target, exp)
  let l:cmd = "cd " . expand("%:p:h")
  exe l:cmd
  copen  " Ouvre la fenêtre de résultats
  if a:target == "fgc"
    let l:cmd = "vimgrep " . a:exp . " *.cpp *.c"
  elseif a:target == "fgh"
    let l:cmd = "vimgrep " . a:exp . " *.hpp *.h"
  elseif a:target == "fgall"
    let l:cmd = "vimgrep " . a:exp . " *"
  endif
  exe l:cmd
endfunction
" Commandes et mappings associés
cab fgc   Fgc
cab fgh   Fgh
cab fgall Fgall
command -nargs=1 Fgc   call Grep("fgc", "/" . <f-args> . "/")
command -nargs=1 Fgh   call Grep("fgh", <f-args>)
command -nargs=1 Fgall call Grep("fgall", <f-args>)

"------------------------------------------------------------------------------------------
" Configuration pour l'édition de fichiers binaires (ex: .bin, .ttf)
" Utilise xxd pour afficher/modifier en hexadécimal
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
" Activation des plugins et de l'indentation automatique
filetype plugin indent on

"------------------------------------------------------------------------------------------
" Configuration de l'indentation pour le C++ (style personnel)
" Alignement des paramètres de fonction
set cinoptions=(0,w1=0

"------------------------------------------------------------------------------------------
" Configuration spécifique pour les terminaux xterm
if $TERM=="xterm"
"  set guioptions-=T  " Décommenter si besoin de désactiver la toolbar
endif
set guioptions+=b     " Ajoute la barre de défilement verticale

"------------------------------------------------------------------------------------------
" Désactive XIM (Input Method) pour éviter les conflits avec la saisie
set imdisable

"------------------------------------------------------------------------------------------
" Permet l'édition en mode virtuel (au-delà de la fin de ligne)
set virtualedit=all

"------------------------------------------------------------------------------------------
" Mapping pour répéter la dernière modification (comme en mode normal)
nnoremap <Leader>g [I

"------------------------------------------------------------------------------------------
" Recherche intelligente (ignore la casse sauf si majuscules présentes)
set ignorecase smartcase

"------------------------------------------------------------------------------------------
" Suppression d'une ligne avec la touche Del
nmap <Del> dd

"------------------------------------------------------------------------------------------
" Affichage des tabulations et espaces de fin de ligne
set list
set listchars+=tab:>.,trail:.

"------------------------------------------------------------------------------------------
" Configuration des marques (a-z, A-Z)
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

"------------------------------------------------------------------------------------------
" Configuration pour le débogage avec GDB (si Vim >= 8.0)
if v:version >= 800
  :packadd termdebug
endif

"------------------------------------------------------------------------------------------
" Mappings pour repositionner la ligne courante
" F1: en haut de la fenêtre, F2: au centre, F3: en bas
nmap <F1> z<CR>
nmap <F2> z.
nmap <F3> z-

"------------------------------------------------------------------------------------------
" Mappings pour exécuter des macros (F4 à F12)
" Utile pour automatiser des tâches répétitives (ex: génération de fenêtres de Hann)
nmap <F4>  @a
nmap <F9>  @b
nmap <F10> @c
nmap <F11> @d
nmap <F12> @e

"------------------------------------------------------------------------------------------
" Fonction pour basculer l'affichage des numéros de ligne (F5)
function! ToggleLineNumbering ()
  if &nu
    set nonu
  else
    set nu
  endif
endfun
nmap <F5> :call ToggleLineNumbering ()<CR>

"------------------------------------------------------------------------------------------
" Définitions des couleurs ANSI pour les scripts C/C++
iabbrev ccolors #define RED "\033[1;31m"<cr>#define GREEN "\033[1;32m"<cr>#define YELLOW "\033[1;33m"<cr>#define BLUE "\033[1;34m"<cr>#define MAGENTA "\033[1;35m"<cr>#define CYAN "\033[1;36m"<cr>#define WHITE "\033[0m"

"------------------------------------------------------------------------------------------
" Conversion hexadécimal ↔ décimal (F6)
" Utile pour le traitement du signal ou l'analyse binaire
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
" Répète la dernière commande en mode normal (.) avec ';'
nnoremap ; .
vnoremap ; :normal .<CR>

"------------------------------------------------------------------------------------------
" Configuration de la recherche
" Mise en évidence des résultats et recherche incrémentale
highlight IncSearch ctermfg=green ctermbg=blue guifg=green guibg=blue
set hlsearch
set incsearch

"------------------------------------------------------------------------------------------
" Configuration des tabulations et espaces
" Remplace les tabulations par des espaces (style flake8)
set expandtab
set tabstop=2     " 2 espaces pour une tabulation
set shiftwidth=3  " 3 espaces pour l'indentation automatique

"------------------------------------------------------------------------------------------
" Retour à la dernière position connue dans un fichier
autocmd BufReadPost * if line("'\"") | exe "normal '\"" | endif

" Thème de couleurs (morning)
colorscheme morning

"------------------------------------------------------------------------------------------
" Configuration d'Airline (barre de statut)
let g:airline#extensions#ale#enabled    = 1  " Intégration avec ALE
let g:airline#extensions#branch#enabled = 1  " Affiche la branche git
let g:airline_theme           = 'wombat'     " Thème sombre
let g:airline_powerline_fonts = 1            " Utilise les polices Powerline

"------------------------------------------------------------------------------------------
" Configuration d'ALE (linting et correction automatique)
" Intégration avec clang-tidy, flake8, etc.
let g:ale_enabled            = 1
let g:ale_lint_on_enter      = 1      " Vérification au chargement
let g:ale_completion_enabled = 1      " Complétion intelligente
let g:ale_open_list          = 1      " Liste des erreurs ouverte
let g:ale_list_window_size   = 1      " Taille de la fenêtre de liste
let g:ale_sign_error         = '💣 '  " Icône pour les erreurs
let g:ale_sign_warning       = '🚧 '  " Icône pour les avertissements

" Configuration spécifique pour C++ (clang-tidy)
let g:ale_cpp_clangtidy_extra_options = '--config-file=/home/yannick/.clangtidy'
" Configuration pour Python (flake8)
let g:ale_python_flake8_options = '--config /home/yannick/.flake8'
" Configuration pour cppcheck (analyse statique C++)
let g:ale_c_build_dir_names = []
let g:ale_c_build_dir = ''
let g:ale_cpp_cppcheck_use_makefile = 0
let g:ale_cpp_cppcheck_use_compile_commands = 0
let g:ale_cpp_cppcheck_options = '--std=c++20 --enable=all'

" Liste des linters par type de fichier
let g:ale_linters= {
         \ 'markdown': ['mdl'],
         \ 'c': ['ccls', 'iwyu'],
         \ 'cpp': ['ccls', 'clangtidy', 'iwyu', 'cppcheck'],
         \ 'yaml': ['yamllint'],
         \ 'python': ['flake8', 'pylsp']}
" Ignore clang-tidy pour C++ (si trop strict)
let g:ale_linters_ignore= {'cpp': ['clangtidy', 'cppcheck']}

" Correction automatique au sauvegarde (clang-format pour C++)
let g:ale_fixers = {'cpp': ['clang-format']}
let g:ale_fix_on_save = 1

" Mappings pour la navigation et l'inspection de code
nnoremap <C-RightMouse> :ALEGoToDefinition -tab<CR>
nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALEFindReferences<CR>
nmap K :ALEHover<CR>

"------------------------------------------------------------------------------------------
" Problématique du newline en fin de fichier
" Utile pour éviter les conflits avec git ou les outils de build
set nofixendofline
