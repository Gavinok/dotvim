" File: org.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 01 May 2020 02:23:20 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" Simple implementation of orgmode support for vim

" Orgmode {{{2 "
" Simple implementation of org-capture using minisnip
function! CreateCapture(window)
	" if this file has a name
	let g:org_refile='~/Documents/org/refile.org'
	if expand('%:p') !=# ''
		let g:temp_org_file=printf('file:%s:%d', expand('%:p') , line('.'))
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/template.org')
	else
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/templatenofile.org')
	endif
	call feedkeys("i\<Plug>(minisnip)", 'i')
endfunction

function! W3m(url)
	let newurl = substitute(a:url, 'https\?:\/\/', '', 'g')
	call dotvim#TermCmd("w3m '" . newurl . "'")
endfunction
nmap gX :call W3m('<c-r>=expand('<cfile>')<CR>')<CR>

let g:dotoo#agenda#files = ['~/Documents/org/*.org']

let g:dotoo#parser#todo_keywords = [
			\ 'TODO',
			\ 'NEXT',
			\ 'SOMEDAY',
			\ 'WAITING',
			\ 'HOLD',
			\ '|',
			\ 'CANCELLED',
			\ 'DONE',
			\]

let g:dotoo_headline_highlight_colors = [
			\ 'Title',
			\ 'Identifier',
			\ 'Statement',
			\ 'PreProc',
			\ 'Type',
			\ 'Special',
			\ 'Constant']

let g:org_state_keywords = [ 'TODO', 'NEXT', 'DONE', 'SOMEDAY', 'CANCELLED' ]
hi link orgHeading2 Normal
let g:org_time='%H:%M'
let g:org_date='%Y-%m-%d %a'
let g:org_date_format=g:org_date.' '.g:org_time
map <silent>gO :e ~/Documents/org<CR>
map <silent>gC :call CreateCapture('split')<CR>
command! -nargs=+ NGrep let s:gp=&gp|set gp+=\ -i| grep "<args>" ~/.local/Dropbox/Documents/org/**/*.org       |let &gp=s:gp|unl s:gp
" 2}}} "Orgmode
