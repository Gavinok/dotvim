" File: troff.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 09 Oct 2020 05:06:59 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" personal troff settings

setlocal tw=72
setlocal fo+=l

let b:preprocs_as_sections = 1
let b:nroff_is_groff = 1
let nroff_space_errors = 1

let g:troff_eqndelim = '@@'

let b:surround_67 = ".CD\r.DE"
let b:surround_75 = ".KS\r.KE"

" make this optional
set complete+=t
set complete+=i
set foldmethod=marker

inoreabbrev <buffer> linup lineup
inoreabbrev <buffer> abvoe above

" make optional
inoremap <buffer> T{<CR> T{<CR>T}<c-o><s-o>
imap <buffer> \{\<CR> \{\<CR>.\}<c-o><s-o>
nmap <buffer> <leader><space> :vimgrep! /\C\(\.XN\\|HEADING\)\zs.*\ze/ %<CR>copen<CR>

augroup AUTOCOMP
	autocmd!
	try
		autocmd BufWrite <buffer> :silent! Make!
	catch /.*/
		echo 'busy'
	endtry
augroup END
let b:autocompile = 1

function! MyTroffMacroslevel(maxlevel)
	for headingnum in range(1,a:maxlevel)
		let headingregex = '^\.\(#\{' . headingnum .'} ' . '.*$\|NH' . headingnum . '\)'
		if getline(v:lnum) =~ headingregex
			return '>' . headingnum
		endif
	endfor
    return "="
endfunction

function! TroffMacroslevel(maxlevel)
	let ms = 'NH ' . headingnum . ' .*$'
	let ms = 'SH ' . headingnum . ' .*$'
	let me = 'sh ' . headingnum . ' .*$'
	"
	" no heading level
	let me = 'uh .*$'
	let mm = 'HU .*$'

	" mandatory heading level
	let mm = 'H ' . headingnum . ' .*$'
	let mom = 'HEADING ' . headingnum . ' .*$'

	for headingnum in range(1,a:maxlevel)
		if headingnum = 1
			let headingnum = ''
		endif
		let headingregex = '^\.\(#\{' . headingnum .'} ' . '.*$\|\)'
		if getline(v:lnum) =~ headingregex
			return '>' . headingnum
		endif
	endfor
    return "="
endfunction

setlocal foldexpr=MyTroffMacroslevel(5)
setlocal foldmethod=expr
setlocal autoindent

" if isdirectory( g:groff_install_prefix . '/groff/current/tmac' )
" execute 'setlocal tags+=' . g:groff_install_prefix . '/groff/current/tmac/.tags'
" execute 'setlocal tags+=' . g:groff_install_prefix . '/usr/local/lib/groff/site-tmac/.tags'
" execute 'setlocal tags+=' . g:groff_install_prefix . '/usr/local/share/groff/site-tmac/.tags'
" endif
