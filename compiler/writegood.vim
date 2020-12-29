" File: writegood.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 14 Jan 2020 12:37:04 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" compiler plugin for writegood

if exists("compiler")
	finish
endif
let compiler = "writegood"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=writegood\ --parse\ %

CompilerSet efm=%f:%l:%c:%m


let &cpo = s:cpo_save
unlet s:cpo_save
