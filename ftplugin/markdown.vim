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
if exists('b:did_ftplugin') 
	finish
endif
let b:did_ftplugin = 1
let markdown_fenced_languages = ['c', 'python']
compiler aio
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal wrap
setlocal errorformat="%f",\ line\ %l:\ %m
setlocal makeprg=compiler\ %
setlocal foldexpr=MarkdownFold()
setlocal foldmethod=expr
setlocal foldlevel=99
setlocal commentstring=<!--%s-->
autocmd BufWrite *.md :silent AbortDispatch<CR>:Make!
autocmd BufRead *.md call SyntaxRange#Include('\$[^$]', '\$', 'tex')
" setlocal keywordprg=ducksearch
" Spellcheck documents we're actually editing (not just viewing)
if &modifiable && !&readonly
  setlocal spell
endif

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

function! MDInsideCodeblock(...) abort
    let origin_pos = getpos('.')
    if a:0 > 0
        let source_pos = a:1
    else
        let source_pos = line('.')
    endif
    call cursor(source_pos, 1)
    if synIDattr(synID(source_pos, 1, 0), 'name') =~? 'markdownCode'
        return 1
    endif
    let prev_delim = searchpair('^[~`]\{3}\s', '', '^[~`]\{3}', 'bnW')
    let next_delim = search('^[~`]\{3}', 'nW')
    call cursor(origin_pos[1], origin_pos[2])
    if prev_delim > 0
        if source_pos > prev_delim && source_pos < next_delim
            return 1
        endif
    endif
endfunction

function! MDBodyRange(...) abort
    let l:range = []
    let origin_pos = getpos('.')
    if a:0 > 0
        let source_pos = a:1
    else
        let source_pos = line('.')
    endif
    call cursor(source_pos, 1)
    if MDInsideCodeblock(source_pos) == 1
        let start_delim = searchpair('^[~`]\{3}', '', '^[~`]\{3}', 'cnbW')
        let end_delim = search('^[~`]\{3}', 'cnW')
        if start_delim != line('.')
            let l:range = [start_delim+1, end_delim-1]
        else
            " we are at the starting delimiter
            if MDInsideCodeblock(source_pos-1) == 0
                let l:range = [start_delim + 1, search('^[~`]\{3}', 'nW') -1]
            " we are at the ending delimiter
            else
                let l:range = [search('^[~`]\{3}', 'bnW') + 1, end_delim - 1]
            endif
        endif
    endif
    call cursor(origin_pos[1], origin_pos[2])
    return l:range
endfunction

function! MDLang(...) abort
    let l:lang = ''
    let origin_pos = getpos('.')
    if a:0 > 0
        let source_pos = a:1
    else
        let source_pos = line('.')
    endif
    call cursor(source_pos, 1)
    if MDInsideCodeblock(source_pos) == 1
        let l:lang = matchstr(getline('.'),  '\([~`]\{3}\s\+\)\@<=[[:alpha:]]*')
        if l:lang ==# ''
            let start_delim = search('^[~`]\{3}', 'nbW')
            let l:lang = matchstr(getline(start_delim), '\([~`]\{3}\s\+\)\@<=[[:alpha:]]*')
        endif
    endif
    call cursor(origin_pos[1], origin_pos[2])
    return l:lang
endfunction

function! MDNarrowCodeblock()
	if MDInsideCodeblock() == 1
		if exists("b:nrrw_aucmd_create")
			let old_hook = b:nrrw_aucmd_create
		endif
		let b:nrrw_aucmd_create = 'set ft='.MDLang()
		let range = MDBodyRange()
		exe range[0].','.range[1].'NR'
		if exists("old_hook") 
			let b:nrrw_aucmd_create = old_hook
		endif
	endif
endfunction
