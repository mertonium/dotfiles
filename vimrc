" Use Tpope's pathogem plugin system
" execute pathogen#infect()

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'thoughtbot/vim-rspec'

Plugin 'elixir-lang/vim-elixir'

Plugin 'digitaltoad/vim-pug'

Plugin 'maralla/completor.vim'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'tpope/vim-commentary'

Plugin 'mileszs/ack.vim'

Plugin 'scrooloose/nerdtree'

Plugin 'yalesov/vim-emblem'

Plugin 'w0rp/ale'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'lmeijvogel/vim-yaml-helper'

Plugin 'mhinz/vim-mix-format'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Set default encoding to UTF-8.
set encoding=utf-8 fileencodings=

" The first setting sets up 2-space tabs, the second tells vi to use 2 spaces when text is indented (auto or with the manual indent adjustmenters), and the third tells vi not to auto-replace spaces with tab characters.
set tabstop=2
set shiftwidth=2
set expandtab

" I indent my code myself, thank you very much.
" set nocindent
" set noautoindent

" Automatic indentation
set autoindent
set smarttab

" This setting will cause the cursor to very briefly jump to a brace/parenthese/bracket's match whenever you type a closing or opening brace/parenthese/bracket.
" set showmatch

" Keep 5 lines of context when scrolling
set scrolloff=5

" This setting prevents vi from making its annoying beeps when a command doesn't work. Instead, it briefly flashes the screen -- much less annoying.
set noerrorbells
" set vb t_vb=

" Case insensitive matching.
set ignorecase

" Automatically save before :next, :make etc.
set autowrite

" Backspace and cursor keys wrap
set whichwrap+=<,>,h,l

" Allow backspacing over everything in insert mode.
set backspace=start,indent,eol

" Tell vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:>-,trail:·,eol:$

" Make backup file
set backup
set backupdir=/tmp
set directory=/tmp

" Turn on wild menu
set wildmenu

" Path/file expansion in colon-mode.
set wildmode=longest:full,list:full,list:longest
set wildchar=<TAB>

" Enable vim modelines
" set modeline

" file for autosaved session
let g:ausession=".vimsession"

" Yes, we have a fast terminal
set ttyfast

" Make backup file
set nobackup

" Highlight search matches
set hlsearch

" Enable filetype-specific indenting and plugins
"filetype on
filetype indent on
filetype plugin on

" Enable syntax highlighting
syntax enable

" Use brighter colors if has a dark background.
set background=dark

" Comments should be grey
highlight Comment ctermfg=grey

" Support all three, in this order
set ffs=unix,mac,dos

" None of these should be word dividers, so make them not be
set isk+=_,$,@,%,#,-

" make sure it can save viminfo
" set viminfo+=!

" How many lines of history to remember
set history=1000

" Space it out a little more (easier to read)
set lsp=0

" This setting ensures that each window contains a statusline that displays the current cursor position.
set ruler
set cmdheight=1
set laststatus=2
set statusline=%F%h%m%w%r\ %Y\ (%{&ff})%=\ %c%V,\ %l/%L\ (%P)

" Make backspace work normal
set backspace=2

" Use mouse everywhere
set mouse=a

" Tell us when anything is changed via :...
set report=0

" Don't artificially wrap long lines on the screen
set nowrap

" Use bash instead of sh
set shell=/bin/bash

" Make window splitting behave
set noequalalways
set splitbelow

" Enable this if you mistype :w as :W or :q as :Q.
nmap :W :w
nmap :W! :w!
nmap :Q :q
nmap :Q! :q!
nmap :Wq! :wq!
nmap :WQ! :wq!

" Open where I left off
set viminfo='1000,\"1000,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

autocmd BufWritePre * :%s/\s\+$//e
"highlight ExtraTabs ctermbg=red guibg=red
let ruby_space_errors = 1
let c_space_errors = 1

" Comma seems more intuitive than the default \
let mapleader = ","

" NERDTree stuff
map <C-n> :NERDTreeToggle<CR>

" RSpec.vim mappings
let g:rspec_command = '!bundle exec rspec {spec}'
map <C-a>t :call RunCurrentSpecFile()<CR>
map <C-a>s :call RunNearestSpec()<CR>
map <C-a>l :call RunLastSpec()<CR>
map <C-a>a :call RunAllSpecs()<CR>

" Use ag instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Get ctrlp to respect the .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" Remap ctrlp cache clear to <C-r>
let g:ctrlp_prompt_mappings = {
      \ 'PrtClearCache()': ['<c-r>'],
      \}

" Use Tab to select autocomplete option
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Ignore commit messages in
let g:completor_blacklist = ['gitcommit']

" from https://github.com/w0rp/ale#5v-how-can-i-show-errors-or-warnings-in-my-statusline
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" map - to move current line down
nmap - dd p
" map _ to move current line up
nmap _ dd kk p

" Open this file in a vsplit
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Source this file
nnoremap <leader>sv :source $MYVIMRC<cr>

inoremap jk <esc>

" Turn off highlighting with leader-h
nnoremap <leader>h :nohl<cr>

" Toggle on soft wrap
nnoremap <leader>sw :setlocal wrap!<cr>

" Toggle line numbers
nnoremap <leader>n :set number!<cr>

" Turn off dialyxir to save CPU
let g:ale_linters_ignore = ['dialyxir']
