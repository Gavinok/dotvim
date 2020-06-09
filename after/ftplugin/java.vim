" File: java.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 23 Jan 2020 08:32:57 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for java files
if exists('g:mymu_enabled')
	setlocal omnifunc=lsc#complete#complete
elseif exists('g:JavaComplete_PluginLoaded')
    setlocal omnifunc=javacomplete#Complete
endif
