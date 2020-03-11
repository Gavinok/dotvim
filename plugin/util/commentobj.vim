" File: commentobj.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 10 Mar 2020 07:51:18 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" Text opjects for comments

" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
	if v:operator == 'c'
		augroup textobj_undo_empty_change
			autocmd InsertLeave <buffer> execute 'normal! u'
						\| execute 'autocmd! textobj_undo_empty_change'
						\| execute 'augroup! textobj_undo_empty_change'
		augroup END
	endif
endfunction
noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''

" ----------------------------------------------------------------------------
" Comment Object
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
	if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
		call s:textobj_cancel()
		if a:vis
			normal! gv
		endif
		return
	endif

	let origin = line('.')
	let lines = []
	for dir in [-1, 1]
		let line = origin
		let line += dir
		while line >= 1 && line <= line('$')
			execute 'normal!' line.'G^'
			if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
				break
			endif
			let line += dir
		endwhile
		let line -= dir
		call add(lines, line)
	endfor

	execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction

xmap <silent> ic :<C-U>call <SID>inner_comment(1)<CR>
omap <silent> ic :<C-U>call <SID>inner_comment(0)<CR>
