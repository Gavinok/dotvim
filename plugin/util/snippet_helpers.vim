" File: snippet_helpers.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 02 Dec 2019 10:10:49 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" helper funcitons used in my minisnips
" snippet support for surround
let g:surround_insert_tail = "{{++}}"

function! Argmaker(prearg, value_indicator)
	"code
	let placeholder = a:prearg . g:minisnip_startdelim . g:minisnip_enddelim
	let g:count =search(a:value_indicator, 'bp', getcurpos()[1])
	if g:count != 0
		return placeholder
	else
		return ''
	endif
endfunction

function! FoldManage(on, ret)
	if !exists('b:oldfold')
		let b:oldfold = &foldlevel
	endif
	if a:on == 0
		setlocal foldmethod=manual
		let w:oldfold = &foldmethod
	else
		let &foldmethod=w:oldfold
	endif
	return a:ret
endfunction

function! StoreElement(desc, placeholder, variable)
	exec 'cmap ' . g:minisnip_trigger . ' <CR>'
	let sniptemp = input(a:desc, '', 'tag')
	if sniptemp ==# '' | let sniptemp = a:placeholder | endif
	exec 'let ' . a:variable . ' = sniptemp'
	exec 'cunmap ' . g:minisnip_trigger
	return sniptemp
endfunction


inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup minisnip_integ#vim_lsc
	autocmd!
	autocmd CompleteDone * call Snipmaker()
augroup END

function! Snipmaker()
	if empty(v:completed_item)
		return
	endif

	try
		let l:user_data = json_decode(v:completed_item.user_data)
	catch /.*/
		let l:user_data = {}
	endtry

	" if !empty(l:user_data)  || has_key(l:user_data, 'snippet')
	" 	echoerr l:user_data.snippet
	" elseif has_key(l:user_data, 'snippet_trigger')
	" 	echoerr l:user_data.snippet_trigger
	" endif

	let sub = match(v:completed_item.word, '\${[0-9]\(:\w.\{-}\)\?}')
	if sub > 0
		let l:line = getline('.')
		let l:curpos = getcurpos()
		let l:completed_item = copy(v:completed_item)

		" " <BS> or <C-h>
		" if strlen(getline('.')) < strlen(l:line)
		" 	return ''
		" endif

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
		" let rep = substitute(rep, " ", '\n', 'g') 
		let line = substitute(getline('.'), '\M'.l:completed_item.word,rep, 'g')

		call setline(getcurpos()[1], line)
		if mode() =~# '^i.*'
			call feedkeys("\<Plug>(minisnip)", 'i')
		endif
		return line
	endif
endfunction
