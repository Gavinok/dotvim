inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup minisnip_integ#vim_lsc
	autocmd!
	autocmd CompleteDone * call s:Snipmaker()
augroup END

function! s:Snipmaker()
	if empty(v:completed_item)
		return
	endif

	try
		let l:user_data = json_decode(v:completed_item.user_data)
	catch /.*/
		let l:user_data = {}
	endtry

	let sub = match(v:completed_item.word, '\${[0-9]\(:\w.\{-}\)\?}')
	if sub > 0
		let l:line = getline('.')
		let l:curpos = getcurpos()
		let l:completed_item = copy(v:completed_item)

		" remove completed string.
		let l:start = {
					\     'line': l:curpos[1] - 1,
					\     'character': (l:curpos[2] + l:curpos[3]) - strlen(l:completed_item.word) - 1
					\ }

		" echoerr l:completed_item.word
		" move to complete start position.
		call cursor([l:start.line + 1, l:start.character + 1])
		" part of snipp
		let rep = substitute(l:completed_item.word, '\${[1-9]\(:\w.\{-}\)\?}', g:minisnip_startdelim.g:minisnip_enddelim, 'g')
		" end of snippet
		let rep = substitute(rep, '\${\?0\(:\w.\{-}\)\?}\?', g:minisnip_finalstartdelim.g:minisnip_finalenddelim, 'g')
		" new lines
		let line = substitute(getline('.'), '\M'.l:completed_item.word,rep, 'g')

		call setline(getcurpos()[1], line)
		if mode() =~# '^i.*'
			call feedkeys("\<Plug>(minisnip)", 'i')
		endif
		return line
	endif
endfunction
