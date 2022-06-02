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

for cmd in ['o', 'O', 'S', 'cc', ']p', '[P', ']P', '[p']
	if mapcheck(cmd, "n") == ""
		exec 'nnoremap <silent><expr>' cmd 'itab#doaction(''' . substitute(cmd, "'", "''", 'g') . ''')'
	endif
endfor

nnoremap <silent> = :set opfunc=itab#equalop<cr>g@
nnoremap <silent><expr> == ":left\<cr>" . itab#doaction("==")
vnoremap <silent><expr> = ":left\<cr>gv" . itab#doaction("=")
