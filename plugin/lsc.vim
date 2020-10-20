" File: lsc.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 19 May 2020 08:49:22 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" vim-lsc settings
" LSC {{{2 "
if !exists("g:mylsc_enabled")
	finish
endif
if exists('*job_start') || exists('*jobstart')
	let g:mucomplete#completion_delay = 200
	let g:mucomplete#reopen_immediately = 0
	nmap <leader>V :LSClientAllDiagnostics<CR>
	let g:lsc_enable_autocomplete = v:false
	let g:lsc_auto_map = {
				\ 'GoToDefinition': 'gd',
				\ 'GoToDefinitionSplit': ['<C-W>d', '<C-W><C-D>'],
				\ 'FindReferences': 'gr',
				\ 'NextReference': '<leader>*',
				\ 'PreviousReference': '<leader>#',
				\ 'FindImplementations': 'gI',
				\ 'FindCodeActions': 'ga',
				\ 'ShowHover': v:true,
				\ 'DocumentSymbol': 'go',
				\ 'WorkspaceSymbol': 'gz',
				\ 'SignatureHelp': 'gs',
				\}
endif
" 2}}} LSC

