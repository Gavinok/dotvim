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
" nnoremap <buffer><silent> <leader>nr :call NarrowCodeblock()<CR>
" command! -nargs=1 Ngrep vimgrep "<args>" ~/Dropbox/Documents/org/**/*.org
" nmap <buffer> <leader><leader> :Ngrep 
" TODO
let g:org_date_format='%Y-%m-%d %a %H:%M'
iab <expr><buffer> sch printf('SCHEDULED: <%s>', strftime(g:org_date_format))
iab <expr><buffer> cls printf('CLOSED: [%s]', strftime(g:org_date_format))
nmap <buffer> cit V:s/TODO\\|DONE//g<space>|<space>nohlsearch<S-left><S-left>
