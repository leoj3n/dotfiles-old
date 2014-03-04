set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let Vundle manage Vundle (required).
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Bundle 'gmarik/vundle'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitHub bundles.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Bundle 'tpope/vim-git'
Bundle 'kien/ctrlp.vim'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-rails'
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-repeat'
Bundle 'mattn/webapi-vim'
Bundle 'reedes/vim-wordy'
Bundle 'justinmk/vim-gtfo'
Bundle 'majutsushi/tagbar'
Bundle 'int3/vim-extradite'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-surround'
Bundle 'justinmk/vim-sneak'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-projectile'
Bundle 'itchyny/lightline.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'pangloss/vim-javascript'
Bundle 'stephpy/vim-php-cs-fixer'
Bundle 'sumpygump/php-documentor-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-scripts bunldes.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Bundle 'L9'
Bundle 'FuzzyFinder'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Non-GitHub bundles.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bundle 'git://git.wincent.com/command-t.git'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local bundles.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bundle 'file:///Users/gmarik/path/to/plugin'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other bundle settings.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change leader and show it in bottom right.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
set showcmd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THEME
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light
colorscheme solarized

syntax enable       " enable syntax highlighting
set cursorline      " highlight the current line
set nobackup        " don't create pointless backup files; Use VCS instead
set autoread        " watch for file changes
set number          " show line numbers
set showcmd         " show selection metadata (like selected character count)
set noshowmode      " don't show INSERT, VISUAL, etc. mode
set showmatch       " show matching brackets
set smarttab        " better backspace and tab functionality
set scrolloff=5     " show at least 5 lines above/below
filetype on         " enable filetype detection
filetype indent on  " enable filetype-specific indenting
filetype plugin on  " enable filetype-specific plugins

" tabs and indenting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab       " spaces instead of tabs
set smartindent     " smart indenting
set autoindent smartindent  " auto/smart indent

" bells
set noerrorbells  " turn off audio bell
set visualbell    " but leave on a visual bell

" search
set hlsearch    " highlighted search results
set showmatch   " show matching bracket

" other
set guioptions=aAace  " don't show scrollbar in MacVim

" clipboard
set clipboard=unnamed " allow yy, etc. to interact with OS X clipboard


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'solarized_light',
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
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
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
    return strlen(_) ? '⭠ '._ : ''
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

