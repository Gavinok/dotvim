" File: root.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 29 Dec 2019 01:11:22 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" simple implementation of Rooter

" Diy Rooter {{{1
function! FindRootDirectory()
	if !filereadable('Makefile') && !filereadable('makefile')
		let root = systemlist('git rev-parse --show-toplevel')[0]
		if v:shell_error
			return '.'
		endif
		return root
	endif
	return expand('%:p:h')
endfunction

function! RootMe()
	let root = FindRootDirectory()
	if root ==# ''
	endif
	execute 'lcd' . root
	echo 'Changed directory to: '.root
endfunction
" 1}}} "Diy Rooter

command! Root call RootMe()
" set directory to root before following tags
nnoremap <c-]> :call FindRootDirectory()<CR>:tag <c-r><c-w><CR>
