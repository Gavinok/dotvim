" File: rec.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 23 Sep 2020 11:31:08 AM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description:
" ftplugin for recfiles

inoreabbrev todo TODO
inoreabbrev done DONE

let g:org_time='%H:%M'
let g:org_date='%Y-%m-%d %a'
let g:org_date_format=g:org_date.' '.g:org_time

setlocal makeprg=recfix\ %

if exists("g:loaded_speeddating")
	execute '1SpeedDatingFormat ' . g:org_date
	execute '1SpeedDatingFormat ' . g:org_date_format
endif
