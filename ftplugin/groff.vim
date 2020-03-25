" File: groff.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 14 Feb 2020 09:52:12 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for groff files
nnoremap <buffer> K :Man 7 groff_ms<CR>

if executable('efm-langserver')
	let b:lsc_config = {
				\ 'name': 'efm-langserver',
				\ 'command': 'efm-langserver -c='.$HOME.'/.vim/extra/efm/config.yaml',
				\ 'suppress_stderr': v:true,
				\}
	if exists('g:loaded_lsc')
		call RegisterLanguageServer('groff', b:lsc_config)
		call RegisterLanguageServer('nroff', b:lsc_config)
	endif
endif

" matchit now supports ms macros
let b:match_words = '^\.QS:^\.QE,' . '^\.RS:^\.RE,' . '^\.AB:^\.AE,' . '^\.KS:^\.KE,' . '^\.B1:^\.B2,'
			\. '^\.cstart:^\.cend,'. '^\.EQ:^\.EN,' . '^\.G1:^\.G2,' . '^\.GS:^\.GE,' 
			\. '^\.IS:^\.IE,' . '^\.PS:^\.PE,' . '^\.R1:^\.R2,' . '^\.TS:^\.TE,'
