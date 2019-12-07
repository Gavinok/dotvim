" File: neomucomplete.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sat 07 Dec 2019 03:24:17 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" an even more minimul completion method

" Add this to your vimrc to get a minimalist autocomplete pop
" Or use as a plugin : https://github.com/maxboisvert/vim-simple-complete

" for vimrc {{{1 "
augroup mygroup
    autocmd!
augroup END

autocmd mygroup FileType vim let b:completion_keys = "\<C-X>\<C-O>"
autocmd mygroup FileType c let b:completion_keys = "\<C-X>\<C-O>"
" 1}}} "for vimrc

let b:completion_keys = get(b:, 'completion_keys', "\<C-P>\<C-N>")

" Minimalist-TabComplete-Plugin
inoremap <expr> <Tab> TabComplete(1)
inoremap <expr> <S-Tab> TabComplete(0)
fun! TabComplete(dir)
    if getline('.')[col('.') - 1] =~ '\K' || pumvisible()
        return a:dir ? "\<C-N>" : "\<C-P>"
    else
        return "\<Tab>"
    endif
endfun

" Minimalist-AutoCompletePop-Plugin
set completeopt=menu,noselect,menuone,noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
autocmd InsertCharPre * call AutoComplete()
fun! AutoComplete()
    if v:char =~ '\K'
        \ && getline('.')[col('.') - 4] !~ '\K'
        \ && getline('.')[col('.') - 2] =~ '\K' " last char
        \ && getline('.')[col('.') - 1] !~ '\K'


        call feedkeys("\<C-R>=MUcompleteMinisnip#complete()\<CR>", 'n')
		if !pumvisible()
			call feedkeys("\<C-X>\<C-P>\<C-N>", 'n')
		endif
    end
endfun

