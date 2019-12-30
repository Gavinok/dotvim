" File: sh.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 09 Dec 2019 01:39:13 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" shell script filetype plugin
" a simple omni complete for shell scripts
setlocal foldmethod=indent
function! OmniShell(findstart, base) abort
	echo a:base
	if a:findstart
		let l:line = getline('.')
	else
    	let s:res = getcompletion(a:base, 'shellcmd')
		return {'words': s:res, 'refresh': 'always'}
	endif
endfunction
