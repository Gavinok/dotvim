" File: xdg_dirs.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 03 Feb 2021 10:10:53 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" Settings for using xdg directories in vim

" XDG Environment For VIM
" =======================
if empty($XDG_CACHE_HOME)
	let $XDG_CACHE_HOME = $HOME . '/.cache'
endif
" see :help persistent-undo
if !isdirectory($XDG_CACHE_HOME . '/vim/undo')
	call mkdir($XDG_CACHE_HOME . '/vim/undo', 'p')
endif
set undodir=$XDG_CACHE_HOME/vim/undo//,/var/tmp//,/tmp//
set undofile

" check that directories exist
set backupdir=$XDG_CACHE_HOME/vim/backup//,/var/tmp//,/tmp//
if !isdirectory($XDG_CACHE_HOME . '/vim/backup')
	call mkdir($XDG_CACHE_HOME . '/vim/backup', 'p')
endif

" Double slash does not actually work for backupdir, here's a fix
augroup XDGSUPPORT
	autocmd BufWritePre * let &backupext='@'.substitute(substitute(substitute(expand('%:p:h'), '/', '%', 'g'), '\', '%', 'g'), ':', '', 'g')
augroup end

if !isdirectory($XDG_CACHE_HOME . '/vim/swap')
	call mkdir($XDG_CACHE_HOME . '/vim/swap', 'p')
endif
set directory=$XDG_CACHE_HOME/vim/swap//,/var/tmp//,/tmp//

if has('nvim')
	set viminfo+=n$XDG_CACHE_HOME/vim/nviminfo
else
	set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
endif
