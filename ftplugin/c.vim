" File: c.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 13 Jan 2020 03:27:01 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for c
if executable('ccls')
	let b:lsc_config = {
				\ 'command': 'ccls',
				\ 'suppress_stderr': v:true,
				\ 'message_hooks': {
				\    'initialize': {
				\       'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
				\       'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
				\    },
				\   'textDocument/didOpen': {'metadata': {'extraFlags': ['-Wall']}},
				\ },
				\}
	if exists('g:mymu_enabled')
		if !exists('s:initialized')
			call RegisterLanguageServer('c', b:lsc_config)
			let s:initialized = v:true
		endif
	endif
endif
setlocal omnifunc=lsc#complete#complete
" setlocal path+=/usr/include/
