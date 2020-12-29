" File: json.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 09 Jan 2020 02:55:16 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" ftplugin for json files
if executable('python')
	nmap <buffer> gq :%!python -m json.tool<CR>
endif
