" File: dotoo.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 18 Nov 2019 02:22:05 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
" Description: 
" settings for making dotoo act like orgmode

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nowrap
setlocal errorformat="%f",\ line\ %l:\ %m
setlocal makeprg=compiler\ %
inoremap <buffer> <c-\> $$<c-o>i
nnoremap <buffer><silent> ]] :call CustomSections('down', '^\* ')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', '^\* ')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', '^\* ')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', '^\* ')<CR>
let g:org_date_format='%Y-%m-%d %a %H:%M'
execute '1SpeedDatingFormat ' . g:org_date_format
function! ChangeTodo()
	normal! 0
	if search('TODO\|DONE', 'W',getline('.'))
		normal! ciw
		call feedkeys("a\<C-X>\<C-O>", 'i')
	else
		call search('\* ', 'W',getline('.'))
		exec 'normal! f '
		call feedkeys("a\<C-X>\<C-O>", 'i')
	endif
endfunction
nmap <buffer> cit :call ChangeTodo()<CR>

