" File: vim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 29 Dec 2019 11:09:26 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" vim specific settings
let b:helpful = 1
setlocal foldmethod=marker
nmap <buffer> `<CR> :Runtime<CR>
nmap <buffer><silent> <leader>V :Messages<CR>
xmap <buffer><silent> <CR> :<C-U>call dotvim#RunVimScript(1)<CR>
nnoremap <buffer><silent> gd  :call lookup#lookup()<CR>
nnoremap <buffer><silent> <C-T>  :call lookup#pop()<CR>
nnoremap <buffer><silent> <leader>cc :PlugInstall<CR>
nnoremap <buffer><silent> <leader>cl :PlugClean<CR>

