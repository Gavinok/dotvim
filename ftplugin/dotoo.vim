" File: dotoo.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Thu 11 Jun 2020 02:55:42 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" dotoo ftplugin
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nowrap
setlocal errorformat="%f",\ line\ %l:\ %m
setlocal makeprg=compiler\ %
setlocal concealcursor=n
nnoremap <buffer><silent> ]] :call CustomSections('down', '^\* ')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', '^\* ')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', '^\* ')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', '^\* ')<CR>

inoreabbrev todo TODO
inoreabbrev done DONE

let g:org_time='%H:%M'
let g:org_date='%Y-%m-%d %a'
let g:org_date_format=g:org_date.' '.g:org_time

if exists("g:loaded_speeddating")
	execute '1SpeedDatingFormat ' . g:org_date
	execute '1SpeedDatingFormat ' . g:org_date_format
endif
