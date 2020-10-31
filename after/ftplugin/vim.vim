" File: vim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sat 04 Jan 2020 02:53:18 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for vimscript
" used by 
if exists('g:loaded_lsc')
	setlocal omnifunc=lsc#complete#complete
endif
