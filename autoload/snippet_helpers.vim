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

function! snippet_helpers#Argmaker(prearg, value_indicator)
	"code
	let placeholder = a:prearg . g:minisnip_startdelim . g:minisnip_enddelim
	let g:count =search(a:value_indicator, 'bp', getcurpos()[1])
	if g:count != 0
		return placeholder
	else
		return ''
	endif
endfunction

function! snippet_helpers#FoldManage(on, ret)
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

function! snippet_helpers#StoreElement(desc, placeholder, variable)
	exec 'cmap ' . g:minisnip_trigger . ' <CR>'
	let sniptemp = input(a:desc, '', 'tag')
	if sniptemp ==# '' | let sniptemp = a:placeholder | endif
	exec 'let ' . a:variable . ' = sniptemp'
	exec 'cunmap ' . g:minisnip_trigger
	return sniptemp
endfunction
