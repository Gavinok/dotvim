" File: dotvim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 29 Nov 2019 02:14:06 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" Functions I want to autoload in my config

function! dotvim#ToggleQuickfix() abort
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

function! dotvim#Quicktag() abort
	let g:rootdir = FindRootDirectory()
	if g:rootdir !=# ''
		exec 'Dispatch! ctags  -f ".tag" -R ' . g:rootdir
	else 
		echo 'no root'
	endif
endfunction


" RepeatResize {{{2 "
function! dotvim#RepeatResize(first) abort
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
function! dotvim#WordProcessor() abort
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

function! dotvim#Opendir(cmd) abort  
	if expand('%') =~# '^$\|^term:[\/][\/]'  
		execute a:cmd '.'  
	else  
		execute a:cmd '%:h'  
		let pattern = '^\%(| \)*'.escape(expand('#:t'), '.*[]~\').'[/*|@=]\=\%($\|\t\)'  
		call search(pattern, 'wc')  
	endif  
endfunction

" now - doesnt use <space> after moving up a directory
function! dotvim#NetrwMapping() abort
	let netrw_sid = maparg('s', 'n', 0, 1)['sid']
	execute 'nnoremap <buffer> - :call <SNR>'.netrw_sid.'_NetrwBrowseUpDir(1)<CR>'
	execute 'nnoremap <buffer> <leader>cp :!cp <C-R><C-F> ~/'
endfunction

" ToggleAutocompile {{{2 
function! dotvim#ToggleAutocompile() abort
	if !exists('b:autocompile')
		let b:autocompile = 0
	endif
	if !b:autocompile
		augroup AUTOCOMP
			autocmd!
			autocmd BufWrite <buffer> :Make!
		augroup END
		let b:autocompile = 1
	else
		augroup AUTOCOMP
			autocmd!
		augroup END
	endif
endfunction 
" 2}}} "ToggleAutocompile
