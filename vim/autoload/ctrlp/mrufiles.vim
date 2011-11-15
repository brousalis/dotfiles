" =============================================================================
" File:          autoload/ctrlp/mrufiles.vim
" Description:   Most Recently Used Files extension
" Author:        Kien Nguyen <github.com/kien>
" =============================================================================

" Static variables {{{
fu! ctrlp#mrufiles#opts()
	let opts = {
		\ 'g:ctrlp_mruf_max': ['s:max', 150],
		\ 'g:ctrlp_mruf_include': ['s:include', ''],
		\ 'g:ctrlp_mruf_exclude': ['s:exclude', ''],
		\ 'g:ctrlp_mruf_case_sensitive': ['s:csen', 1],
		\ }
	for key in keys(opts)
		let def = string(exists(key) ? eval(key) : opts[key][1])
		exe 'let' opts[key][0] '=' def '|' 'unl!' key
	endfo
endf
cal ctrlp#mrufiles#opts()
"}}}
fu! ctrlp#mrufiles#list(bufnr, ...) "{{{
	if s:locked | retu | en
	" Get the list
	let cadir  = ctrlp#utils#cachedir().ctrlp#utils#lash().'mru'
	let cafile = cadir.ctrlp#utils#lash().'cache.txt'
	let mrufs  = ctrlp#utils#readfile(cafile)
	" Remove non-existent files
	if exists('a:1') && a:1 == 1
		let mrufs = s:rmdeleted(mrufs, cadir, cafile)
	elsei exists('a:1') && a:1 == 2
		cal ctrlp#utils#writecache([], cadir, cafile)
		retu []
	en
	" Return the list
	if a:bufnr == -1 | retu mrufs | en
	" Filter it
	let filename = fnamemodify(bufname(a:bufnr + 0), ':p')
	if empty(filename) || !empty(&bt)
		\ || ( !empty(s:include) && filename !~# s:include )
		\ || ( !empty(s:exclude) && filename =~# s:exclude )
		\ || ( index(mrufs, filename) == -1 && !filereadable(filename) )
		retu
	en
	" Remove old matched entry
	cal filter(mrufs, 'v:val !='.( s:csen ? "#" : "?" ).' filename')
	" Insert new one
	cal insert(mrufs, filename)
	" Remove oldest entry
	if len(mrufs) > s:max | cal remove(mrufs, s:max, -1) | en
	cal ctrlp#utils#writecache(mrufs, cadir, cafile)
endf "}}}
fu! s:rmdeleted(mrufs, cadir, cafile) "{{{
	for each in range(len(a:mrufs) - 1, 0, -1)
		if empty(ctrlp#utils#glob(a:mrufs[each], 1))
			cal remove(a:mrufs, each)
		en
	endfo
	cal ctrlp#utils#writecache(a:mrufs, a:cadir, a:cafile)
	retu a:mrufs
endf "}}}
fu! ctrlp#mrufiles#init() "{{{
	let s:locked = 0
	aug CtrlPMRUF
		au!
		au BufReadPost,BufNewFile,BufWritePost *
			\ cal ctrlp#mrufiles#list(expand('<abuf>', 1))
		au QuickFixCmdPre  *vimgrep* let s:locked = 1
		au QuickFixCmdPost *vimgrep* let s:locked = 0
	aug END
endf "}}}

" vim:fen:fdl=0:fdc=1:ts=2:sw=2:sts=2
