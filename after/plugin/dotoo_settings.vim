
let g:dotoo#capture#clock = 0
let g:dotoo_headline_shade_leading_stars = 1
let g:dotoo_headline_highlight_levels = 9
let g:dotoo#agenda#warning_days = '3d'
let g:dotoo#agenda#files = ['~/Dropbox/Documents/org/*.org']
let g:dotoo#capture#refile = expand('~/Dropbox/Documents/org/refile.org')
let g:dotoo#capture#templates = {
			\ 't' : {
			\   'description': 'Todo',
			\   'lines': [
			\ 			'* TODO %?', 
			\ 			'[[%(GetDotooFilePath())][{{++}}]]',
			\            'DEADLINE: [%(strftime(g:dotoo#time#datetime_format))]'
			\   ],
			\ }
			\}

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
let g:dotoo_todo_keyword_faces = [
			\ ['TODO',      [':foreground 160', ':weight bold']],
			\ ['SOMEDAY',   [':foreground 10',  ':weight none']],
			\ ['NEXT',      [':foreground 27',  ':weight bold']],
			\ ['DONE',      [':foreground 22',  ':weight bold']],
			\ ['WAITING',   [':foreground 202', ':weight bold']],
			\ ['HOLD',      [':foreground 53',  ':weight bold']],
			\ ['CANCELLED', [':foreground 22',  ':weight bold']],
			\ ]

function! GetDotooFilePath()
	let num = printf("file:%s:%d", expand("%:p") , line("."))
	return num
endfunction


"function! InsideCodeblock(...) abort
"	let origin_pos = getpos('.')
"	if a:0 > 0
"		let source_pos = a:1
"	else
"		let source_pos = line('.')
"	endif
"	call cursor(source_pos, 1)
"	let syntype = synIDattr(synID(source_pos, 1, 0), 'name')
"	if (syntype =~? 'dotoo_code') || (syntype =~? 'cBlock')
"		return 1
"	endif
"endfunction
"
"function! BodyRange(...) abort
"	let l:range = []
"	let origin_pos = getpos('.')
"	if a:0 > 0
"		let source_pos = a:1
"	else
"		let source_pos = line('.')
"	endif
"	call cursor(source_pos, 1)
"	if InsideCodeblock(source_pos) == 1
"		let start_delim = searchpair("^\s*#+BEGIN_SRC", '', '\s*#+END_SRC', 'cnbW')
"		let end_delim = search('\s*#+END_SRC', 'cnW')
"		if start_delim != line('.')
"			let l:range = [start_delim+1, end_delim-1]
"		endif
"	endif
"	call cursor(origin_pos[1], origin_pos[2])
"	return l:range
"endfunction
"
"function! Lang(...) abort
"	let l:lang = ''
"	let origin_pos = getpos('.')
"	if a:0 > 0
"		let source_pos = a:1
"	else
"		let source_pos = line('.')
"	endif
"	call cursor(source_pos, 1)
"	if InsideCodeblock(source_pos) == 1
"		let l:lang = matchstr(getline('.'),  '\v(^#+\+BEGIN_SRC\s+)@<=[[:alpha:]]*')
"		if l:lang ==# ''
"			let start_delim = search('^#+\+BEGIN_SRC\s\+', 'nbW')
"			let l:lang = matchstr(getline(start_delim), '\v(^#+\+BEGIN_SRC\s+)@<=[[:alpha:]]*')
"
"		endif
"	endif
"	call cursor(origin_pos[1], origin_pos[2])
"	return l:lang
"endfunction
"
"function! NarrowCodeblock()
"	if InsideCodeblock() == 1
"		if exists("b:nrrw_aucmd_create")
"			let old_hook = b:nrrw_aucmd_create
"		endif
"		let b:nrrw_aucmd_create = 'set ft='.Lang()
"		let range = BodyRange()
"		exe range[0].','.range[1].'NR'
"		if exists("old_hook") 
"			let b:nrrw_aucmd_create = old_hook
"		endif
"	endif
"endfunction
