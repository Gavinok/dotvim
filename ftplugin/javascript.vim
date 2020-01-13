" File: javascript.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 13 Jan 2020 03:26:31 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for javascript
if executable('typescript-language-server')
	let b:lsc_config = {
				\ 'name': 'javascript support using typescript-language-server',
				\ 'command': 'typescript-language-server --stdio',
				\    'message_hooks': {
				\        'initialize': {
				\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(finddir('.git/', expand('%:p') . ';'), ':p:h'))}
				\        },
				\    },
				\}
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('javascript', b:lsc_config)
	endif
endif

