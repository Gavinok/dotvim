" File: gradle.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 14 Oct 2020 12:14:06 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" compiler for gradle
" FROM: https://raw.githubusercontent.com/tfnico/vim-gradle/master/compiler/gradle.vim

if exists("current_compiler")
    finish
endif
let current_compiler = "gradle5"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=gradle

CompilerSet errorformat=
    \%E[ant:scalac]\ %f:%l:\ error:\ %m,
    \%W[ant:scalac]\ %f:%l:\ warning:\ %m,
    \%E%.%#:compile%\\w%#Java%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,
    \%W%.%#:compile%\\w%#Java%f:%l:\ warning:\ %m,%-Z%p^,%-C%.%#,
    \%E%f:%l:\ error:\ %m,%-Z%p^,%-C%.%#,
    \%W%f:%l:\ warning:\ %m,%-Z%p^,%-C%.%#,
    \%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%-G%.%#
