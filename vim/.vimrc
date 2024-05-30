" Basic settings
set nocompatible              " Disable compatibility with old vi
set number                    " Show line numbers
set relativenumber            " Show relative line numbers
set showcmd                   " Show command in the bottom bar
set cursorline                " Highlight the current line
set wildmenu                  " Enable command-line completion
set lazyredraw                " Improve performance for macros and scripts
set ttyfast                   " Speed up scrolling
set clipboard=unnamedplus     " Use system clipboard
set mouse=a                   " Enable mouse support

" Indentation settings
set autoindent                " Auto-indent new lines
set smartindent               " Smart indentation
set tabstop=4                 " Number of spaces that a <Tab> in the file counts for
set shiftwidth=4              " Number of spaces to use for each step of (auto)indent
set expandtab                 " Convert tabs to spaces

" Search settings
set hlsearch                  " Highlight search results
set incsearch                 " Show search results as you type
set ignorecase                " Ignore case when searching
set smartcase                 " Override ignorecase if search pattern contains uppercase

" Visual settings
syntax on                     " Enable syntax highlighting
set background=dark           " Use a dark background
colorscheme desert            " Set colorscheme to desert

" Status line
set laststatus=2              " Always show the status line

" Key mappings
nnoremap <C-s> :w<CR>         " Save file with Ctrl-s
inoremap <C-s> <Esc>:w<CR>a   " Save file with Ctrl-s in insert mode
nnoremap <C-c> :nohlsearch<CR>" Clear search highlighting with Ctrl-c

" Plugin settings (example with vim-plug)
" Ensure you have vim-plug installed before using these settings
" Install vim-plug by running: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ 
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" List of plugins
Plug 'preservim/nerdtree'    " File tree explorer
Plug 'tpope/vim-fugitive'     " Git integration
Plug 'airblade/vim-gitgutter' " Git diff in the gutter

call plug#end()

" NERDTree settings
map <C-n> :NERDTreeToggle<CR> " Toggle NERDTree with Ctrl-n
autocmd VimEnter * NERDTree   " Open NERDTree on Vim startup
