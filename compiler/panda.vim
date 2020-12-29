" File: panda.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 24 Nov 2019 11:52:30 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" compiler for pandoc using compiler script
if exists('compiler')
  finish
endif

let current_compiler = "panda"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim


CompilerSet errorformat="%f",\ line\ %l:\ %m
CompilerSet makeprg=compiler\ %

let &cpo = s:cpo_save
unlet s:cpo_save
