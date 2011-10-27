" This is the autodetect file for the plain text filetype which is used
" generally for editing prose.

augroup plaintext 
     au! BufRead,BufNewFile *.txt   setfiletype plaintext 
augroup END

