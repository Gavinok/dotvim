" File: qf.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 16 Dec 2019 09:56:58 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" quickfix specific settings

" only want in quickfix
set nobuflisted

nmap <buffer> <TAB> za
nmap <buffer> p 0:pedit <C-R><C-F><CR>

setlocal foldmethod=expr
setlocal foldexpr=matchstr(getline(v:lnum),'^[^\|]\\+')==#matchstr(getline(v:lnum+1),'^[^\|]\\+')?1:'<1'

" Quit QuickFix window along with source file window
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif
