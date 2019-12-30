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
	let nr = winnr('$')
	copen
	if exists('g:autoloaded_dispatch')
		Copen
	endif
	let nr2 = winnr('$')
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
		autocmd InsertLeave <buffer> silent! call dotvim#Quicktag(0)
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
" 1}}} "Toggle Prose Mode

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
		let b:autocompile = 0
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

" shellcompletion {{{1 
function! dotvim#OmniShell(findstart, base) abort
	echo a:base
	if a:findstart
		let l:line = getline('.')
	else
		let s:res = getcompletion(a:base, 'shellcmd')
		return {'words': s:res, 'refresh': 'always'}
	endif
endfunction
" 1}}} "shellcompletion

" TODO: needs some work <15-12-19 Gavin Jaeger-Freeborn>
" shellcompletion {{{1 
function! dotvim#OmniVim(findstart, base) abort
	if a:findstart
		let l:line = getline('.')
	else
		" TODO: add type f to these <15-12-19 Gavin Jaeger-Freeborn>
		let s:res = getcompletion(a:base, 'cmdline')
		call extend(s:res, getcompletion(a:base, 'function'))
		call extend(s:res, getcompletion(a:base, 'var'))
		return {'words': s:res, 'refresh': 'always'}
	endif
endfunction
" 1}}} "shellcompletion

" YankMatches {{{1 
" copy the contents of all matches from the last search
function! dotvim#YankMatches(reg)
	let hits = []
	%s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
" 1}}} "CopyMatches

" MkdirWrite {{{1 "
" mkdir with same name and
"write file to it with :MW
" TODO: remove ! and replace with mkdir() <27-12-19 Gavin Jaeger-Freeborn>
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
	if executable('xdg-open')
		return 'xdg-open'
	endif
	if executable('open')
		return 'open'
	endif
	return 'explorer'
endfunction
" 1}}} "Open

" FormatFile() {{{1
" quickly format the file without moving the cursor or window
function! dotvim#FormatFile()
	let b:PlugView=winsaveview()
	exe 'silent normal! gg=G'
	call winrestview(b:PlugView)
	echo 'file indented'
endfunction
" 1}}} "FormatFile()

" minimal gofmt {{{1
function! dotvim#Gofmt()
	let b:PlugView=winsaveview()
	exe 'silent %!gofmt'
	call winrestview(b:PlugView)
	echo 'file indented'
endfunction
"  1}}} "minimal gofmt

" Minimal Async Command {{{1 
" based on https://gist.github.com/hauleth/0cce9962ffc9a09b3893d53dbcd3abf9
function! s:populate(file, cmd, done) abort
	echohl WarningMsg | echom printf('[Completed] %s', a:cmd) | echohl None
	unlet! g:job
	try
		exe 'cgetfile '.a:file
	finally
		call setqflist([], 'a', {'title': a:cmd}) "update list
	endtry
endfunction

function! dotvim#Do(...) abort
	if exists('g:job')
		echohl ErrorMsg | echom 'There is currently running job, just wait' | echohl None
		return
	endif
	call setqflist([], 'r') " clear list
	let tmp = tempname()
	let cmd = substitute(join(a:000), '%', expand('%'), '') 
	if has('nvim')
		let g:job = jobstart([&shell, &shellcmdflag, printf(cmd.&shellredir, tmp)], {
					\ 'on_exit': {id, data, event -> s:populate(tmp, cmd, 1)}
					\ })
	else
		let g:job = job_start([&shell, &shellcmdflag, printf(cmd.&shellredir, tmp)], {
					\ 'in_io': 'null','out_io': 'null','err_io': 'null',
					\ 'exit_cb': {job, result -> s:populate(tmp, cmd, 1)}
					\ })
	endif
endfunction
" 1}}} "Minimal Async Command

" Run command in Terminal {{{1 
function! dotvim#TermCmd(...)
	let cmd = substitute(join(a:000), '%', expand('%'), '') 
	if has('nvim')
		exec 'split term://' . cmd 
		exec 'normal! i'
	else
		exec 'term ' . cmd
	endif
endfunction
" 1}}} "Run command in Terminal

" Simple Todo using grep {{{1 
function! dotvim#Todo(dir)
	if exists(':Grep') == 2
		execute 'Grep TODO . ' . a:dir 
	else	
		execute 'grep TODO . ' . a:dir
	endif
	copen
endfunction
" 1}}} "Simple Todo using grep

" WebSearch {{{1 
function! dotvim#WebSearch(type, ...)

	let sel_save = &selection
	let &selection = 'inclusive'
	let reg_save = @@

	if a:0  " Invoked from Visual mode, use '< and '> marks.
		silent exe 'normal! `<' . a:type . '`>y'
	elseif a:type ==# 'line'
		silent exe "normal! '[V']y"
	elseif a:type ==# 'block'
		silent exe "normal! `[\<C-V>`]y"
	else
		silent exe 'normal! `[v`]y'
	endif

	let search = substitute(trim(@@), ' \+', '+', 'g')
	silent exe "!linkhandler 'https://duckduckgo.com/?q=" . search . "'"

	let &selection = sel_save
	let @@ = reg_save

endfunction
" 1}}} "WebSearch

" ScreenShots in Markup {{{1 
function! dotvim#OrgScreenShot(desc, dir, filename)
	call setline('.', printf('[[file:%s/%s]]', a:dir, a:filename))
endfunction

function! dotvim#MarkdownScreenShot(desc, dir, filename)
	call setline('.', '!['.a:desc.']('.a:dir.'/'.a:filename.'){ width=50% }')
endfunction

"add a screenshot to a markdown file
function! dotvim#ImportScreenShot(screenshotfunc)
	let dir = 'pic'
	let desc = getline('.')
	let filename = substitute(getline('.'), ' ', '_', 'g').'.png'
	if !isdirectory(dir)
		call mkdir(dir)
	endif
	call a:screenshotfunc(desc, dir, filename)
	call system('import "'.dir.'/'.filename.'"')
	if v:shell_error
		call setline('.', desc)
	endif
endfunction
" 1}}} "ScreenShots in Markup

" CSPACE {{{1  
function! dotvim#CSPACE()
	let cmdline = getcmdline()

	if getcmdtype() isnot# ':' | return "\<SPACE>" | endif

	if cmdline =~# '\v\C^ss$'
		return "\<c-u>%s//g\<left>\<left>"
	elseif cmdline =~# '\v\C^sl$'
		return "\<c-u>s//g\<left>\<left>"
	endif
	return "\<C-]>\<SPACE>"
endfunction
"  1}}} "CSPACE

" CCR {{{1 
" minor adjustments to romainl's function found here
" https://gist.github.com/romainl/5b2cfb2b81f02d44e1d90b74ef555e31
function! dotvim#CCR()
	let cmdline = getcmdline()

	if getcmdtype() isnot# ':' | return "\<CR>" | endif

	command! -bar Z silent set more|delcommand Z
	if cmdline =~# '\v\C^(ls|files|buffers)'
		" like :ls but prompts for a buffer command
		return "\<CR>:b "
	elseif cmdline =~# '\v\C^(cli|lli)'
		" like :clist or :llist but prompts for an error/location number
		return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
	elseif cmdline =~# '\C^old'
		" like :oldfiles but prompts for an old file to edit
		set nomore
		return "\<CR>:Z|e #<"
	elseif cmdline =~# '\C^marks'
		" like :marks but prompts for a mark to jump to
		return "\<CR>:norm! `"
	elseif cmdline =~# '\C^undol'
		" like :undolist but prompts for a change to undo
		return "\<CR>:u "
	elseif cmdline =~# '\C^reg'
		" like registers bug 
		return "\<CR>:norm! \"p\<Left>"
	else
		" <C-]> fixes abbreviation compatability
		return "\<C-]>\<CR>"
	endif
endfunction
" 1}}} "CCR

" Run Vim Script {{{1 
function! dotvim#RunVimScript(...)
	" Select either the visual region, or the current paragraph...
	if a:0
		let @@ = join(getline("'<","'>"), "\n")
	endif

	" Remove continuations and convert shell commands, then execute...
	let command = @@
	let command = substitute(command, '^\s*".\{-}\n', '',     'g')
	let command = substitute(command, '\n\s*\\',      ' ',    'g')
	let command = substitute(command, '^\s*>\s',      ':! ',  '' )
	execute command
endfunction
" 1}}} "Run Vim Script

" ZoomToggle {{{1 
function! dotvim#ZoomToggle()
	if exists('t:maximize_session')
		" Zoom allow edit the same file {{{2
		" only an issue if the file has an extra swap value
		augroup ZOOM
			autocmd!
			autocmd SwapExists * let v:swapchoice='e'
		augroup end
		" 2}}} "Zoom
		exec 'source ' . t:maximize_session
		call delete(t:maximize_session)
		unlet t:maximize_session
		let &hidden=t:maximize_hidden_save
		unlet t:maximize_hidden_save
	else
		"check that there is more then one window
		if (winnr('$') == 1) | return | endif
		let t:maximize_hidden_save = &hidden
		let t:maximize_session = tempname()
		set hidden
		exec 'mksession! ' . t:maximize_session
		only
	endif
endfunction
" 1}}} "ZoomToggle

" load gui {{{1 
function! dotvim#LoadGui()
	set guifont=SourceCode\ Pro\ 13
	set guioptions+=lrbmTLce
	set guioptions-=lrbmTLce
	set guioptions+=c
	nnoremap <leader>+ :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')<CR>
	nnoremap <leader>- :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')<CR>
endfunction

" 1}}} "load gui
" vim:foldmethod=marker:foldlevel=0
