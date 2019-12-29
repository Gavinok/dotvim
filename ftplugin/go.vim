" File: go.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 04 Dec 2019 08:37:46 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" filetype plugin for go

setlocal makeprg=go\ build

function! Godoc()
	"code
	if exists('g:autoloaded_dispatch')
		exec 'silent Dispatch go doc '. expand('<cword>')
	else
		exec 'new|read !go doc '. expand('<cword>')
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
		setfiletype man
	endif
endfunction
command! -nargs=0 Godoc call Godoc()

setl keywordprg=:Godoc

" use gofmt for formatting
nnoremap <buffer><silent> gq :call dotvim#Gofmt()<CR>

" make ]] and [[ great again
nnoremap <buffer><silent> ]] :call CustomSections('down', ')\s*\zs{\s*\ze$')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', ')\s*\zs{\s*\ze$')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', ')\s*\zs{\s*\ze$')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', ')\s*\zs{\s*\ze$')<CR>
