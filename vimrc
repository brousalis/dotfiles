" .vimrc - vim config

" fonts, colors etc
syntax on
set t_Co=256
set background=dark
colorscheme jellybeans

" settings 
set nocompatible                " don't hack around for vi compatiblity
set mouse=a                     " because i'm lame
set nu                          " line numbers
set backup                      " do backups
set backupdir=~/.vimbackup      " put backups in one place
set directory=~/.vimtmp         " put tmp files in one place
set dir=~/.vimtmp               " for backup swaps
set noswapfile
set hidden                      " hide buffers, rather than closing them
set modelines=0                 " don't allow modelines
set smartindent                 " let vim indent for you
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indent on autoindenting
set tabstop=2                   " two-space tabs
set shiftwidth=2                " two-space tabs
set expandtab                   " use spaces for tabs
set incsearch                   " show search matches while you type
set ignorecase                  " ignore case when searching
set smartcase                   " ignore search case if all lowercase
set hlsearch                    " highlight search terms
set gdefault                    " default to global replace
set virtualedit=all             " free cursor mode
set wrap!                       " no wordwrap
set backspace=eol,start,indent  " allow backspace to delete linebreaks
set scrolloff=10                " have 3 lines of offset (or buffer) when scrolling
set sidescroll=10               " 3 line buffer horizontally as well
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete first full match
set pastetoggle=<F2>            " toggle paste indentation w/ F2
set clipboard+=unnamed          " share clipboard
set clipboard=unnamed
set more                        " page on extended output
set ttyfast                     " smoother redraws
set lazyredraw                  " do not redraw while executing macros
set showcmd                     " show command /eing typed
set tags=~/.tags                " grab tags directory, all the way up to root
set title                       " set the title

" filetypes
filetype on               
filetype plugin on
filetype indent on

if has('autocmd')
  au filetype php set tabstop=4                 " four spaces for PHP tabs
  au filetype php set shiftwidth=4              " four spaces for PHP tabs
  au filetype ruby set list                     " list chars in ruby
  au filetype ruby set listchars=tab:>-,trail:- " list trailing spaces + all tabs
  au filetype ruby set list                     " list chars in js
  au filetype js set listchars=tab:>-,trail:-   " list trailing spaces + all tabs

  au BufNewFile,BufRead *.erb set filetype=html
  au BufNewFile,BufRead *.tpl set filetype=ruby
  au BufRead,BufNewFile *.todo setfiletype todo 
endif

" copy paste
map <F8> :.w !pbcopy<CR><CR>
map <F9> :r !pbpaste<CR>

" fix my bad habits
cmap w!! %!sudo tee > /dev/null %

" leader + custom macros
let mapleader = ","
nnoremap <leader>dW pldW
nnoremap <leader>dw pldw
nnoremap <leader><space> :noh<CR>
nnoremap <leader>u gUgU
nnoremap <leader>l gugu
inoremap jj <Esc>
inoremap jk <Esc>
nnoremap ; :
nnoremap <C-d> :q<CR>
noremap Y $
noremap T ^
nmap <leader>w :set wrap!<CR>
nmap <leader>k :set list!<CR>
inoremap <C-tab> <Esc><<i

" use the home row
inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap j gj
nnoremap k gk

" move between files
map <C-K> <Esc>:next<CR>
map <C-J> <Esc>:prev<CR>
map <C-H> <Esc>:first<CR>
map <C-L> <Esc>:last<CR>

" ctags on better keys
map <M-Right> <C-]>
map <M-Left> <C-T>
map <M-Up> <Esc>:tp<CR>
map <M-Down> <Esc>:tn<CR>

" newline on shift/enter
map <S-Enter> O<Esc>j
map <CR> o<Esc>k

" move a line of text w/ F3/F4
nnoremap <F3> :m+<CR>==
nnoremap <F4> :m-2<CR>==
inoremap <F3> <Esc>:m+<CR>==gi
inoremap <F4> <Esc>:m-2<CR>==gi
vnoremap <F3> :m'>+<CR>gv=gv
vnoremap <F4> :m-2<CR>gv=gv

map <F1> :tabprev<CR>
map <F2> :tabnext<CR>

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" when vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" search
set ic
set smartcase
set hlsearch

" paste some lorem text by typing lllorem and hitting tab
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

" move between panes
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l
map <Leader>h <C-w>h 

" NERDTree
nmap <silent> <Leader>n :NERDTreeToggle<CR>

" ctrlp settings
let g:ctrlp_max_files =0
let g:ctrlp_max_depth =1000
let g:ctrlp_max_height = 50
let g:ctrlp_working_path_mode = 0

" Status Line
set statusline=%F%m%r%h%w\ %=[POS=%01l,%01v]\ [LEN=%L]
set ruler
:set laststatus=2

" folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" jump to last cursor position when opening a file.
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
     exe "normal g`\""
    endif
  end
endfunction
