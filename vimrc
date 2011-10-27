" pathogen 
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on
compiler ruby

" basic environment
set nocompatible
set shell=/bin/zsh
set fileformats=unix,mac,dos
set encoding=utf-8
set mouse=a
set nu
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest,full
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
syntax on
let mapleader = ","

" backups
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups

" status line
set statusline=%F%m%r%h%w%=%{fugitive#statusline()}\ (%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

" use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" navigate panes
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l
map <Leader>h <C-w>h 

" syntax definitions
filetype on               
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
 
" make j and k move up and down linewise even when wrapping
nnoremap j gj
nnoremap k gk

" easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l

" folding
set foldlevelstart=0
nnoremap <Space> za
vnoremap <Space> za
noremap <leader>ft Vatzf " fold HTML tag

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" remap manual key to nothing
nnoremap K <nop>
nmap <leader>k :set list!<CR>

" version 7.3 and up only
if v:version >= 730
    set undofile
    set undoreload=10000
    set colorcolumn=85
    function! g:ToggleNuMode() 
        if(&rnu == 1) 
            set nu 
        else 
            set rnu 
        endif 
    endfunc 
    nnoremap <leader>l :call g:ToggleNuMode()<cr>
endif

" security
set modelines=0 " don't check modelines, could be dangerous

" tabs/spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" thanks ben
set pastetoggle=<F2>            " toggle paste indentation w/ F2
set ttyfast                     " smoother redraws

" make Y not dumb -- makes it work from the cursor to the end of the line
nnoremap Y y$

" searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
map <leader><space> :noh<cr>
runtime macros/matchit.vim
nnoremap <tab> %
vnoremap <tab> %
map N Nzz
map n nzz

" NERDTree
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" sort CSS
map <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" ack
map <leader>a :Ack 

" yankring
nnoremap <silent> <leader>y :YRShow<cr>
let g:yankring_history_dir = '$HOME/.vim'

" Formatting
map <leader>q gqip 

" quickFix bar
nmap <silent> <leader>ff :QFix<cr>
nmap <leader>fn :cn<cr>
nmap <leader>fp :cp<cr>

command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction

" easier linewise reselection
map <leader>v V`]

" create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" faster ESC
inoremap <ESC> <nop>
inoremap jk <ESC>

" swap ; and :
nnoremap ; :
vnoremap ; :
inoremap jj <Esc>

" move a line of text w/ alt-jk
nnoremap <F4> :m+<CR>==
nnoremap <F3> :m-2<CR>==
inoremap <F4> <Esc>:m+<CR>==gi
inoremap <F3> <Esc>:m-2<CR>==gi
vnoremap <F4> :m'>+<CR>gv=gv
vnoremap <F3> :m-2<CR>gv=gv
 
" scratch
nmap <leader><tab> :Sscratch<cr><C-W>x<C-j>:resize 15<cr>

" make selecting inside an HTML tag less dumb
nnoremap Vit vitVkoj
nnoremap Vat vatV

" diff
nmap <leader>d :!hg diff %<cr>

" rainbows!
nmap <leader>R :RainbowParenthesesToggle<CR>

" edit vim stuff.
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>
nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.vim/snippets/<cr>

" sudo to write
cmap w!! w !sudo tee % >/dev/null

" easy filetype switching
nnoremap _ :set ft=

" python docs
nnoremap <leader>P :Pydoc<space>

" VCS Stuff
let VCSCommandMapPrefix = "<leader>h"

" disable useless HTML5 junk
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" save when losing focus
au FocusLost * :wa

" stop it, hash key
inoremap # X<BS>#

" show syntax highlighting groups for word under cursor
nmap <C-S> :call SynStack()<CR>
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" tags!
let g:tagbar_ctags_bin = "/usr/bin/ctags"
nnoremap <silent> <F4> :TagbarToggle<CR>

" gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_debug = 1
let g:gundo_preview_bottom = 1

" shortcut for square brackets
onoremap id i[
onoremap ad a[

" next ()
vnoremap <silent> inb :<C-U>normal! f(vib<cr>
onoremap <silent> inb :<C-U>normal! f(vib<cr>
vnoremap <silent> anb :<C-U>normal! f(vab<cr>
onoremap <silent> anb :<C-U>normal! f(vab<cr>
vnoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>
vnoremap <silent> an( :<C-U>normal! f(va(<cr>
onoremap <silent> an( :<C-U>normal! f(va(<cr>

" Next {}
vnoremap <silent> inB :<C-U>normal! f{viB<cr>
onoremap <silent> inB :<C-U>normal! f{viB<cr>
vnoremap <silent> anB :<C-U>normal! f{vaB<cr>
onoremap <silent> anB :<C-U>normal! f{vaB<cr>
vnoremap <silent> in{ :<C-U>normal! f{vi{<cr>
onoremap <silent> in{ :<C-U>normal! f{vi{<cr>
vnoremap <silent> an{ :<C-U>normal! f{va{<cr>
onoremap <silent> an{ :<C-U>normal! f{va{<cr>

" Next []
vnoremap <silent> ind :<C-U>normal! f[vi[<cr>
onoremap <silent> ind :<C-U>normal! f[vi[<cr>
vnoremap <silent> and :<C-U>normal! f[va[<cr>
onoremap <silent> and :<C-U>normal! f[va[<cr>
vnoremap <silent> in[ :<C-U>normal! f[vi[<cr>
onoremap <silent> in[ :<C-U>normal! f[vi[<cr>
vnoremap <silent> an[ :<C-U>normal! f[va[<cr>
onoremap <silent> an[ :<C-U>normal! f[va[<cr>

" Next <>
vnoremap <silent> in< :<C-U>normal! f<vi<<cr>
onoremap <silent> in< :<C-U>normal! f<vi<<cr>
vnoremap <silent> an< :<C-U>normal! f<va<<cr>
onoremap <silent> an< :<C-U>normal! f<va<<cr>

" Next ''
vnoremap <silent> in' :<C-U>normal! f'vi'<cr>
onoremap <silent> in' :<C-U>normal! f'vi'<cr>
vnoremap <silent> an' :<C-U>normal! f'va'<cr>
onoremap <silent> an' :<C-U>normal! f'va'<cr>

" Next ""
vnoremap <silent> in" :<C-U>normal! f"vi"<cr>
onoremap <silent> in" :<C-U>normal! f"vi"<cr>
vnoremap <silent> an" :<C-U>normal! f"va"<cr>
onoremap <silent> an" :<C-U>normal! f"va"<cr>

" Skipreturn
inoremap <c-cr> <esc>A<cr>
inoremap <s-cr> <esc>A:<cr>
au BufNewFile,BufRead *.html nnoremap <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

set cf " enable error files and error jumping

:map <F3> :w !texcount.pl -brief %<CR> " word count for *TeX files

inoreabbrev lorem Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.

" Buffer Mappings
map <right> <ESC>:bn<RETURN> " right arrow (normal mode) switches buffers  (excluding minibuf)
map <left> <ESC>:bp<RETURN> " left arrow (normal mode) switches buffers (excluding minibuf) 
map <up> <ESC>:NERDTree<RETURN><ESC><C-W><C-W> " up arrow (normal mode) brings up a file list
map <down> <ESC>:w<RETURN> " down arrow  (normal mode) brings up the buffer list

map <A-i> i <ESC>r " alt-i (normal mode) inserts a single char, and then switches back to normal
map <F12> ggVGg? " encrypt the file (toggle)

" HTML Filetype Settings
let g:do_xhtml_mappings = 'yes'

" Haskell Mode
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
let g:ghc = "/usr/bin/ghc"
"" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Solarized stuff
colorscheme molokai
call togglebg#map("<F6>")

map <F8> :set nowrap!<CR>

" Some GUI/CLI only settings
if has("gui_running")
    set go-=T
    set bg=dark
    hi normal guibg=black
    set transp=8

    " Remap help key to be more useful
    set fuoptions=maxvert,maxhorz
    inoremap <F1> <ESC>:set invfullscreen<CR>a
    nnoremap <F1> :set invfullscreen<CR>
    vnoremap <F1> :set invfullscreen<CR>
else
    set bg=dark
endif

" unicodeswitch.vim
let g:ucs_encode_html = 1

" prevent vim-R from turning _ into <-
let vimrplugin_underscore = 0

" FuzzyFinder mappings 
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
nnoremap <silent> <leader>sj     :FufBuffer<CR>
nnoremap <silent> <leader>sk     :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <leader>sK     :FufFileWithFullCwd<CR>
nnoremap <silent> <leader>s<C-k> :FufFile<CR>
nnoremap <silent> <leader>sl     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>sL     :FufCoverageFileChange<CR>
nnoremap <silent> <leader>s<C-l> :FufCoverageFileRegister<CR>
nnoremap <silent> <leader>sd     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <leader>sD     :FufDirWithFullCwd<CR>
nnoremap <silent> <leader>s<C-d> :FufDir<CR>
nnoremap <silent> <leader>sn     :FufMruFile<CR>
nnoremap <silent> <leader>sN     :FufMruFileInCwd<CR>
nnoremap <silent> <leader>sm     :FufMruCmd<CR>
nnoremap <silent> <leader>su     :FufBookmarkFile<CR>
nnoremap <silent> <leader>s<C-u> :FufBookmarkFileAdd<CR>
vnoremap <silent> <leader>s<C-u> :FufBookmarkFileAddAsSelectedText<CR>
nnoremap <silent> <leader>si     :FufBookmarkDir<CR>
nnoremap <silent> <leader>s<C-i> :FufBookmarkDirAdd<CR>
nnoremap <silent> <leader>st     :FufTag<CR>
nnoremap <silent> <leader>sT     :FufTag!<CR>
nnoremap <silent> <leader>s<C-]> :FufTagWithCursorWord!<CR>
nnoremap <silent> <leader>s,     :FufBufferTag<CR>
nnoremap <silent> <leader>s<     :FufBufferTag!<CR>
vnoremap <silent> <leader>s,     :FufBufferTagWithSelectedText!<CR>
vnoremap <silent> <leader>s<     :FufBufferTagWithSelectedText<CR>
nnoremap <silent> <leader>s}     :FufBufferTagWithCursorWord!<CR>
nnoremap <silent> <leader>s.     :FufBufferTagAll<CR>
nnoremap <silent> <leader>s>     :FufBufferTagAll!<CR>
vnoremap <silent> <leader>s.     :FufBufferTagAllWithSelectedText!<CR>
vnoremap <silent> <leader>s>     :FufBufferTagAllWithSelectedText<CR>
nnoremap <silent> <leader>s]     :FufBufferTagAllWithCursorWord!<CR>
nnoremap <silent> <leader>sg     :FufTaggedFile<CR>
nnoremap <silent> <leader>sG     :FufTaggedFile!<CR>
nnoremap <silent> <leader>so     :FufJumpList<CR>
nnoremap <silent> <leader>sp     :FufChangeList<CR>
nnoremap <silent> <leader>sq     :FufQuickfix<CR>
nnoremap <silent> <leader>sy     :FufLine<CR>
nnoremap <silent> <leader>sh     :FufHelp<CR>
nnoremap <silent> <leader>se     :FufEditDataFile<CR>
nnoremap <silent> <leader>sr     :FufRenewCache<CR>

let g:HammerQuiet = 1
