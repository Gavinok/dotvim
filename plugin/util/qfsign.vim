" File: qfsign.vim
" Auther: Joseph R. Nosi https://gist.github.com/BoltsJ/5942ecac7f0b0e9811749ef6e19d2176
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sat 07 Dec 2019 03:17:58 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" allows sign colom for quickfix errors
if exists('g:loaded_qfsign')
  finish
endif
let g:loaded_qfsign=1

sign define QFErr texthl=QFErrMarker text=E
sign define QFWarn texthl=QFWarnMarker text=W
sign define QFInfo texthl=QFInfoMarker text=I

augroup qfsign
autocmd!
autocmd QuickFixCmdPre [^l]* call s:clear_signs()
autocmd QuickFixCmdPost [^l]* call s:place_signs()
augroup END

let s:sign_count = 0

function! s:place_signs() abort
  let l:errors = getqflist()
  for l:error in l:errors
    if l:error.bufnr < 0
      continue
    endif
    let s:sign_count = s:sign_count + 1
    if l:error.type ==# 'E'
      let l:err_sign = 'sign place ' . s:sign_count
            \ . ' line=' . l:error.lnum
            \ . ' name=QFErr'
            \ . ' buffer=' . l:error.bufnr
    elseif l:error.type ==# 'W'
      let l:err_sign = 'sign place ' . s:sign_count
            \ . ' line=' . l:error.lnum
            \ . ' name=QFWarn'
            \ . ' buffer=' . l:error.bufnr
    else
      let l:err_sign = 'sign place ' . s:sign_count
            \ . ' line=' . l:error.lnum
            \ . ' name=QFInfo'
            \ . ' buffer=' . l:error.bufnr
    endif
    silent! execute l:err_sign
  endfor
endfunction

function! s:clear_signs() abort
  while s:sign_count > 0
    execute 'sign unplace ' . s:sign_count
    let s:sign_count = s:sign_count - 1
  endwhile
  redraw!
endfunction
