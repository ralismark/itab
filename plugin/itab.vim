" Intelligent Indent


" note: indentkeys and cinkeys partially break from the indents

inoremap <expr> <Esc> itab#delete_trails(1) . "\<esc>"

if !exists('itab#disable_maps') || !itab#disable_maps
	inoremap <silent> <expr> <tab> itab#tab()
endif

inoremap <silent> <expr> <cr> itab#cr()
nnoremap <silent> o o<c-r>=itab#align(line('.'))<cr>
nnoremap <silent> O O<c-r>=itab#align(line('.'))<cr>
nnoremap <silent> S S<c-r>=itab#align(line('.'))<cr>
nnoremap <silent> cc cc<c-r>=itab#align(line('.'))<cr>

nnoremap <silent> = :set opfunc=itab#redo_indent<cr>g@
nnoremap <silent> == i<c-r>=itab#align(line('.'))<cr><esc>l
vnoremap <silent> = :<c-u>call itab#redo_indent('', 1)<cr>
