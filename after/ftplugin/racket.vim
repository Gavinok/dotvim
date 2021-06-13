" File: racket.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 16 Oct 2020 09:29:01 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" ftplugin for racket
if executable('racket')
	let b:lsc_config = {
				\ 'command': 'racket -l racket-langserver',
				\}

	if exists('g:mylsc_enabled')
		call RegisterLanguageServer('racket', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif

 " No tabs!
setlocal expandtab

setlocal lisp
setlocal autoindent
