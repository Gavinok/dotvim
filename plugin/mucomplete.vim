" File: mucomplete.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 07 Apr 2020 03:10:00 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" plugin settings for mucomplete
if !exists("g:mymu_enabled")
	finish
endif
" Mucomplete {{{2 "
"-----------
if has('patch-7.4.775')
	augroup LazyLoadMucomplete
		autocmd!
		autocmd CursorHold,CursorHoldI * call LoadMucomplete() | call plug#load('vim-mucomplete') | autocmd! LazyLoadMucomplete
	augroup end

	function! LoadMucomplete()
		let g:mucomplete#user_mappings = {
					\'mini': "\<C-r>=MUcompleteMinisnip#complete()\<CR>",
					\'groff': "\<C-r>=Groffcomplete()\<CR>",
					\ }
		set completeopt+=menuone

		" Tab complete dont accept until told to
		set completeopt+=noselect
		let g:mucomplete#enable_auto_at_startup = 1
		"----------- completion chains
		set complete-=i
		set complete-=t
		" remove beeps during completion
		set belloff=all

		let g:mucomplete#wordlist = {
					\       '': ['gavinfreeborn@gmail.com', 'Gavin', 'Jaeger-Freeborn'],
					\ }

		let g:mucomplete#chains = {}
		let g:mucomplete#chains['default']   =  { 
					\              'default': ['mini',  'list',  'omni',  'path',  'c-n',   'uspl'], 
					\              '.*string.*': ['uspl'], 
					\              '.*comment.*': ['uspl']
					\            }
		let g:mucomplete#chains['html']      =  ['mini',  'omni',  'path',  'c-n',   'uspl']
		let g:mucomplete#chains['vim']       =  ['mini',  'list',  'cmd',   'path',  'keyp']
		let g:mucomplete#chains['tex']       =  ['mini',  'path',  'omni',  'uspl',  'dict',  'c-n']
		let g:mucomplete#chains['sh']        =  ['mini',  'file',  'dict',  'keyp']
		let g:mucomplete#chains['zsh']       =  ['mini',  'file',  'dict',  'keyp']
		let g:mucomplete#chains['java']      =  ['mini',  'tags',  'keyn',  'omni',  'c-n']
		let g:mucomplete#chains['javascript']=  ['mini',  'tags',  'omni',  'c-n']
		let g:mucomplete#chains['c']         =  ['mini',  'list',  'omni',  'omni', 'c-n']
		let g:mucomplete#chains['go']        =  ['mini',  'list',  'omni',  'c-n']
		let g:mucomplete#chains['groff']     =  ['mini',  'path', 'incl', 'groff', 'c-n',   'uspl',  'dict']
		let g:mucomplete#chains['nroff']     =  g:mucomplete#chains['groff']
		let g:mucomplete#chains['markdown']  =  ['mini',  'path',  'c-n',   'uspl',  'dict']
		let g:mucomplete#chains['dotoo']     =  g:mucomplete#chains['markdown']
		let g:mucomplete#chains['mail']      =  g:mucomplete#chains['markdown']

		if !exists('g:mucomplete#can_complete')
			let s:c_cond = { t -> t =~# '\%(->\|\.\)$' }
			let s:latex_cond= { t -> t =~# '\%(\\\)$' }
			let g:mucomplete#can_complete = {}
			let g:mucomplete#can_complete['c']         =  {  'omni':  s:c_cond              }
			let g:mucomplete#can_complete['go']        =  {  'omni':  s:c_cond              }
			let g:mucomplete#can_complete['python']    =  {  'omni':  s:c_cond              }
			let g:mucomplete#can_complete['java']      =  {  'omni':  s:c_cond              }
			" let g:mucomplete#can_complete['javascript']=  {  'omni': {t->t=~#'\%(->\|\.\|(\))$' }}
			let g:mucomplete#can_complete['javascript']=  {  'omni':  s:c_cond }
			let g:mucomplete#can_complete['markdown']  =  {  'dict':  s:latex_cond          }
			let g:mucomplete#can_complete['org']       =  {  'dict':  s:latex_cond,          
						\ 'tag': {t->t=~#'\%(:\)$' }}
			let g:mucomplete#can_complete['tex']       =  {  'omni':  s:latex_cond          }
			let g:mucomplete#can_complete['groff']     =  {  'groff': { t -> t =~# '\%(\\\[\)$' }}
			let g:mucomplete#can_complete['html']      =  {  'omni':  {t->t=~#'\%(<\/\)$'}  }
			let g:mucomplete#can_complete['vim']       =  {  'cmd':   {t->t=~#'\S$'}        }
		endif
		let g:mucomplete#no_popup_mappings = 0
		"spelling
		let g:mucomplete#spel#good_words = 1
	endfunction
endif
" 2}}} "Mucomplete

