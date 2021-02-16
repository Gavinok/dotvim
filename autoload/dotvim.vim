" File: dotvim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 29 Nov 2019 02:14:06 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" Functions I want to autoload in my config
scriptencoding utf-8 " ensure mulitbyte chars in this file are supported


" ToggleQuickfix {{{1
function! dotvim#ToggleQuickfix() abort
	let nr = winnr('$')
	" force location list to close
	silent! lclose
	silent! lclose
	copen
	if exists('g:autoloaded_dispatch')
		Copen
	endif
	let nr2 = winnr('$')
	if nr == nr2
		cclose
	endif
endfunction

function! dotvim#ToggleLocationlist() abort
	let nr = winnr('$')
	silent LSClientAllDiagnostics
	let nr2 = winnr('$')
	if nr == nr2
		cclose
		silent! lclose
		silent! lclose
	endif
endfunction
" 1}}} "ToggleQuickfix

" Quicktag {{{1
function! dotvim#Quicktag(force) abort
	if !filereadable('tags') && !filereadable('.tags')
		let g:rootdir = FindRootDirectory()
	else
		let g:rootdir = getcwd()
	endif
	if g:rootdir !=# '' || a:force
		" call system('ctags  -f ".tags" -R ' . shellescape(g:rootdir) .' &')
		execute 'Dispatch ctags  -f ' . &tags . ' -R ' . g:rootdir
	else
		echo 'no root'
	endif
endfunction
" 1}}} "Quicktag

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
			setlocal complete-=k
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
			setlocal spell spelllang=en_ca
			" use a preselected dictionary file
			execute 'setlocal dictionary+=' . g:quickdict
			setlocal dictionary+=spell
			setlocal complete+=k
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

" " now - doesnt use <space> after moving up a directory
function! dotvim#NetrwMapping() abort
	let netrw_sid = maparg('s', 'n', 0, 1)['sid']
	execute 'nnoremap <buffer> -  :call <SNR>'.netrw_sid.'_NetrwBrowseUpDir(1)<CR>'
	execute 'nnoremap <buffer> zo :<C-U>call <SNR>'.netrw_sid.'_NetrwHidden(1)<CR>'
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
try

	autocmd BufWrite <buffer> :silent! Make!
catch /.*/
	echo 'busy'
endtry
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

" YankMatches {{{1
" copy the contents of all matches from the last search
function! dotvim#YankMatches(reg)
	let hits = []
	exec '%s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne'
	let reg = empty(a:reg) ? '+' : a:reg
	execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
" 1}}} "CopyMatches

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
	if !empty($PLUMBER)
		return $PLUMBER
	elseif executable('xdg-open')
		return 'xdg-open'
	elseif executable('open')
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
		exe 'cgetfile '. a:file
	finally
		call setqflist([], 'a', {'title': a:cmd}) "update list
	endtry
endfunction

function! dotvim#Do(...) abort
	if exists('g:job')
		echohl ErrorMsg | echo 'There is currently running job, just wait' | echohl None
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

" ScreenShots in Markup {{{1
function! dotvim#OrgScreenShot(desc, dir, filename)
	call setline('.', printf('[[file:%s/%s]]', a:dir, a:filename))
endfunction

function! dotvim#MarkdownScreenShot(desc, dir, filename)
	call setline('.', '!['.a:desc.']('.a:dir.'/'.a:filename.'){ width=50% }')
endfunction

function! dotvim#GroffScreenShot(desc, dir, filename)
	call setline('.', printf('.PSPIC %s/%s', a:dir, a:filename))
endfunction

"add a screenshot to a markdown file
function! dotvim#ImportScreenShot(screenshotfunc, extension)
	let dir = 'pic'
	let desc = getline('.')
	let filename = substitute(getline('.'), ' ', '_', 'g').a:extension
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

" Run Vim Script {{{1
function! dotvim#RunVimScript(type, ...) abort
    let sel_save = &selection
    let &selection = 'inclusive'

	" Select either the visual region, or the current paragraph...
	if a:0
		let @@ = join(getline("'<","'>"), "\n")
    else
        let @@ = join(getline("'[", "']"), "\n")
	endif

	" Remove continuations and convert shell commands, then execute...
	let command = @@
	let command = substitute(command, '^\s*".\{-}\n', '',     'g')
	let command = substitute(command, '\n\s*\\',      ' ',    'g')
	let command = substitute(command, '^\s*>\s',      ':! ',  '' )
	execute command
endfunction
" 1}}} "Run Vim Script

" load gui {{{1
function! dotvim#LoadGui()
	set guifont=SourceCode\ Pro\ 13
	set guioptions+=lrbmTLce
	set guioptions-=lrbmTLce
	set guioptions+=c
	nnoremap ë :silent! let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')<CR>
	nnoremap ê :silent! let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')<CR>
endfunction
" 1}}} "load gui

" Titlecase {{{1 "
function! dotvim#titlecase(type, ...) abort
  let g:type = a:type
  let g:it =  a:0
  let g:dem = a:000
  let WORD_PATTERN = '\<\(\k\)\(\k*''*\k*\)\>'
  let UPCASE_REPLACEMENT = '\u\1\L\2'

  let regbak = @@
  try
    if a:0  " Invoked from Visual mode, use '< and '> marks.
      " Back up unnamed register to avoid clobbering its contents
      if a:type ==# ''
        silent exe 'normal! `<' . a:type . '`>y'
        let titlecased = substitute(@@, WORD_PATTERN, UPCASE_REPLACEMENT, 'g')
        call setreg('@', titlecased, 'b')
        silent execute 'normal! ' . a:type . '`>p'
      else
        silent exe 'normal! `<' . a:type . '`>y'
        let @i = substitute(@@, WORD_PATTERN, UPCASE_REPLACEMENT, 'g')
        silent execute 'normal! ' . a:type . '`>"ip'
      endif
    elseif a:type ==# 'line'
      execute '''[,'']s/'.WORD_PATTERN.'/'.UPCASE_REPLACEMENT.'/ge'
    else
      silent exe 'normal! `[v`]y'
      let titlecased = substitute(@@, WORD_PATTERN, UPCASE_REPLACEMENT, 'g')
      silent exe 'normal! v`]c' . titlecased
    endif
  finally
    " Restore unnamed register to its original state
    let @@ = regbak
  endtry
endfunction
" 1}}} "Titlecase

" vim:foldmethod=marker:foldlevel=0
