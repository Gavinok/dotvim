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

" line text objects
" -----------------
" il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>

" number text object (integer and float)
" --------------------------------------
" in
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :<C-u>normal vin<CR>

" buffer text objects
" -------------------
" i% a%
xnoremap i% :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap i% :<C-u>normal vi%<CR>
xnoremap a% GoggV
onoremap a% :<C-u>normal va%<CR>


" Inside And Arround {{{1
" inside or arround ...
" ----------------------
" i" i' i. i_ i| i/ i\ i*
" a" a' a. a_ a| a/ a\ a*
for char in [ '_', '.', '\|', ';','$', '@', '/', '<bslash>', '*' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" 1}}} "Inside And Arround
" TODO: Find a better location for this <17-06-20 Gavin Jaeger-Freeborn>
let g:surround_insert_tail = "{{++}}"

" groff escape sequences
" --------------------------------------
" in


" wip starter \\\([fn\*]\)\(.\|(..\|\[\{-}\]\)
" function! VisualNumber()
" 	call search('\\\([fnm\*]\)\(.\|(..\|\[\{-}\]\)', 'cW')
" 	normal v
" 	call search('\(^\|[^0-9\.]\d\)', 'becW')
" endfunction
" xnoremap in :<C-u>call VisualNumber()<CR>
" onoremap in :<C-u>normal vin<CR>
