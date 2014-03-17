set autoindent
set tabstop=4
set shiftwidth=4    " something about visual mode, idk
set expandtab
set softtabstop=4   " removes 4 spaces at a time

set hlsearch        " highlight search results
set incsearch       " display results as search string is typed
set ignorecase      " case-insensitive . . .
set smartcase       " . . . unless it contains a capital letter

"set clipboard=unnamedplus   " yank and paste from X clipboard
set mouse=a
syntax on           " syntax highlighting

"latex stuff
filetype plugin indent on
set grepprg=grep\ -nH\$*
let g:tex_flavor = "latex"

"Allow saving of files as superuser when I forgot to start vim using sudo
cmap w!! w !sudo tee % > /dev/null

"Make 81st column stand out (courtesy of Damian Conway, /watch?v=aHm36-na4-4)
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

