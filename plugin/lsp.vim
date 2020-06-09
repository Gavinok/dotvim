" File: lsp.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 19 May 2020 08:52:09 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" vim-lsp settings
" if !exists("g:mymu_enabled")
	finish
" endif
" LSP {{{1 "
if exists('*job_start') || exists('*jobstart')
	nmap <script> <silent> <leader>V :call dotvim#ToggleLocationlist()<CR>
	let g:lsp_textprop_enabled = 1
	let g:lsp_virtual_text_enabled = 1
	let g:lsp_signs_enabled = 0
	let g:lsp_diagnostics_echo_cursor = 1
	if executable('pyls')
		" pip install python-language-server
		au User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': {server_info->['pyls']},
					\ 'whitelist': ['python'],
					\ })

	endif
	if executable('ccls')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'ccls',
					\ 'cmd': {server_info->['ccls']},
					\ 'initialization_options': {
					\ 'cache': {'directory': '/tmp/ccls/cache' },
					\ 'completion': {'detailedLabel': v:false}
					\ },
					\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
					\ })

	elseif executable('clangd')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'clangd',
					\ 'cmd': {server_info->['clangd', '--background-index']},
					\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
					\ })
	endif
	if executable('gopls')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'gopls',
					\ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
					\ 'whitelist': ['go'],
					\ })
		autocmd BufWritePre *.go "silent! LspDocumentFormatSync<CR>"
	endif
	if executable('typescript-language-server')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'javascript support using typescript-language-server',
					\ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
					\ 'root_uri': { server_info->lsp#utils#path_to_uri
					\(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
					\ 'whitelist': ['javascript', 'javascript.jsx']
					\ })
	endif
	if executable('bash-language-server')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'bash-language-server',
					\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
					\ 'whitelist': ['sh'],
					\ })
	endif
	if executable('java') && executable('jdtls')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'jdt.ls',
					\ 'cmd': {server_info->["jdtls"]},
					\ 'whitelist': ['java'],
					\ })
	endif
	if executable('efm-langserver')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'efm-langserver',
					\ 'cmd': {server_info->['efm-langserver', '-c=/home/gavinok/.vim/efm/config.yaml']},
					\ 'whitelist': ['vim', 'sh'],
					\ })
	endif
	if executable('texlab')
		au User lsp_setup call lsp#register_server({ 
					\ 'name': 'texlab',
					\ 'cmd': {server_info->['texlab']},
					\ 'root_uri': { server_info->lsp#utils#path_to_uri
					\ (lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
					\ 'initialization_options': {"diagnostics": "true"}, 
					\ 'whitelist': ['plaintex', 'tex'], 
					\ })
	endif
	function! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		setlocal signcolumn=auto
		nmap <buffer> gd <plug>(lsp-definition)
		nmap <buffer> gR <plug>(lsp-rename)
		nmap <buffer> K <plug>(lsp-hover)
		nmap ]l <plug>(lsp-next-error)
		nmap [l <plug>(lsp-previouse-error)
		let g:mucomplete#completion_delay = 100
		let g:mucomplete#reopen_immediately = 0
		" refer to doc to add more commands
	endfunction

	augroup lsp_install
		au!
		" call s:on_lsp_buffer_enabled only for languages that has the server registered.
		autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	augroup END
endif
" 1}}} LSP
