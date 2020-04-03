" File: python.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 13 Jan 2020 03:25:31 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for python

if executable('pyls')
	let b:lsc_config = 'pyls'
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('python', b:lsc_config)
	endif
endif

function! Pydoc()
	"code
	exec 'new|read !pydoc '. expand('<cword>')
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	setfiletype man
endfunction
command! -nargs=0 Pydoc call Pydoc()
