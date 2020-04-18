" File: go.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 04 Dec 2019 08:37:46 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
if executable('gopls')
	let b:lsc_config = {
				\ 'command': 'gopls serve',
				\ 'log_level': -1,
				\ 'suppress_stderr': v:true,
				\}

	if exists('g:loaded_lsc')
		call RegisterLanguageServer('go', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif
" filetype plugin for go

setlocal makeprg=go\ build

function! Godoc()
	"code
	if exists(':Dispatch')
		exec 'silent Dispatch go doc '. expand('<cword>')
	else
		exec 'new|read !go doc '. expand('<cword>')
		setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
		setfiletype man
	endif
endfunction
command! -nargs=0 Godoc call Godoc()


if executable('golint')
	command! -buffer GoLint call s:GoLint()

	function! s:GoLint() abort
		if exists(':Dispatch')
			exec 'Dispatch golint '. shellescape(expand('%'))
		else
			cexpr system('golint ' . shellescape(expand('%')))
		endif
	endfunction

	" autocmd BufWritePost,FileWritePost *.go execute 'Lint'
endif
let b:did_ftplugin_go_lint = 1

setl keywordprg=:Godoc

" use gofmt for formatting
nnoremap <buffer><silent> gQ :call dotvim#Gofmt()<CR>

if executable('gofmt')
	setlocal formatprg="gofmt"
	setlocal formatexpr=
endif

" make ]] and [[ great again
nnoremap <buffer><silent> ]] :call CustomSections('down', 'func.*)\s*\zs{\s*\ze$')<CR>
nnoremap <buffer><silent> [[ :call CustomSections('up', 'func.*)\s*\zs{\s*\ze$')<CR>
xnoremap <buffer><silent> [[ :<C-U>exe "norm! gv"<bar>call CustomSections('up', 'func.*)\s*\zs{\s*\ze$')<CR>
xnoremap <buffer><silent> ]] :<C-U>exe "norm! gv"<bar>call CustomSections('down', 'func.*)\s*\zs{\s*\ze$')<CR>
