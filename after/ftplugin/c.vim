" File: c.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 13 Jan 2020 03:27:01 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" ftplugin for c
if exists('g:mymu_enabled')
	setlocal omnifunc=lsc#complete#complete
endif
