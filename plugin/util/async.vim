" File: async.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 03 Feb 2021 10:07:34 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" Minimal implementation of vim-dispatch
" Minimal Async Command {{{2
if exists('*job_start') || exists('*jobstart')
	command! -nargs=+ -complete=shellcmd Term call dotvim#TermCmd(<f-args>)
	command! -nargs=+ -complete=shellcmd Do call dotvim#Do(<f-args>)

	" dispatch compatability
	command! -bang -nargs=+ -complete=shellcmd Dispatch call dotvim#Do(<f-args>)
	command! -bang -nargs=+ -complete=file_in_path Grep call dotvim#Do(&grepprg,<f-args>)
	command! -bang -nargs=* -complete=file Make call dotvim#Do(&makeprg,<f-args>)
	nnoremap  '<CR>     :Term<Up><CR>
	nnoremap  '<Space>  :Term<Space>
	nnoremap  '<TAB>    :Term<Up>
	nnoremap  `<CR>     :Do<Up><CR>
	nnoremap  `<Space>  :Do<Space>
	nnoremap  `<TAB>    :Do<Up>
	nnoremap  m<CR>     :w\|Make<CR>
	nnoremap  m<Space>  :Make<Space>
	nnoremap  m!		:setlocal makeprg=compiler\ %<CR>
	nnoremap  m?		:echo &makeprg<CR>
	nnoremap  mm :call dotvim#ToggleAutocompile()<CR>
	"async tagging
	nnoremap <leader>T  :call dotvim#Quicktag(0)<CR>
else
	nnoremap  `<TAB>    :!<Up>
	nnoremap  `<Space>  :!
	nnoremap  m!        :make!<Space>
	nnoremap  m<CR>		:make!<CR>
endif
" 2}}} "Minimal Async Command

