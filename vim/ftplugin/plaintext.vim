" Plain text Filetype
" Usage: Prose writing in plain text.

set formatoptions=l
set lbr
set tw=80
set wm=4
set nolist

set wrap
set nonu

set smartindent
set spell spelllang=en_us
set virtualedit=all

" Remap keys for word wrapping
map <buffer> j gj
map <buffer> k gk
map <buffer> $ g$
map <buffer> 0 g0
map <buffer> ^ g^


