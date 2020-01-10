" File: tex.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 10 Jan 2020 02:08:57 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for tex files

set iskeyword+=\\

if executable('chktex')
	compiler chktex
	augroup CHKTEX
		autocmd!
		autocmd BufWritePost <buffer> Make
	augroup end
endif
