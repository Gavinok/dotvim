" File: slideshow.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 13 Oct 2020 09:35:40 AM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" compiler for racket slideshow


if exists("compiler")
  finish
endif
let compiler = "slideshow"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=slideshow\ %

let &cpo = s:cpo_save
unlet s:cpo_save
