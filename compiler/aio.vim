" File: aio.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 26 Nov 2019 11:57:58 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" all in one compiler I wrote for my self to simplify vim's make system using
" my comiler shell script
if exists("current_compiler")
	finish
endif
let current_compiler = "aio"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

" make {{{
if (filereadable('Makefile') || filereadable('makefile'))
	CompilerSet makeprg=make
" }}} "make
" c {{{"
elseif &filetype == 'c'
	CompilerSet makeprg=compiler\ %
	
	set errorformat=%f\|%l\|%c,%f\|%l\|,%f\|\| " This describes estream's output format to Vim
	" CompilerSet errorformat=
	" 			\%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
	" 			\%*[^\"]\"%f\"%*\\D%l:\ %m,
	" 			\\"%f\"%*\\D%l:%c:\ %m,
	" 			\\"%f\"%*\\D%l:\ %m,
	" 			\%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
	" 			\%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
	" 			\%f:%l:%c:\ %trror:\ %m,
	" 			\%f:%l:%c:\ %tarning:\ %m,
	" 			\%f:%l:%c:\ %m,
	" 			\%f:%l:\ %trror:\ %m,
	" 			\%f:%l:\ %tarning:\ %m,
	" 			\%f:%l:\ %m,
	" 			\%f:\\(%*[^\\)]\\):\ %m,
	" 			\\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
	" 			\%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',
	" 			\%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',
	" 			\%D%*\\a:\ Entering\ directory\ %*[`']%f',
	" 			\%X%*\\a:\ Leaving\ directory\ %*[`']%f',
	" 			\%DMaking\ %*\\a\ in\ %f
" 1}}} "c
" vim {{{
elseif &filetype == 'vim'
	CompilerSet makeprg=vint\ -s\ %
	CompilerSet errorformat=%f:%l:%c:\ %m
" }}} "vim
" sh {{{ 
elseif &filetype == 'sh'
	CompilerSet makeprg=compiler\ %
	CompilerSet errorformat=%f:\ %l:\ %m
" }}} "sh
" python {{{
elseif &filetype ==# 'python'
CompilerSet makeprg=python3\ %

CompilerSet errorformat=
	\%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
	\%C\ \ \ \ %.%#,
	\%+Z%.%#Error\:\ %.%#,
	\%A\ \ File\ \"%f\"\\\,\ line\ %l,
	\%+C\ \ %.%#,
	\%-C%p^,
	\%Z%m,
	\%-G%.%#
" }}} "python
"  go {{{
elseif &filetype ==# 'go'
	CompilerSet makeprg=compiler\ %
	CompilerSet errorformat=
		\%-G#\ %.%#,
		\%A%f:%l:%c:\ %m,
		\%A%f:%l:\ %m,
		\%C%*\\s%m,
		\%-G%.%#
" }}} "go
" markup {{{ 
elseif &filetype ==# 'dotoo'
			\|| &filetype ==# 'org' 
			\|| &filetype ==# 'markdown' 
			\|| &filetype ==# 'pandoc'
CompilerSet makeprg=compiler\ %
CompilerSet errorformat="%f",\ line\ %l:\ %m
" }}} "markup
" java {{{ "
elseif &filetype ==# 'java'
	CompilerSet makeprg=javac\ *.java
	CompilerSet errorformat=%E%f:%l:\ %m,%-Z%p^,%-C%.%#,%-G%.%#
" }}} "java
endif
let &cpo = s:cpo_save
unlet s:cpo_save

