" File: html.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 06 Dec 2019 05:24:40 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" filetype settings for html
" dont forget to use surround when couraounding tags

set matchpairs+=<:>
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal smartindent

augroup HTML
	autocmd!
	autocmd BufRead,BufWritePre *.html silent call dotvim#FormatFile()
augroup end
