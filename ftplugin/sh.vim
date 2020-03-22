" File: sh.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 09 Dec 2019 01:39:13 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" shell script filetype plugin
" a simple omni complete for shell scripts

if executable('efm-langserver')
	let b:lsc_config = {
				\ 'name': 'efm-langserver',
				\ 'command': 'efm-langserver -c='.$HOME.'/.vim/extra/efm/config.yaml',
				\ 'suppress_stderr': v:true,
				\}
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('sh', b:lsc_config)
	endif
endif
setlocal foldmethod=indent

" force Man to be used along side lsc
nnoremap K :Man <c-r><c-w><CR>

if filereadable(expand('~/.cache/dmenu_run'))
	 setlocal dict=~/.cache/dmenu_run
endif
