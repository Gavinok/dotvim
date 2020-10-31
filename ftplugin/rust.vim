" File: rust.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 23 Jan 2020 09:01:21 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for rust
if executable('rls')
	let b:lsc_config = {
				\  'command': 'rls',
				\  'workspace_config': {
				\      'clippy_preference': 'on',
				\  },
				\}

	if exists('g:mylsc_enabled')
		call RegisterLanguageServer('rust', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif
