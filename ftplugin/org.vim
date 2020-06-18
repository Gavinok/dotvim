" File: dotoo.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 18 Nov 2019 02:22:05 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
" Description: 
" settings for making dotoo act like orgmode

runtime! ftplugin/dotoo.vim

function! ChangeTodo()
	normal! 0
	if search(join(g:org_state_keywords, '\|'), 'W',getline('.'))
		normal! ciw
		call feedkeys("a\<C-X>\<C-O>", 'i')
	else
		call search('\* ', 'W',getline('.'))
		exec 'normal! f '
		call feedkeys("a\<C-X>\<C-O>", 'i')
	endif
endfunction
nmap <buffer> cit :call ChangeTodo()<CR>
