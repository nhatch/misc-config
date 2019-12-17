let tabsize=2
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'Xuyuanp/nerdtree'
"Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-rails'
"Plugin 'keith/swift.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx'
Plugin 'LaTeX-Suite-aka-Vim-LaTeX'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set hlsearch        " highlight search results
set incsearch       " display results as search string is typed
set ignorecase      " case-insensitive . . .
set smartcase       " . . . unless it contains a capital letter

set number          " line numbers

"set clipboard=unnamedplus   " yank and paste from X clipboard
syntax on           " syntax highlighting
highlight Identifier ctermfg=5
highlight Statement ctermfg=5
highlight Function ctermfg=black
highlight Type ctermfg=5
highlight LineNr ctermfg=4

"latex stuff
filetype plugin indent on
set grepprg=grep\ -nH\$*
let g:tex_flavor = "latex"

"Allow saving of files as superuser when I forgot to start vim using sudo
cmap w!! w !sudo tee % > /dev/null

"Make 81st column stand out (courtesy of Damian Conway, /watch?v=aHm36-na4-4)
"highlight ColorColumn ctermbg=magenta
"call matchadd('ColorColumn', '\%81v', 100)

"search and replace word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
"copy filename to clipboard
"noremap \l :!echo -n % | pbcopy<cr><cr> ????

set tags=~/core/tags
highlight Function ctermfg=Green

let g:Tex_MultipleCompileFormats='pdf,bib,pdf'

execute "set tabstop=".tabsize
" something about visual mode, idk
execute "set shiftwidth=".tabsize
set expandtab
" removes `tabsize` spaces at a time
execute "set softtabstop=".tabsize
set autoindent
" For some goddamn reason the above settings are ignored for Python files
" But upon reflection I do like 4-space tabs for Python, so commented out.
"autocmd FileType python exec 'setlocal shiftwidth='.tabsize
"autocmd FileType python exec 'setlocal tabstop='.tabsize
"autocmd FileType python exec 'setlocal softtabstop='.tabsize

" Open .bib files in paste mode
autocmd FileType bib setlocal paste

let $BASH_ENV = "~/.bash_aliases"
