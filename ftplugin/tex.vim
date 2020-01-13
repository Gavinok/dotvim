" File: tex.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 10 Jan 2020 02:08:57 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for tex files

if executable('texlab')
	let b:lsc_config = {
				\ 'name': 'texlab',
				\ 'command': 'texlab',
				\ 'log_level': -1,
				\    'message_hooks': {
				\        'initialize': {
				\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(finddir('.git/', expand('%:p') . ';'), ':p:h'))},
				\            'initializationOptions': {'diagnostics': 'true'},
				\        },
				\    },
				\}
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('tex', b:lsc_config)
	endif
endif

set iskeyword+=\\

if executable('chktex')
	compiler chktex
	augroup CHKTEX
		autocmd!
		autocmd BufWritePost <buffer> Make
	augroup end
endif
