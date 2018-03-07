" Intelligent Indent

" The aim of this script is to be able to handle the mode of tab usage which
" distinguishes 'indent' from 'alignment'.  The idea is to use <tab>
" characters only at the beginning of lines.
"
" This means that an individual can use their own 'tabstop' settings for the
" indent level, while not affecting alignment.
"
" The one caveat with this method of tabs is that you need to follow the rule
" that you never 'align' elements that have different 'indent' levels.
"
" options:
"
" g:itab#disable_maps
"   disable tab insertion and deletion mappings
"
" g:itab#clear_trails
"   delete trailing spaces/tabs when going to a new line

fun! itab#delete_trails(origin)
	" origin is what caused this call
	" 1: escape
	" 2: enter

	let delete_trail_opt = exists('itab#clear_trails') && itab#clear_trails
	let current_line = getline('.')

	if delete_trail_opt
		let trail_len = len(matchstr(current_line, '\s*$'))
		return repeat("\<bs>", trail_len)
	endif

	let blank_line = match(current_line, '^\s\+$') != -1
	let cpo_delete = &cpo !~# 'I'
	let last_align = exists('b:itab_lastalign') && (line('.') == b:itab_lastalign)

	let do_delete = 0

	if a:origin == 1
		let do_delete = blank_line
	elseif a:origin == 2
		let do_delete = cpo_delete && blank_line && last_align
	endif

	return do_delete ? "^\<c-d>" : ''
endfun

" Insert a smart tab.
fun! itab#tab()
	if strpart(getline('.'), 0, col('.') - 1) =~'^\s*$'
		return "\<Tab>"
	endif

	return repeat(' ', shiftwidth() - (virtcol('.') - 1) % shiftwidth())
endfun

" Check the alignment of line.
" Used in the case where some alignment whitespace is required .. like for unmatched brackets.
" It does this by using a massive tabstop and shiftwidth
fun! itab#align(line)
	if &expandtab || !(&autoindent || &indentexpr || &cindent)
		return ''
	endif

	let big_ident_sz = 80

	let pos = getpos('.')
	let textoff = len(matchstr(getline(a:line), '\s*\zs.*\%' . col('.') . 'c'))

	let pos[1] = a:line

	let tskeep = &tabstop
	let swkeep = &shiftwidth

	if a:line == line('.')
		let b:itab_lastalign = a:line
	elseif exists('b:itab_lastalign')
		unlet b:itab_lastalign
	endif

	" make tabs big
	let &ts = big_ident_sz
	let &sw = big_ident_sz

	let inda = -1

	if &indentexpr != ''
		try
			let v:lnum = a:line
			sandbox exe 'let inda=' . &indentexpr
			if inda == -1
				let inda = indent(a:line-1)
			endif
		catch
			" Ignore errors, silently fallback
			" Some preinstalled indentexpr's (e.g. javascript)
			" have errors, so we just ignore it
		endtry
	endif

	" fallback to builtins if indentexpr fails
	if inda == -1
		if &cindent
			let inda = cindent(a:line)
		elseif &lisp
			let inda = lispindent(a:line)
		elseif &autoindent
			let inda = indent(a:line)
		elseif &smarttab
			" Vim's behaviour of smarttab works better
			return ''
		else
			let inda = 0
		endif
	endif

	" restore tab size
	let &ts=tskeep
	let &sw=swkeep

	call setpos('.', pos)
	if inda == 0
		return "^\<c-d>"
	endif
	" no of tabs
	let indatabs=inda / big_ident_sz
	" no of spaces
	let indaspace=inda % big_ident_sz

	" indent only: move to end of indent (and make vim think we're there)
	" indent + text: move to original cursor position
	let mov_seq = "\<esc>^a"
	if getline(a:line) !~ '^\s*$'
		let mov_seq = repeat("\<right>", textoff)
	endif

	return "\<home>^\<c-d>" . repeat("\<tab>", indatabs) . repeat(' ', indaspace) . mov_seq
endfun

" Get the spaces at the end of the indent correct.
" This is trickier than it should be, but this seems to work.
fun! itab#cr()
	return itab#delete_trails(2) . "\<CR>\<c-r>=itab#align(line('.'))\<CR>"
endfun

fun! itab#redo_indent(type, ...)
	let ln   = line("'[")
	let lnto = line("']")

	if exists('a:1') && a:1 ==# 1
		let ln   = line("'<")
		let lnto = line("'>")
	endif

	" Do the original align
	silent exec 'normal! g' . ln . 'Vg' . lnto . '='

	" Then check the alignment.
	while ln <= lnto
		if getline(ln) =~ '\S'
			" Only indent if line is non-empty
			exec 'normal! ' . ln . 'ggA' . itab#align(ln)
		endif
		let ln += 1
	endwhile

	return ''
endfun
