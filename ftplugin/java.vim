" File: java.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 23 Jan 2020 08:32:57 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" ftplugin for java files
if executable('jdtls')

	" Turn the invalid java.apply.workspaceEdit commands into an edit
	" action which complies with the LSP spec
	function! s:fixEdits(actions) abort
		return map(a:actions, function('<SID>fixEdit'))
	endfunction

	function! s:fixEdit(idx, maybeEdit) abort
		if !has_key(a:maybeEdit, 'command') ||
					\ !has_key(a:maybEdit.command, 'command') ||
					\ a:maybeEdit.command.command !=# 'java.apply.workspaceEdit'
			return a:maybeEdit
		endif
		return {
					\ 'edit': a:maybeEdit.command.arguments[0],
					\ 'title': a:maybeEdit.command.title}
	endfunction
	let b:lsc_config = {
				\ 'name': 'jdtls',
				\ 'command': 'jdtls',
				\ 'response_hooks': {
				\ 	'textDocument/codeAction': function('<SID>fixEdits'),
				\  },
				\}
	if exists('g:mylsc_enabled')
		call RegisterLanguageServer('java', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif
setlocal include=^#\s*import
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.java
set suffixes+=.class
