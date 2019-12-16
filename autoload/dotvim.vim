" File: dotvim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 29 Nov 2019 02:14:06 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" Functions I want to autoload in my config

" ToggleQuickfix {{{1 
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
" 1}}} "ToggleQuickfix

" Quicktag {{{1 
function! dotvim#Quicktag(force) abort
	if !filereadable('tags') && !filereadable('.tags')
		let g:rootdir = FindRootDirectory()
	else 
		let g:rootdir = getcwd()
		autocmd mine InsertLeave <buffer> call dotvim#Quicktag(0)
	endif
	if g:rootdir !=# '' || a:force
		exec 'Dispatch ctags  -f ".tags" -R ' . g:rootdir
	else 
		echo 'no root'
	endif
endfunction
" 1}}} "Quicktag


" RepeatResize {{{1 "
function! dotvim#RepeatResize(first) abort
	let l:command = a:first
	while stridx('+-><', l:command) != -1
		execute "normal! \<C-w>" . l:command
		redraw
		let l:command = nr2char(getchar())
	endwhile
endfunction
" 1}}} "RepeatResize

" Toggle Prose Mode {{{1 "
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
" 2}}} "Toggle Prose Mode

" netrwmappings {{{1 
" for - in vim
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
" 1}}} "netrwmappings

" ToggleAutocompile {{{1 
function! dotvim#ToggleAutocompile() abort
	if !exists('b:autocompile')
		let b:autocompile = 0
	endif
	if !b:autocompile
		augroup AUTOCOMP
			autocmd!
			autocmd BufWrite <buffer> :silent! Make!
		augroup END
		let b:autocompile = 1
	else
		augroup AUTOCOMP
			autocmd!
		augroup END
	endif
endfunction 
" 1}}} "ToggleAutocompile

" VisSort {{{1
function! dotvim#VisSort(isnmbr) range abort
	if visualmode() !=# "\<c-v>"
		execute 'silent! '.a:firstline.','.a:lastline.'sort i'
		return
	endif
	let firstline = line("'<")
	let lastline  = line("'>")
	let keeprega  = @a
	execute 'silent normal! gv"ay'
	execute "'<,'>s/^/@@@/"
	execute "silent! keepjumps normal! '<0\"aP"
	if a:isnmbr
		execute "silent! '<,'>s/^\s\+/\=substitute(submatch(0),' ','0','g')/"
	endif
	execute "sil! keepj '<,'>sort i"
	execute 'sil! keepj '.firstline.','.lastline.'s/^.\{-}@@@//'
	let @a = keeprega
endfun
" 1}}} "VisSort

" shcompletion {{{1 
function! dotvim#OmniShell(findstart, base) abort
	echo a:base
	if a:findstart
		let l:line = getline('.')
	else
		let s:res = getcompletion(a:base, 'shellcmd')
		return {'words': s:res, 'refresh': 'always'}
	endif
endfunction
" 1}}} "shcompletion

" CopyMatches {{{1 
" copy the contents of all matches from the last search
function! dotvim#CopyMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
" 1}}} "CopyMatches

" MkdirWrite {{{1 "
" mkdir with same name and
"write file to it with :MW
function! dotvim#MkdirWrite()
	w
	!mkdir '%:t:r'
	!mv % '%:t:r'/
	e %:t:r/%
	" redraw!
endfunction
" 1}}} "MkdirWrite

" MRU {{{1 
" MRU command-line completion
function! dotvim#MRUComplete(ArgLead, CmdLine, CursorPos)
	return filter(v:oldfiles, 'v:val =~ a:ArgLead')
endfunction

" MRU function
function! dotvim#MRU(command, arg)
	execute a:command . ' ' . a:arg
endfunction
" 1}}} "MRU
" Open {{{1 
" What command to use
function! dotvim#Open() abort
	if executable('rifle')
		return 'rifle'
	endif
	if executable('xdg-open')
		return 'xdg-open'
	endif
	if executable('open')
		return 'open'
	endif
	return 'explorer'
endfunction
" 1}}} "Open

" FormatFile() {{{2
" quickly format the file without moving the cursor or window
function! dotvim#FormatFile()
	let b:PlugView=winsaveview()
	exe 'silent normal! gg=G'
	call winrestview(b:PlugView)
	echo 'file indented'
endfunction
" 2}}} "FormatFile()

" Minimal Async Command {{{1 
" based on https://gist.github.com/hauleth/0cce9962ffc9a09b3893d53dbcd3abf9
function! s:populate(file, cmd, done) abort
	if a:done 
		echohl WarningMsg | echom printf('[Completed] %s', a:cmd) | echohl None
		unlet! b:job
	endif
	try
		exe 'cgetfile '.a:file
	finally
		call setqflist([], 'a', {'title': a:cmd}) "update list
	endtry
endfunction

function! dotvim#Do(...) abort
	if exists('b:job')
		echohl ErrorMsg | echom 'There is currently running job, just wait' | echohl None
		return
	endif
	call setqflist([], 'r') " clear list
	let tmp = tempname()
	let cmd = substitute(join(a:000), '%', expand('%'), '') 
	if has('nvim')
		let b:job = jobstart([&shell, &shellcmdflag, printf(cmd.&shellredir, tmp)], {
					\ 'on_stdout': {id, data, event -> s:populate(tmp, cmd, 0)},
					\ 'on_exit': {id, data, event -> s:populate(tmp, cmd, 1)}
					\ })
	else
		let b:job = job_start([&shell, &shellcmdflag, printf(cmd.&shellredir, tmp)], {
					\ 'in_io': 'null','out_io': 'null','err_io': 'null',
					\ 'exit_cb': {job, result -> s:populate(tmp, cmd, 1)}
					\ })
	endif
endfunction
" 1}}} "Minimal Async Command
