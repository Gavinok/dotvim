" File: markdown.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 18 Nov 2019 02:25:32 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" markdown specific settings

" Only do this when not yet done for this buffer
if exists('b:did_ftplugin') finish
endif
let b:did_ftplugin = 1

setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nowrap
setlocal errorformat="%f",\ line\ %l:\ %m
setlocal makeprg=compiler\ %
setlocal foldmethod=indent

nnoremap <buffer><silent> ]] :call CustomSections('down', '^\# ')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', '^\# ')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', '^\# ')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', '^\# ')<CR>

" Let's try this heading-based fold method out (Tim Pope)
function! MarkdownFold()
  let line = getline(v:lnum)

  " Regular headers
  let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
  if depth > 0
    return '>' . depth
  endif

  " Setext style headings
  if line =~# '^.\+$'
    let nextline = getline(v:lnum + 1)
    if nextline =~# '^=\+$'
      return '>1'
    elseif nextline =~# '^-\+$'
      return '>2'
    endif
  endif

  return '='
endfunction

setlocal foldexpr=MarkdownFold()
setlocal foldmethod=expr
setlocal foldlevel=99
autocmd BufWrite *.md :Make!
" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
endif
