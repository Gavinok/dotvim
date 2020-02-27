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
				\ 'command': 'efm-langserver -c='.$HOME.'/.vim/extra/efm/config.yaml -log '.$HOME.'/efm-langserver.log',
				\ 'suppress_stderr': v:true,
				\}
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('sh', b:lsc_config)
	endif
endif
setlocal foldmethod=indent
function! OmniShell(findstart, base) abort
	echo a:base
	if a:findstart
		let l:line = getline('.')
	else
		let s:res = getcompletion(a:base, 'shellcmd')
		return {'words': s:res, 'refresh': 'always'}
	endif
endfunction
