" File: python.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 13 Jan 2020 03:25:31 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for python

let python_space_errors = 1

if executable('pyls')
	let b:lsc_config = 'pyls'
	if exists('g:mymu_enabled')
		call RegisterLanguageServer('python', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif

function! Pydoc()
	"code
	exec 'new|read !pydoc '. expand('<cword>')
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	setfiletype man
endfunction

let &l:define  = '^\s*\('
             \ . '\(def\|class\)\s'
             \ . '\)'

command! -nargs=0 Pydoc call Pydoc()
setlocal path=,/usr/lib/python3.8
setlocal suffixesadd+=.py
if !has('nvim')
python << EOF
import os
import sys
import vim
for p in sys.path:
    # Add each directory in sys.path, if it exists.
    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endif
