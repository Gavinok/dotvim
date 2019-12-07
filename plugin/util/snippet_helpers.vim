" File: snippet_helpers.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 02 Dec 2019 10:10:49 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" helper funcitons used in my minisnips

function! Argmaker(prearg)
	"code
	let placeholder = a:prearg . g:minisnip_startdelim . g:minisnip_enddelim
	let g:count =search('%\l', 'bp', getcurpos()[1])
	if g:count != 0
		return placeholder
	else
		return ''
	endif
endfunction
