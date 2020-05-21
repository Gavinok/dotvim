" File: mermaid.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 05 Jan 2020 03:50:44 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" mermaid ftplugin

augroup Mermaid
	autocmd!
	autocmd BufRead,BufWritePre *.mmd silent call dotvim#FormatFile()
augroup end

