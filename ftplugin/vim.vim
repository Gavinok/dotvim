" File: vim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sat 04 Jan 2020 02:53:18 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for vimscript
" used by 
autocmd Filetype vim let b:helpful = 1
autocmd Filetype vim setlocal foldmethod=marker
autocmd FileType vim nmap <buffer> `<CR> :Runtime<CR>
autocmd FileType vim nmap <buffer><silent> <leader>V :Messages<CR>
autocmd FileType vim xmap <buffer><silent> <CR> :<C-U>call dotvim#RunVimScript(1)<CR>
autocmd FileType vim nnoremap <buffer><silent> gd  :call lookup#lookup()<CR>
autocmd FileType vim nnoremap <buffer><silent> <C-T>  :call lookup#pop()<CR>
autocmd FileType vim nnoremap <buffer><silent> <leader>cc :PlugInstall<CR>
autocmd FileType vim nnoremap <buffer><silent> <leader>cl :PlugClean<CR>
autocmd BufRead *.vimrc nnoremap <buffer><silent> gx yi':!<C-R>=dotvim#Open()<CR> https://github.com/<C-r>0<CR>
