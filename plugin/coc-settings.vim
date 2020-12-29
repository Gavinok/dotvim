" File: coc_settings.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sun 29 Mar 2020 09:48:16 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" Collection of coc settings
" COC {{{1 "
if !exists('g:mycoc_enabled')
	finish
endif

augroup LazyLoadPlug
	autocmd!
	autocmd CursorHold,CursorHoldI * call plug#load('coc.nvim') | autocmd! LazyLoadPlug
augroup end


" Define Error colors
hi link CocErrorHighlight Error
hi link CocWarningHighlight SpellBad
hi link CocInfoHighlight SpellCap
hi link CocHintHighlight SpellCap

" Extensions. Some need configuration.
" coc-java needs a valid JVM filepath defined in coc-settings
" coc-ccls needs ccls (available on aur)
" coc-eslint needs eslint npm package installed globally
let g:coc_global_extensions = [
			\'coc-diagnostic',
			\'coc-marketplace',
			\'coc-dictionary',
			\'coc-tag',
			\'coc-word',
			\'coc-go',
			\'coc-ccls',
			\'coc-java',
			\'coc-python',
			\'coc-tsserver',
			\'coc-html',
			\'coc-vimtex',
			\'coc-texlab',
			\'coc-json',
			\'coc-lists',
			\'coc-utils'
			\]

" KEY REMAPS
set updatetime=100

" Remap keys for gotos
" use [[ if need be
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nnoremap <Leader>V :<C-u>CocList diagnostics<cr>

" for me this is just <space><space>
nmap <silent> <leader>K :call CocAction('doHover')<CR>

command! -nargs=0 Format :call CocAction('format')

augroup FORMATEXPR
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" map <tab> to trigger completion and navigate to the next item
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
command Market :CocList marketplace
" 1}}} "COC
