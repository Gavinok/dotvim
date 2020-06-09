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
	if exists('g:mymu_enabled')
		call RegisterLanguageServer('sh', b:lsc_config)
	endif
endif
setlocal foldmethod=indent

" formatting
if executable('shfmt')
  let &l:formatprg='shfmt -i ' . &l:shiftwidth . ' -ln posix -sr -ci -s'
endif

" force Man to be used along side lsc
nnoremap <buffer> K :Man <c-r><c-w><CR>

" allow for commands with - in the name
set iskeyword+=-

" use bash to create completion
if executable('/bin/bash')
	let ogshell=&shell
	set shell=/bin/bash

	let s:dict_compl = expand("$XDG_CACHE_HOME/vim/dict_compl/sh")
	call mkdir(s:dict_compl, "p")

	call system("compgen -c > ".s:dict_compl."/commands")
	call system("env | cut -f 1 -d= > ".s:dict_compl."/env_variables")

	exec 'setlocal dict+=' . s:dict_compl."/commands"
	exec 'setlocal dict+=' . s:dict_compl."/env_variables"

	execute 'set shell=' . ogshell
endif
