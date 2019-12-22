" File: alt.vim
" Maintainer: Gavin Jaeger-Freeborn
" Created: Sat 21 Dec 2019 04:34:24 PM MST
" Description: 
" simply use fzf if the command exists instead of e **/*
if exists(':FZF') == 2
	nnoremap <leader>ff  :Root<CR>:FZF<CR>
endif
