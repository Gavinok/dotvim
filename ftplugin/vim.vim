" File: vim.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Sat 04 Jan 2020 02:53:18 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for vimscript
" used by 
if executable('vim-language-server')
	let b:lsc_config = {
				\ 'name': 'vim-language-server',
				\ 'command': 'vim-language-server --stdio',
				\    'message_hooks': {
				\        'initialize': {
				\            'initializationOptions': { 
				\               "iskeyword": "@,48-57,_,192-255,-#",
				\               'vimruntime': $VIMRUNTIME, 
				\               'runtimepath': &rtp,
				\               "diagnostic": {
				\                 "enable": "true"
				\               },
				\               "indexes": {
				\                 "runtimepath": "true",      
				\                 "gap": 100,              
				\                 "count": 3,             
				\                 "projectRootPatterns" : ["strange-root-pattern", ".git", "autoload", "plugin"] 
				\               },
				\               "suggest": {
				\                 "fromVimruntime": "true",
				\                 "fromRuntimepath": "false"
				\               }
				\            },
				\        },
				\    },
				\ }
	if exists('g:mylsc_enabled')
		call RegisterLanguageServer('vim', b:lsc_config)
		setlocal omnifunc=lsc#complete#complete
	endif
endif

" ColorDemo - preview of Vim 256 colors
function! ColorDemo() abort
  10 vnew
  setlocal nonumber buftype=nofile bufhidden=hide noswapfile statusline=\ Color\ demo
  let num = 255
  while num >= 0
    execute 'hi col_'.num.' ctermbg='.num.' ctermfg='.num
    execute 'syn match col_'.num.' "='.printf("%3d", num).'" containedIn=ALL'
    call append(0, ' '.printf("%3d", num).'  ='.printf("%3d", num))
    let num -= 1
  endwhile
endfunction
command! -nargs=0 ColorDemo call ColorDemo()

" quickly find the gui equivelent to the cterm number
function! CtermConvert()
	grep! <cword> ~/.vim/extra/cterm_to_hex.vim | copen
endfunction

nnoremap <buffer> zT :call CtermConvert()<CR>

setlocal foldmethod=marker
nmap <buffer> `<CR> :Runtime<CR>
nmap <buffer><silent> <leader>V :Messages<CR>
nnoremap <buffer><silent> <leader>cc :PlugInstall<CR>
nnoremap <buffer><silent> <leader>cl :PlugClean<CR>

"use vim like a zrepl
xnoremap <buffer><silent> gz :<C-u>call dotvim#RunVimScript(visualmode(), 1)<CR>
nnoremap <buffer><silent> gz :<C-u>set operatorfunc=dotvim#RunVimScript<CR>g@
nnoremap <buffer><silent> gzz gz_
nnoremap <buffer><silent> gzZ gz&
