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

"show leading chars
setlocal expandtab
setlocal list listchars=space:·,tab:>\ 
highlight WhiteSpaceBol ctermfg=237
highlight WhiteSpaceMol ctermfg=black
match WhiteSpaceMol / /
2match WhiteSpaceBol /^ \+/

iabbrev xxx  print("xxx")
nnoremap <buffer><silent> [[ :call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', '\v^(\s+<bar>)def ')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', '\v^(\s+<bar>)def ')<CR>
setl commentstring=#\ %s

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
