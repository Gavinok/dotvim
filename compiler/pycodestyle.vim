
if exists("compiler")
  finish
endif
let compiler = "codestyle"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=python\ -m\ pycodestyle\ %

let &cpo = s:cpo_save
unlet s:cpo_save
