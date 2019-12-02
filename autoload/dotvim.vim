" File: dotvim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 29 Nov 2019 02:14:06 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" Functions I want to autoload in my config

function! dotvim#ToggleQuickfix()
	let nr = winnr("$")
	copen
	if exists('g:autoloaded_dispatch')
		Copen
	endif
	let nr2 = winnr("$")
	if nr == nr2
		cclose
	endif
endfunction

function! dotvim#Quicktag()
	let g:rootdir = FindRootDirectory()
	if g:rootdir !=# ''
		exec 'Dispatch! ctags  -f ".tag" -R ' . g:rootdir
	else 
		echo 'no root'
	endif
endfunction


" RepeatResize {{{2 "
function! dotvim#RepeatResize(first)
	let l:command = a:first
	while stridx('+-><', l:command) != -1
		execute "normal! \<C-w>" . l:command
		redraw
		let l:command = nr2char(getchar())
	endwhile
endfunction
" 2}}} "RepeatResize

" Toggle Prose Mode {{{2 "
"toggle prose and code mode
function! dotvim#WordProcessor()
	if !exists('b:prose')
		let b:prose = 0
	endif
	if exists('b:prose')
		if b:prose
			let b:prose=0
			echo 'Code Mode'
			silent! nunmap <buffer> j
			silent! nunmap <buffer> k
			silent! nunmap <buffer> $
			silent! nunmap <buffer> 0
			silent! nunmap <buffer> ^
			silent! iunmap <buffer> .
			silent! iunmap <buffer> !
			silent! iunmap <buffer> ?
			silent! iunmap <buffer> :
			silent! setlocal nospell
			silent! setlocal nolinebreak
			silent! let g:goyo_width=80
		else
			let b:prose=1
			echo 'Prose Mode'
			nnoremap <buffer> j gj
			nnoremap <buffer> k gk
			nnoremap <buffer> $ g$
			nnoremap <buffer> 0 g0
			nnoremap <buffer> ^ g^
			inoremap <buffer> . .<C-g>u
			inoremap <buffer> ! !<C-g>u
			inoremap <buffer> ? ?<C-g>u
			inoremap <buffer> : :<C-g>u
			setlocal spell spelllang=en_us
			setlocal linebreak
			let g:goyo_width=80
		endif
	endif
endfu
" 2}}} "
