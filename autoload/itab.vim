" Intelligent Indent

fun! itab#equalop(type)
	let l:action = '='

	if a:type == "char"
		exec 'silent normal!' '`[v`]' . itab#ndoaction('=')
	elseif a:type == "line"
		exec 'silent normal!' '`[V`]' . itab#ndoaction('=')
	elseif a:type == "block"
		exec 'silent normal!' "`[\<c-v>`]" . itab#ndoaction('=')
	endif
endfun

fun! itab#doaction(action)
	if &expandtab
		return a:action
	endif

	let l:big_ident_sz = 80

	let l:tskeep = &tabstop
	let l:swkeep = &shiftwidth

	let &tabstop = l:big_ident_sz
	let &shiftwidth = l:big_ident_sz

	return a:action . "\<c-r>=itab#restore(" . l:tskeep . "," . l:swkeep . ")\<cr>"
endfun

fun! itab#ndoaction(action)
	if &expandtab
		return a:action
	endif

	let l:big_ident_sz = 80

	let l:tskeep = &tabstop
	let l:swkeep = &shiftwidth

	let &tabstop = l:big_ident_sz
	let &shiftwidth = l:big_ident_sz

	return a:action . ":\<c-e>\<c-u>call itab#restore(" . l:tskeep . "," . l:swkeep . ")\<cr>"
endfun

fun! itab#restore(a, b)
	let &tabstop = a:a
	let &shiftwidth = a:b

	return ''
endfun
