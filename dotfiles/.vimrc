" Cobbled together from the following sources:
"   http://items.sjbach.com/319/configuring-vim-right
"   https://github.com/skwp/dotfiles/blob/master/vimrc
"   http://dougblack.io/words/a-good-vimrc.html


set nocompatible " use vi IMproved

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/plugins.vim"))
  source ~/.vim/plugins.vim
endif

" Colors and Syntax
colorscheme desert
syntax enable " enable syntax detection

" Pretty coloring for popup menus
highlight Pmenu ctermfg=5 ctermbg=white

" Make the text in a selected menu item a little bit brighter
highlight PmenuSel ctermfg=127 ctermbg=white 
highlight Visual cterm=NONE ctermbg=255

" Tabs
set tabstop=4 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " tabs are spaces
set shiftwidth=4 " number of columns per TAB when reindenting

" Customize indentLine plugin
let indentLine_leadingSpaceEnabled = 1
let indentLine_char = "|"
let indentLine_color_term = 252 " Slightly lighter than the default

" Miscellaneous
set number " show line numbers
set title " Give the vim window a title
set hidden " Allow vim to handle multiple buffers effectively

" Backup
set backupdir=~/.vim/tmp,. " Include the current directory in case ~/.vim/tmp doesn't exist.
set directory=~/.vim/tmp,.

" Searching
set incsearch " search as characters are entered
set hlsearch " highlight matches

set ignorecase " Case-insensitive \-style search
set smartcase " Do case-sensitive \-style search if the term contains a capital letter

" Hotkeys
let mapleader = "," " , is easier to type than \

" Autocompletion
set wildmenu " Show multiple completion suggestions
set wildmode=list:longest " Only complete up to the first point of ambiguity
