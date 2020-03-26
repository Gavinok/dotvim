" File: filetype.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 06 Mar 2020 03:28:22 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" filetype detection

if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	" autocmd! BufNewFile,BufRead *.org    setlocal filetype=dotoo
	autocmd! BufRead,BufNewFile *.ms     setlocal filetype=groff
	autocmd! BufRead,BufNewFile *.mmd    setlocal filetype=mermaid
	autocmd! Bufread,Bufnewfile */snip/* setlocal filetype=minisnip
	autocmd! BufRead,BufNewFile *.h      setlocal filetype=c
augroup END
