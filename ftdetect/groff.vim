" File: groff.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 05 Mar 2020 12:50:45 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" recognize ms files as groff

autocmd BufRead,BufNewFile *.ms setlocal filetype=groff
