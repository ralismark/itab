" Intelligent Indent

fun! itab#equalop(type)
	let l:action = '='

	" remove indent
	'[,']left

	if a:type == "char"
		exec 'silent normal!' '`[v`]' . itab#doaction('=')
	elseif a:type == "line"
		exec 'silent normal!' '`[V`]' . itab#doaction('=')
	elseif a:type == "block"
		exec 'silent normal!' "`[\<c-v>`]" . itab#doaction('=')
	endif
endfun

fun! itab#prepare()
	let l:big_ident_sz = 80

	" TODO make this work with nested actions

	let b:itab_save = {
	\ 'ts': &l:tabstop,
	\ 'sw': &l:shiftwidth,
	\ 'wrap': &l:wrap,
	\ 'wsv_pre': winsaveview(),
	\ }

	let &l:tabstop = l:big_ident_sz
	let &l:shiftwidth = 0
	let &l:wrap = 0

	let b:itab_save.wsv_pre_after = winsaveview()
endfun

fun! itab#restore()
	let wsv_pre = b:itab_save.wsv_pre
	let wsv_pre_after = b:itab_save.wsv_pre_after
	let wsv_post = winsaveview()

	let &l:tabstop = b:itab_save.ts
	let &l:shiftwidth = b:itab_save.sw
	let &l:wrap = b:itab_save.wrap

	" Stop weird screen movement
	let out_wsv = winsaveview()
	let out_wsv.leftcol = wsv_pre.leftcol

	call winrestview(out_wsv)

	unlet b:itab_save

	return ''
endfun

fun! itab#doaction(action)
	if &expandtab
		return a:action
	endif

	call itab#prepare()

	return a:action . "\<Cmd>call itab#restore()\<cr>"
endfun
