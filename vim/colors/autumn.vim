" Maintainers:  Chris Jones & Kenneth Love
" Version:      1.0
" Last Change:  November 8th, 2010
" Credits:      This is a port of Yorick Peterse's Autumn scheme for Komodo

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "autumn"

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine     guibg=#202020 ctermbg=234
  hi CursorColumn   guibg=#202020 ctermbg=234
  hi MatchParen     guifg=#d0ffc0 guibg=#202020 gui=bold ctermfg=157 ctermbg=237 cterm=bold
  hi Pmenu          guifg=#ffffff guibg=#202020 ctermfg=255 ctermbg=238
  hi PmenuSel       guifg=#000000 guibg=#b1d631 ctermfg=0 ctermbg=148
  hi ColorColumn    guibg=#76443D
endif

" General colors
hi Cursor           guifg=NONE    guibg=#626262 gui=none ctermbg=241
hi Normal           guifg=#eeeeee guibg=#292929 gui=none ctermfg=253 ctermbg=234
hi NonText          guifg=#808080 guibg=#292929 gui=none ctermfg=244 ctermbg=235
hi LineNr           guifg=#6c6c6c guibg=#292929 gui=none ctermfg=244 ctermbg=232
hi StatusLine       guifg=#292929 guibg=#6c6c6c gui=none ctermfg=253 ctermbg=238
hi StatusLineNC     guifg=#6c6c6c guibg=#292929 gui=none ctermfg=246 ctermbg=238
hi VertSplit        guifg=#444444 guibg=#292929 gui=none ctermfg=238 ctermbg=238
hi Title            guifg=#f6f3e8 guibg=NONE gui=bold ctermfg=254 cterm=bold
hi Visual           guifg=#faf4c6 guibg=#3c414c gui=none ctermfg=254 ctermbg=4
hi SpecialKey       guifg=#808080 guibg=#343434 gui=none ctermfg=244 ctermbg=236
hi Folded           guifg=#000000 guibg=#4D4D4D
hi FoldColumn       guifg=#6c6c6c guibg=#292929
hi SignColumn       guifg=#76443d guibg=#292929
hi MatchParen       guifg=#eeeeee guibg=#6c6c6c
hi Visual           guifg=#000000 guibg=#76443d
hi link VertSplit Folded

" Syntax highlighting
hi Comment         guifg=#6c6c6c gui=italic ctermfg=244
hi Todo            guifg=#8f8f8f gui=none ctermfg=245
hi Boolean         guifg=#b1d631 gui=none ctermfg=148
hi String          guifg=#73b093 gui=none ctermfg=148
hi Identifier      guifg=#b1d631 gui=none ctermfg=148
hi Function        guifg=#f5f3cd gui=none ctermfg=255
hi Type            guifg=#eb5d49 gui=none ctermfg=103
hi Statement       guifg=#eb5d49 gui=none ctermfg=103
hi Keyword         guifg=#ff9800 gui=none ctermfg=208
hi Constant        guifg=#ff9800 gui=none  ctermfg=208
hi Number          guifg=#b4ecbf gui=none ctermfg=208
hi Special         guifg=#ff9800 gui=none ctermfg=208
hi PreProc         guifg=#faf4c6 gui=none ctermfg=230
hi Todo            guifg=#ff9f00 guibg=#202020 gui=none

" Code-specific colors
hi pythonImport    guifg=#009000 gui=none ctermfg=255
hi pythonException guifg=#f00000 gui=none ctermfg=200
hi pythonOperator  guifg=#7e8aa2 gui=none ctermfg=103
hi pythonBuiltinFunction guifg=#009000 gui=none ctermfg=200
hi pythonExClass   guifg=#009000 gui=none ctermfg=200
hi pythonDecorator guifg=#ff0000
hi link pythonComment String

" Custom Python Syntax
"syn keyword pythonReturn return
"hi pythonReturn guifg=#ff6fcf
