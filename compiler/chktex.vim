" File: chktex.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 10 Jan 2020 12:56:59 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" compiler plugin for chktex
if exists('compiler')
  finish
endif

let current_compiler = "chktex"


if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=chktex\ -q\ -v3\ %
" CompilerSet makeprg=chktex\ -q\ %
" CompilerSet errorformat=%tarning\ %n\ in\ %f\ line\ %l:\ %m,
			" \

let &cpo = s:cpo_save
unlet s:cpo_save
