" File: css.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 12 Dec 2019 10:19:19 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" css file settings
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal smartindent
augroup CSS
	autocmd BufRead,BufWritePre *.css silent call dotvim#FormatFile()
augroup end
