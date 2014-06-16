"""""""""""""""""""""""""""""""""""
""" Vundle settings
"""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree' 
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'chiel92/vim-autoformat'
Plugin 'bling/vim-bufferline'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'

" End of plug-ins
call vundle#end()

filetype plugin indent on

"""""""""""""""""""""""""""""""""""
""" Settings
"""""""""""""""""""""""""""""""""""
set t_Co=256
set background=dark
syntax on
:silent! colorscheme molokai
set ruler
set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
set guioptions-=T 				" Removes top toolbar
set guioptions-=r 				" Removes right hand scroll bar
set go-=L 						" Removes left hand scroll bar
set linespace=15
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set showcmd                     " show (partial) command in the status line
set tags=tags
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
set visualbell           		" don't beep
set noerrorbells         		" don't beep
set autowrite  					" save on buffer switch
set mouse=a                     " enable mouse
let mapleader = ","             " remap <leader> to ,
let g:mapleader = ","
set timeout timeoutlen=200 ttimeoutlen=100
set wildmode=longest,list,full	" bash-like completion
set wildmenu
set hlsearch					" highlight serches 

"""""""""""""""""""""""""""""""""""
""" Airline
"""""""""""""""""""""""""""""""""""
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
set laststatus=2                " always show the statusline
set encoding=utf-8              " necessary to show Unicode glyphs
set noshowmode                  " hide the default mode text (e.g. -- INSERT -- below the statusline)


"""""""""""""""""""""""""""""""""""
""" Maping/re-maping
""""""""""""""""""""""""""""""""""" 

" Map <tab> for autocompletion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" Fast saves
nmap <leader>w :w!<cr>

noremap <F3> :Autoformat<CR><CR>    
set pastetoggle=<F10>               " toggle paste mode

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>
 
" Create/edit file in the current directory
nmap :ed :edit %:p:h/
 
" Down is really the next line
nnoremap j gj
nnoremap k gk
 
"Easy escaping to normal model
imap jj <esc>
 
"Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
 
"easier window navigation
 
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
 
"Resize vsplit
nmap <C-v> :vertical resize +5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>
 
nmap <C-b> :NERDTreeToggle<cr>
 
"Load the current buffer in Chromium
nmap ,c :!chromium<cr>
 
"Show (partial) command in the status line
set showcmd
 
" Create split below
nmap :sp :rightbelow sp<cr>
 
" Quickly go forward or backward to buffer
nmap :bp :BufSurfBack<cr>
nmap :bn :BufSurfForward<cr>
 
" Swap files out of the project root
set backupdir=~/.vim/backups/
set directory=~/.vim/swaps/
 
" Run PHPUnit tests
map <Leader>t :!phpunit %<cr>
 
" Easy motion stuff
let g:EasyMotion_leader_key = '<Leader>'
 
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
 
" Auto-remove trailing spaces
autocmd BufWritePre *.php :%s/\s\+$//e
 
" CtrlP Stuff
 
" Familiar commands for file/symbol browsing
map <D-p> :CtrlP<cr>
map <C-r> :CtrlPBufTag<cr>

" Hebrew switc
imap <f2> <c-o>:call ToggleHebrew()<cr>
map <f2> :call ToggleHebrew()<cr>
func! ToggleHebrew()
  if &rl
    set norl
    set keymap=
  else
    set rl
    set keymap=hebrew
  end
endfunc

filetype plugin on
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS
