" File: python.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 18 Nov 2019 02:25:32 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" python specific settings

" Only do this when not yet done for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

compiler pyunit
setlocal makeprg=python\ %
setlocal foldmethod=indent

"indents
setlocal autoindent ts=4 sw=4 sts=4 expandtab

"show leading chars
" setlocal list listchars=space:·,tab:>\ 
" highlight WhiteSpaceBol ctermfg=237
" highlight WhiteSpaceMol ctermfg=black
" match WhiteSpaceMol / /
" 2match WhiteSpaceBol /^ \+/

" syntax
let python_highlight_all = 1

iabbrev xxx  print("xxx")
nnoremap <buffer><silent> [[ :call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', '\v^(\s+<bar>)def ')<CR>
setl commentstring=#\ %s
function! Pydoc()
	"code
	if exists('g:autoloaded_dispatch')
		exec 'silent Dispatch pydoc '. expand('<cword>')
	else
		exec 'new|read !pydoc '. expand('<cword>')
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
		setfiletype man
	endif
endfunction
command! -nargs=0 Pydoc call Pydoc()
setl keywordprg=:Pydoc
" set the path to the approptiate 
" location for python
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
