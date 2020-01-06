" File: mermaid.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 05 Jan 2020 03:49:46 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftdetect for mermaid
autocmd BufRead,BufNewFile *.mmd setlocal filetype=mermaid
