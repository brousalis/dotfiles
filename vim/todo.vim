" Vim syntax file
" Language:	.todo files
" Maintainer:	Josep M. Bach <josep.m.bachNOSPAN@gmail.com>
" Last Change:	2010 Sep 29

if exists("b:current_syntax")
  finish
endif

syn match       DATE            "\d\{2}\s\D\+\s\d\{4}"
syn match       TIME            "\(\d\d\.\d\d\)"

syn match xProjectTag /===/ nextgroup=xProject skipwhite
syn match xProject /\D\+/ contained

syn match xOkValue /√/ contained

syn region xOk start=/\[/ end=/\]/ contains=xOkValue
syn match xEmpty /\[\s\]/
syn match xTitle /TODO/

hi link xOk Type
hi link xEmpty Statement
hi link xTitle Error
hi link xProject Identifier

hi link DATE Todo
hi link TIME Special

let b:current_syntax = "todo"

" vim: ts=8 sw=2
