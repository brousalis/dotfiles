" Vim file plugin for editing files with unicode codes.
"
" It changes \u00E9 to é when viewing, and puts \u00E9 when writing. Set g:ucs_encode_java 
" in your .vimrc
"
" You can also set it to work with html encoding ( &#nnn; ). Set g:ucs_encode_html in your
" .vimrc
"
" You can also set it to convert accented characters to octal encoding ( \340 ). Set g:ucs_encode_octal in your
" .vimrc
" for help with the accented characters, see :help digraph
" copied/mangled from a script on www.vim.org that did it for TeX codes
"
" Usage: put in your $VIMDIR/plugin directory, set one of the variables
" 	either g:ucs_encode_java = 1 or g:ucs_encode_html = 1 in your .vimrc
" 	or override any of the ucs_ variables if you like
" Last Change: $Date: 2007/05/16 17:34:45 $
" Version: $Revision: 1.7 $ 
" Maintainer: Roger Pilkey (rpilkey at gmail.com)

"Startup stuff {{{1
if exists("s:loaded_unicodeswitch")
	finish
endif
let s:loaded_unicodeswitch = 1
"
" multi-byte is required
if ! has("multi_byte")
	echoerr "unicodeswitch.vim: Sorry, this version of (g)vim was not compiled with +multi_byte" 
	finish
endif

" Global variables: {{{1
" Set one of these in your .vimrc to set all the settings for either java or
" html style encoding, like this:
"
" let g:ucs_encode_java = 1
" or
" let g:ucs_encode_html = 1
" or
" let g:ucs_encode_octal = 1
"
" Or put your own settings in your .vimrc following these as examples.
"
" g:ucs_encode_java: load all the settings for "\u00AA" java-style encoding {{{2
if exists('g:ucs_encode_java')
	let s:ucs_prefix = '\\u'
	"matches a 4-digit hex number
	let s:ucs_encodematch = '\x\{1,4}'
	let s:ucs_suffix = ''
	let s:ucs_is_hex = 1
	let s:ucs_is_octal = 0
	let s:ucs_filetype = '*.properties,*.java'
	let s:ucs_digits = 4
" g:ucs_encode_html: load all the settings for "&#123;" html-style encoding {{{2
elseif exists('g:ucs_encode_html')
	let s:ucs_prefix = '&\#'
	"minimal match 3 digits
	let s:ucs_encodematch = '\d\{1,3}'
	let s:ucs_suffix = ';'
	let s:ucs_is_hex = 0
	let s:ucs_is_octal = 0
	let s:ucs_filetype = '*.html'
	let s:ucs_digits = 3
" g:ucs_encode_octal: load all the settings for "\321" octal encoding{{{2
" (I needed this for printing accents in alert msg boxes)
elseif exists('g:ucs_encode_octal')
	let s:ucs_prefix = '\\'
	"minimal match 3 digits
	let s:ucs_encodematch = '\d\{1,3}'
	let s:ucs_suffix = ''
	let s:ucs_is_hex = 0
	let s:ucs_is_octal = 1
	let s:ucs_filetype = '*.js'
	let s:ucs_digits = 3
else
	"no settings found, so quit
	finish
endif
" you can also override the individual settings {{{2
" s:ucs_prefix: encoding prefix {{{3
if exists('g:ucs_prefix')
	let s:ucs_prefix = g:ucs_prefix
endif

" s:ucs_encodingmatch: match string for the number {{{3
if exists('g:ucs_encodematch')
	let s:ucs_encodematch = g:ucs_encodematch
endif

" s:ucs_suffix: encoding suffix {{{3
if exists('g:ucs_suffix')
	let s:ucs_suffix = g:ucs_suffix
endif

" s:ucs_is_hex: is the incoming encoded number hexadecimal? {{{3
if exists('g:ucs_is_hex')
	let s:ucs_is_hex = g:ucs_is_hex
endif

" s:ucs_is_octal: is the incoming encoded number octal? {{{3
if exists('g:ucs_is_octal')
	let s:ucs_is_octal = g:ucs_is_octal
endif

" s:ucs_filetype: run on matching files {{{3
if exists('g:ucs_filetype')
	let s:ucs_filetype = g:ucs_filetype
endif

" s:ucs_digits: number of digits to print in the encoded string{{{3
if exists('g:ucs_digits')
	let s:ucs_digits = g:ucs_digits
endif

" s:ucs_charlist: list of chars to transform when writing (default is the European chars in the Latin-1 supplement) {{{2 
if exists('g:ucs_charlist')
	let s:ucs_charlist = g:ucs_charlist
else
	"use a character class to search, it's a bit faster than alternation
	let s:ucs_charlist = '[àáâãäåæèéêëìíîïòóôõöùúûüýÿ¿¡ñßçšž«»]'
endif

" Hook the functions to the Read/Write events {{{1
augroup unicodeswitch
	exe "autocmd BufReadPost " . s:ucs_filetype . " call s:toUTF8()"
	exe "autocmd BufWritePre " . s:ucs_filetype . " call s:toUnicode()"
	exe "autocmd BufWritePost " . s:ucs_filetype . " call s:toUTF8()"
augroup END

" function: ZeroExtend(string) returns the zero-extended string of a string. {{{1
func s:ZeroExtend(str,digits)
	let l:retval = a:str
	let l:len = strlen(l:retval)
	let l:zeroes = a:digits - l:len
	while l:zeroes > 0
		let l:retval = "0".l:retval
		let l:zeroes = l:zeroes - 1
	endwhile
	return l:retval
endfunc

" function: Nr2Hex(nr) returns the Hex string of a number. {{{1
func s:Nr2Hex(nr)
	let n = a:nr
	let r = ""
	while n
		let r = '0123456789ABCDEF'[n % 16] . r
		let n = n / 16
	endwhile
	return r
endfunc

" function: Nr2Octal(nr) returns the Octal string of a number. {{{1
func s:Nr2Octal(nr)
	let n = a:nr
	let r = ""
	while n
		let r = '012345678'[n % 8] . r
		let n = n / 8 
	endwhile
	return r
endfunc

" function: toUnicode converts utf8 symbols to unicode codes {{{1
function s:toUnicode()
	" store cursor position
	let s:line = line(".")
	let s:column = col(".")
	" convert SPECIFIED utf-8 symbols to unicode codes
	if s:ucs_is_hex
		silent exec ":%s/\\(".s:ucs_charlist."\\)/\\='".s:ucs_prefix."'.s:ZeroExtend(s:Nr2Hex(char2nr(submatch(1))),".s:ucs_digits.").'".s:ucs_suffix."'/ieg"
	elseif s:ucs_is_octal
		silent exec ":%s/\\(".s:ucs_charlist."\\)/\\='".s:ucs_prefix."'.s:ZeroExtend(s:Nr2Octal(char2nr(submatch(1))),".s:ucs_digits.").'".s:ucs_suffix."'/ieg"
	else
		silent exec ":%s/\\(".s:ucs_charlist."\\)/\\='".s:ucs_prefix."'.s:ZeroExtend(char2nr(submatch(1)),".s:ucs_digits.").'".s:ucs_suffix."'/ieg"
	endif
	"default to something
	if !exists('s:oldencoding')
		let s:oldencoding = &l:fileencoding
	endif
	if !exists('s:line')
		let s:line = line(".")
	endif
	if !exists('s:column')
		let s:column = col(".")
	endif

	" restore old encoding before writing
	let &l:fileencoding = s:oldencoding
	" restore cursor position
	call cursor(s:line,s:column)
endfunction

" function: toUTF8() converts unicode codes to utf-8 symbols {{{1
function s:toUTF8()
	" store cursor position
	let s:line = line(".")
	let s:column = col(".")

	" store the fileencoding
	let s:oldencoding = &l:fileencoding

	" convert ALL unicode codes to utf-8 symbols (watch out!)
	if s:ucs_is_hex
		silent exec ":%s/".s:ucs_prefix."\\(".s:ucs_encodematch."\\)".s:ucs_suffix."/\\=nr2char('0x'.submatch(1))/ieg"
	elseif s:ucs_is_octal
		silent exec ":%s/".s:ucs_prefix."\\(".s:ucs_encodematch."\\)".s:ucs_suffix."/\\=nr2char('0'.submatch(1))/ieg"
	else
		silent exec ":%s/".s:ucs_prefix."\\(".s:ucs_encodematch."\\)".s:ucs_suffix."/\\=nr2char(submatch(1))/ieg"
	endif
	" restore cursor position
	call cursor(s:line,s:column)
endfunction

" vim600:tw=78:set fdm=marker:set fileformat=unix
