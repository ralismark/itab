" Intelligent Indent

inoremap <silent><expr> <Plug>ItabEsc itab#delete_trails(1) . "\<esc>"
inoremap <silent><expr> <Plug>ItabTab itab#tab()
" Needs to handle creating new line before we indent
inoremap <silent><expr> <Plug>ItabCr itab#delete_trails(2) . "\<CR>\<c-r>=itab#align(line('.'))\<CR>"
inoremap <silent><expr> <Plug>ItabRealign itab#align(line('.'))

" All below here is maps
if exists('itab#disable_all_maps') && itab#disable_all_maps
	finish
end

imap <Esc> <Plug>ItabEsc

if !exists('itab#disable_maps') || !itab#disable_maps
	if mapcheck("\<tab>", 'i') == ""
		imap <tab> <Plug>ItabTab
	endif
endif

imap <cr> <Plug>ItabCr
nmap <silent> o o<Plug>ItabRealign
nmap <silent> O O<Plug>ItabRealign
nmap <silent> S S<Plug>ItabRealign
nmap <silent> cc cc<Plug>ItabRealign

nnoremap <silent> = :set opfunc=itab#redo_indent<cr>g@
nnoremap <silent> == i<c-r>=itab#align(line('.'))<cr><esc>l
vnoremap <silent> = :<c-u>call itab#redo_indent('', 1)<cr>
