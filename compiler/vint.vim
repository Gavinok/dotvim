" File: vint.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 26 Nov 2019 09:11:21 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" compiler plugin for vim utilizing vint [https://github.com/Kuniwak/vint]
if exists('current_compiler') || &compatible || !has('patch-7.4.191')
  finish
endif
let current_compiler = 'vimlint'

CompilerSet makeprg=vint\ -s\ %:S
CompilerSet errorformat=%f:%l:%c:\ %m
