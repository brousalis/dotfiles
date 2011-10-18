" fonts, colors etc
syntax on
colorscheme molokai
"let g:zenburn_high_Contrast=1
"colorscheme zenburn

" settings 
set nocompatible                " don't hack around for vi compatiblity
set mouse=a                     " because i'm lame
set nu
set guifont=Inconsolata\ Medium\ 15 " attractive font
set backup                      " do backups
set backupdir=~/.vimbackup      " put backups in one place
set directory=~/.vimtmp         " put tmp files in one place
set dir=~/.vimtmp               " for backup swaps
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
set cursorline                  " underline the current line
set wrap!                       " no wordwrap
set backspace=eol,start,indent  " allow backspace to delete linebreaks
set scrolloff=10                " have 3 lines of offset (or buffer) when scrolling
set sidescroll=10               " 3 line buffer horizontally as well

set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete first full match

set pastetoggle=<F2>            " toggle paste indentation w/ F2
set clipboard+=unnamed          " share clipboard
set more                        " page on extended output
set ttyfast                     " smoother redraws
set lazyredraw                  " do not redraw while executing macros
set showcmd                     " show command being typed
set tags=tags;/                 " grab tags directory, all the way up to root

filetype on                     " enable filetype
filetype plugin on
filetype indent on

if has('autocmd')
  au filetype php set tabstop=4    " four spaces for PHP tabs
  au filetype php set shiftwidth=4 " four spaces for PHP tabs
  au filetype ruby set list        " list chars in ruby
  au filetype ruby set listchars=tab:>-,trail:- " list trailing spaces + all tabs
  au filetype ruby set list        " list chars in js
  au filetype js set listchars=tab:>-,trail:- " list trailing spaces + all tabs

  au BufNewFile,BufRead *.scss set filetype=css
  au BufNewFile,BufRead *.ejs set filetype=html
  au BufNewFile,BufRead *.tpl set filetype=ruby
endif

" == mappings ==

" fix my bad habits
cmap w!! %!sudo tee > /dev/null %

" leader + custom macros
let mapleader = ","
nnoremap <leader>dW pldW
nnoremap <leader>dw pldw
nnoremap <leader><space> :noh<cr>
nnoremap <leader>u gUgU
nnoremap <leader>l gugu
inoremap jj <Esc>
nnoremap ; :
nnoremap <C-d> :q<cr>
nnoremap <C-.> @:
nnoremap Y y$
nnoremap T ct
map <leader>wrap :set wrap!<cr>
map <F12> ggVGg?
map <F9> @:
inoremap <C-tab> <Esc><<i

" = no more arrow key navigation
"inoremap <Left> <NOP>
"inoremap <Right> <NOP>
"inoremap <Up> <NOP>
"inoremap <Down> <NOP>
"nnoremap <Left> <NOP>
"nnoremap <Right> <NOP>
"nnoremap <Up> <NOP>
"nnoremap <Down> <NOP>
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

" move a line of text w/ alt-jk
nnoremap <F4> :m+<CR>==
nnoremap <F3> :m-2<CR>==
inoremap <F4> <Esc>:m+<CR>==gi
inoremap <F3> <Esc>:m-2<CR>==gi
vnoremap <F4> :m'>+<CR>gv=gv
vnoremap <F3> :m-2<CR>gv=gv

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" paste some lorem text by typing lllorem and hitting tab
iab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit
iab llorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi
iab lllorem Lorem ipsum dolor sit amet, consectetur adipiscing elit.  Etiam lacus ligula, accumsan id imperdiet rhoncus, dapibus vitae arcu.  Nulla non quam erat, luctus consequat nisi.  Integer hendrerit lacus sagittis erat fermentum tincidunt.  Cras vel dui neque.  In sagittis commodo luctus.  Mauris non metus dolor, ut suscipit dui.  Aliquam mauris lacus, laoreet et consequat quis, bibendum id ipsum.  Donec gravida, diam id imperdiet cursus, nunc nisl bibendum sapien, eget tempor neque elit in tortor

if has('autocmd')
  autocmd filetype php map <C-/> i//<Esc>
  autocmd filetype ruby map <C-/> i#<Esc>
endif

nmap <silent> <Leader>n :NERDTreeToggle<CR>

map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l
map <Leader>h <C-w>h 

inoremap <Left> <NOP>
inoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
