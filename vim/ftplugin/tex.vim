" Borrowed from plaintext.vim
set formatoptions=l
set lbr
set tw=80
set wm=4
set wrap
set smartindent
set spell spelllang=en_us
set virtualedit=all

" Remap keys for word wrapping
map <buffer> j gj
map <buffer> k gk
map <buffer> $ g$
"map <buffer> 0 g0
"map <buffer> ^ g^

" Forward search
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR>
 

set grepprg=grep\ -nH\ $*
filetype indent on

" From http://home.uchicago.edu/~alexlee/typography.html
set sw=2
set expandtab
set iskeyword+=:
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_flavor='latex'
let g:Tex_CompileRule_pdf = 'xelatex --synctex=1 --interaction=nonstopmode $*'
"let g:Tex_flavor='latex'
"let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode --synctex=1  $*'
let g:Tex_Folding = 0
let g:Tex_PromptedCommands = 'footnote,cite,pageref,label,g,emph'
let g:Tex_ViewRule_pdf = '/Applications/Skim.app'

" To ignore warnings
"let g:Tex_IgnoredWarnings =
"\"Underfull\n".
"\"Overfull\n".
"\"specifier changed to\n".
"\"You have requested\n".
"\"Missing number, treated as zero.\n".
"\"There were undefined references\n".
"\"Citation %.%# undefined\n".
"\'LaTeX Font Warning:'"
" This number N says that latex-suite should ignore the first N of the above.
"let g:Tex_IgnoreLevel = 0
