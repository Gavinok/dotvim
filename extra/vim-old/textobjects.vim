" File: textobjects.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Mon 30 Dec 2019 12:37:48 PM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" A collection of diy text objects
" Inside And Arround {{{1
" inside or arround ...
" ----------------------
" i" i' i. i_ i| i/ i\ i*
" a" a' a. a_ a| a/ a\ a*
for char in [ '"', "'",'_', '.', '$', '/', '<bslash>', '*' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" 1}}} "Inside And Arround

" Line {{{1 
" line text-objects
" -----------------
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>
" 1}}} "Line

" Number {{{1 
" number text-objects (integer and float)
" ---------------------------------------
" in an
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal! v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :normal! vin<CR>
" 1}}} "Number

" Square Brackets {{{1 
" square brackets text-objects
" ----------------------------
" ir ar
xnoremap ir i[
xnoremap ar a[
onoremap ir :normal vi[<CR>
onoremap ar :normal va[<CR>
" 1}}} "Square Brackets

" Quotes {{{1 
" quote text-objects
" ----------------------------
" iq aq
xnoremap iq i"
xnoremap aq a"
onoremap iq :normal vi"<CR>
onoremap aq :normal va"<CR>
" 1}}} "Quotes

