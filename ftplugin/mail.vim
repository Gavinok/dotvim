" File: mail.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 14 Jan 2020 12:23:30 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for mail files (neomutt)
if executable('efm-langserver')
	let b:lsc_config = {
				\ 'name': 'efm-langserver',
				\ 'command': 'efm-langserver -c='.$HOME.'/.vim/extra/efm/config.yaml',
				\ 'suppress_stderr': v:true,
				\}
	if exists('g:mymu_enabled')
		call RegisterLanguageServer('mail', b:lsc_config)
	endif
endif

compiler proselint

function! Dict(word)
	"code
	exec 'new|read !dict '.a:word
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	setfiletype text
endfunction
command! -nargs=1 Dict call Dict(<q-args>)

setlocal keywordprg=Dict

" force dict to be used along side lsc
nnoremap <buffer> K :Dict <c-r><c-w><CR>

set omnifunc=text_omnicomplete#OmniComplete

call dotvim#WordProcessor()
