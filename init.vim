call plug#begin()
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'fatih/vim-go'
Plug 'jremmen/vim-ripgrep'
Plug 'cohama/lexima.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'tpope/vim-vinegar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
Plug 'NLKNguyen/papercolor-theme'
Plug 'lifepillar/vim-solarized8'
Plug 'jlanzarotta/bufexplorer'
Plug 'PProvost/vim-ps1'
call plug#end()

set nocompatible
filetype off
filetype plugin indent on
set fileformat=unix
set fileformats=unix,dos

set autoindent
set smartindent

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set showcmd
set showmode

" use a viminfo
"set viminfo='10,\"100,:100,%,n~/.viminfo

if !has('gui_running')
  set t_Co=256
  set termguicolors
endif

" more natural splits
set splitbelow
set splitright

" show line number
set number relativenumber

syntax enable
set background=light
colorscheme solarized8

" put annoying files elsewhere
" set directory=$HOME/vimfiles/swap
" set backupdir=$HOME/vimfiles/swap
" set undodir=$HOME/vimfiles/swap

" set tab width stuff
set tabstop=2 shiftwidth=2
set smarttab
set expandtab
set backspace=indent,eol,start

set encoding=utf-8
set autowrite
set hidden
set laststatus=2

set ruler

" search config
set hlsearch
set ignorecase
set smartcase

" send characters more quickly
set ttyfast

" wrap options
set wrap
set textwidth=79

if has('mouse')
set mouse=a
endif

set guifont=IBM\ Plex\ Mono:h14

let mapleader = ","

" Fast saving
nmap <leader>w <C-w>

" Fast close buffer
nmap <leader>q :bd<cr>

" Disable ctrl-c
imap <C-c> nop

" set 80 character line limit
set colorcolumn=80

" Set whitespace to show up selectively
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:~            " show trailing spaces as dots
set list

" buffer nav
nnoremap <leader>b :BufExplorer<CR>
nmap [b :bn<cr>
nmap ]b :bp<cr>

" some vim-go stuff
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <leader>gf <Plug>(go-test-func)

let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_metalinter_autosave = 1
let g:go_metalinter_command = 'golangci-lint'

augroup go
 autocmd!
 autocmd Filetype go
    \  command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    \| command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    \| command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" copy and paste
vmap <C-c> "+y
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" vimrc files use vim syntax
autocmd BufNewFile,BufRead vimrc set syntax=vim

set path+=.
set suffixesadd=.js,.jsx

" configure netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" enable undo file
set undofile

" open and reload vimrc easily
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" open quickfix when it has content
nnoremap <leader>m :w<cr>:make<cr>
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" double escape to noh
nmap <ESC><ESC> :noh<CR>

" fugitive mappings
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>

" function for running jest on the current test file
function JestRun()
  set shellslash
  Dispatch npx jest %
  set noshellslash
endfunction
nmap <leader>tf :call JestRun()<CR>

" function for focusing the current test file
function JestFocus()
  set shellslash
  Focus yarn jest %
  set noshellslash
endfunction
nmap <leader>ff :call JestFocus()<CR>

" function for opening tests beside files
function OpenTest()
  only
  execute 'e ' . expand('%:r') . '.test.' . expand('%:e')
endfunction
nmap <leader>et :call OpenTest()<CR>

" function for opening a lab notebook date
function OpenToday()
  execute 'e ~/OneDrive/Lab Notes/' . strftime('%Y-%m-%d') . '.md'
endfunction
nmap <leader>el :call OpenToday()<CR>


autocmd FileType filelist nmap <buffer> <silent> <ENTER> :e <cfile><CR>
function ListFiles()
  let name = 'file-list'
  execute 'e ' . name
  read !git ls-files
  1
  setlocal buftype=nofile
  setlocal bufhidden=unload
  setlocal nobuflisted
  setlocal noswapfile
  setlocal filetype=filelist
endfunction
nmap <leader>t :call ListFiles()<CR>

" enable python
let g:python3_host_prog='C:/Users/alanj/scoop/apps/python/current/python.exe'
let g:python_host_prog='C:/Users/alanj/scoop/apps/python/current/python.exe'

" open powershell term
nnoremap <leader>ts :term powershell.exe<CR>

" simplify nav between panels
nnoremap <A-h> <C-w><C-h>
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>
nnoremap <A-r> <C-w>r
tnoremap <A-h> <C-\><C-n><C-w><C-h>
tnoremap <A-j> <C-\><C-n><C-w><C-j>
tnoremap <A-k> <C-\><C-n><C-w><C-k>
tnoremap <A-l> <C-\><C-n><C-w><C-l>
tnoremap <A-r> <C-\><C-n><C-w>r
tnoremap <leader><ESC> <C-\><C-n>

" prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

autocmd FileType sql setlocal commentstring=--\ %s
