" Intelligent Indent

inoremap <silent><expr> <Plug>ItabTab itab#doaction("\<tab>")
inoremap <silent><expr> <Plug>ItabCr itab#doaction("\<cr>")

" All below here is maps
if exists('itab#disable_all_maps') && itab#disable_all_maps
	finish
end

if !exists('itab#disable_maps') || !itab#disable_maps
	if mapcheck("\<tab>", 'i') == ""
		imap <tab> <Plug>ItabTab
	endif
	if mapcheck("\<cr>", 'i') == ""
		imap <cr> <Plug>ItabCr
	endif
endif

nnoremap <silent><expr> o itab#doaction("o")
nnoremap <silent><expr> O itab#doaction("O")
nnoremap <silent><expr> S itab#doaction("S")
nnoremap <silent><expr> cc itab#doaction("cc")

nnoremap <silent> = :set opfunc=itab#equalop<cr>g@
nnoremap <silent><expr> == ":left\<cr>" . itab#ndoaction("==")
vnoremap <silent><expr> = ":left\<cr>gv" . itab#ndoaction("=")
