" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

" Start in normal mode
let g:todo_edit = 0

nmap <silent> j $/[<cr>l:noh<cr>
nmap <silent> k 0?]<cr>h:noh<cr>
nmap <silent> x r 
nmap <silent> v rv

nmap <silent> e :call TodoEditToggle()<CR>

function! TodoEditToggle()
  if g:todo_edit
    let g:todo_edit = 0
    nmap <silent> j $/[<cr>l:noh<cr>
    nmap <silent> k 0?]<cr>h:noh<cr>
    nmap <silent> x r 
    nmap <silent> v rv
  else
    let g:todo_edit = 1
    unmap j
    unmap k
    unmap x
    unmap v
  endif
endfunction

" nmap <silent> j $/[<cr>l:noh<cr>
" nmap <silent> k 0?]<cr>h:noh<cr>
