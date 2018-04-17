" Intelligent Indent

fun! itab#equalop(type)
	let l:action = '='

	" remove indent
	'[,']left

	if a:type == "char"
		exec 'silent normal!' '`[v`]' . itab#ndoaction('=')
	elseif a:type == "line"
		exec 'silent normal!' '`[V`]' . itab#ndoaction('=')
	elseif a:type == "block"
		exec 'silent normal!' "`[\<c-v>`]" . itab#ndoaction('=')
	endif
endfun

fun! itab#prepare()
	let l:big_ident_sz = 80

	" TODO make this work with nested actions

	let b:itab_save = {
	\ 'ts': &l:tabstop,
	\ 'sw': &l:shiftwidth,
	\ 'wrap': &l:wrap,
	\ }

	let &l:tabstop = l:big_ident_sz
	let &l:shiftwidth = 0
	let &l:wrap = 0
endfun

fun! itab#restore()
	let &l:tabstop = b:itab_save.ts
	let &l:shiftwidth = b:itab_save.sw
	let &l:wrap = b:itab_save.wrap

	unlet b:itab_save

	return ''
endfun

fun! itab#doaction(action)
	if &expandtab
		return a:action
	endif

	call itab#prepare()

	return a:action . "\<c-r>=itab#restore()\<cr>"
endfun

fun! itab#ndoaction(action)
	if &expandtab
		return a:action
	endif

	call itab#prepare()

	return a:action . ":\<c-e>\<c-u>call itab#restore()\<cr>"
endfun
