" File: groff.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Fri 14 Feb 2020 09:52:12 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" ftplugin for groff files
nnoremap <buffer> K :call GroffMan()<cr>

let g:groff_greek =1
let g:groff_math =1
let g:groff_supsub =1

setlocal include=^\\.m\\?so
let &l:define = '^\.\(de\|nr\|ds\)\s*'
setlocal suffixesadd+=.ms,.mom,.tmac,.macros,.mac,.mm

" for tracebacks 
setlocal errorformat=%o:%f:%l:%m
" invalid symbol
setlocal errorformat+=refer:%f:%l:%m
" macro errors
setlocal errorformat+=%f:%l:\ macro\ %trror:%m
" general errors
setlocal errorformat+=%f:%l:%m
" warnings
setlocal errorformat+=%W%tarning:\ file\ '%f'\\,\ around\ line\ %l:,%Z%m
" add comment string
setlocal commentstring=.\\\"%s
let nroff_space_errors = 1
" let b:preprocs_as_sections = 1
let b:nroff_is_groff = 1
imap <buffer> <c-x><c-o> <c-r>=Groffcomplete()<CR>

" add tmac files to path
setlocal path+=,/usr/share/groff/1.22.4/tmac
" TODO: Check that file exists and if it doesnt create it <04-06-20 Gavin Jaeger-Freeborn>
setlocal tags+=/usr/share/groff/1.22.4/tmac/.tags

" matchit now supports ms macros
let b:match_words = '^\.QS:^\.QE,' . '^\.RS:^\.RE,' . '^\.AB:^\.AE,' . '^\.KS:^\.KE,' . '^\.B1:^\.B2,'
			\. '^\.cstart:^\.cend,'. '^\.EQ:^\.EN,' . '^\.G1:^\.G2,' . '^\.GS:^\.GE,' 
			\. '^\.IS:^\.IE,' . '^\.PS:^\.PE,' . '^\.R1:^\.R2,' . '^\.TS:^\.TE,. ^\.JS:^\.JE,'

" if executable('efm-langserver')
" 	let b:lsc_config = {
" 				\ 'name': 'efm-langserver',
" 				\ 'command': 'efm-langserver -c='.$HOME.'/.vim/extra/efm/config.yaml',
" 				\ 'suppress_stderr': v:true,
" 				\}
" 	if exists('g:mymu_enabled')
" 		call RegisterLanguageServer('groff', b:lsc_config)
" 		call RegisterLanguageServer('nroff', b:lsc_config)
" 	endif
" endif

function! GroffcompleteCandidates()
	let glyph = [
				\{'word': '\[AN]',       'menu'             :'∧',             'info':'logical and'},
				\{'word': '\[OR]',       'menu'             :'∨',             'info':'logical or'},
				\{'word': '\[no]',       'menu'             :'¬',             'info':'logical not + ***'},
				\{'word': '\[tno]',      'menu'             :'¬',             'info':'text variant of ‘no’'},
				\{'word': '\[te]',       'menu'             :'∃',             'info':'there exists'},
				\{'word': '\[fa]',       'menu'             :'∀',             'info':'for all'},
				\{'word': '\[st]',       'menu'             :'∋',             'info':'sucht that'},
				\{'word': '\[3d]',       'menu'             :'∴',             'info':'therefore'},
				\{'word': '\[tf]',       'menu'             :'∴',             'info':'therefore'},
				\{'word': '\[or]',       'menu'             :'|',             'info':'bitwise OR operator (as used in C) +'},
				\{'word': '\[12]',       'menu'             :'½',             'info':'1/2 symbol +'},
				\{'word': '\[14]',       'menu'             :'¼',             'info':'1/4 symbol +'},
				\{'word': '\[34]',       'menu'             :'¾',             'info':'3/4 symbol +'},
				\{'word': '\[18]',       'menu'             :'⅛',             'info':'1/8 symbol'},
				\{'word': '\[38]',       'menu'             :'⅜',             'info':'3/8 symbol'},
				\{'word': '\[58]',       'menu'             :'⅝',             'info':'5/8 symbol'},
				\{'word': '\[78]',       'menu'             :'⅞',             'info':'7/8 symbol'},
				\{'word': '\[S1]',       'menu'             :'¹',             'info':'superscript 1'},
				\{'word': '\[S2]',       'menu'             :'²',             'info':'superscript 2'},
				\{'word': '\[S3]',       'menu'             :'³',             'info':'superscript 3'},
				\{'word': '\[pl]',       'menu'             :'+',             'info':'plus in special font +'},
				\{'word': '\[mi]',       'menu'             :'−',             'info':'minus in special font +'},
				\{'word': '\[-+]',       'menu'             :'∓',             'info':'minus-plus'},
				\{'word': '\[+-]',       'menu'             :'±',             'info':'plus-minus + ***'},
				\{'word': '\[t+-]',       'menu'            :'±',             'info':'text variant of \[+-]'},
				\{'word': '\[pc]',       'menu'             :'·',             'info':'period centered'},
				\{'word': '\[md]',       'menu'             :'⋅',             'info':'multiplication dot'},
				\{'word': '\[mu]',       'menu'             :'×',             'info':'multiply sign + ***'},
				\{'word': '\[tmu]',       'menu'            :'×',             'info':'text variant of \[mu]'},
				\{'word': '\[c*]',       'menu'             :'⊗',             'info':'multiply sign in circle'},
				\{'word': '\[c+]',       'menu'             :'⊕',             'info':'plus sign in circle'},
				\{'word': '\[di]',       'menu'             :'÷',             'info':'division sign + ***'},
				\{'word': '\[tdi]',       'menu'            :'÷',             'info':'text variant of \[di]'},
				\{'word': '\[f/]',       'menu'             :'⁄',             'info':'bar for fractions'},
				\{'word': '\[**]',       'menu'             :'∗',             'info':'mathematical asterisk +'},
				\{'word': '\[<=]',       'menu'             :'≤',             'info':'less or equal +'},
				\{'word': '\[>=]',       'menu'             :'≥',             'info':'greater or equal +'},
				\{'word': '\[<<]',       'menu'             :'≪',             'info':'much less'},
				\{'word': '\[>>]',       'menu'             :'≫',             'info':'much greater'},
				\{'word': '\[eq]',       'menu'             :'=',             'info':'equals in special font +'},
				\{'word': '\[!=]',       'menu'             :'≠',             'info':'not equal +'},
				\{'word': '\[==]',       'menu'             :'≡',             'info':'equivalent +'},
				\{'word': '\[ne]',       'menu'             :'≢',             'info':'not equivalent'},
				\{'word': '\[=~]',       'menu'             :'≅',             'info':'congruent, approx. equal'},
				\{'word': '\[|=]',       'menu'             :'≃',             'info':'asymptot. equal to +'},
				\{'word': '\[ap]',       'menu'             :'∼',             'info':'similar +'},
				\{'word': '\[~~]',       'menu'             :'≈',             'info':'almost equal to'},
				\{'word': '\[~=]',       'menu'             :'≈',             'info':'almost equal to'},
				\{'word': '\[pt]',       'menu'             :'∝',             'info':'proportional +'},
				\{'word': '\[es]',       'menu'             :'∅',             'info':'empty set +'},
				\{'word': '\[mo]',       'menu'             :'∈',             'info':'element of a set +'},
				\{'word': '\[nm]',       'menu'             :'∉',             'info':'not element of set'},
				\{'word': '\[sb]',       'menu'             :'⊂',             'info':'proper subset +'},
				\{'word': '\[nb]',       'menu'             :'⊄',             'info':'not supset'},
				\{'word': '\[sp]',       'menu'             :'⊃',             'info':'proper superset +'},
				\{'word': '\[nc]',       'menu'             :'⊅',             'info':'not superset'},
				\{'word': '\[ib]',       'menu'             :'⊆',             'info':'subset or equal +'},
				\{'word': '\[ip]',       'menu'             :'⊇',             'info':'superset or equal +'},
				\{'word': '\[ca]',       'menu'             :'∩',             'info':'intersection, cap +'},
				\{'word': '\[cu]',       'menu'             :'∪',             'info':'union, cup +'},
				\{'word': '\[/_]',       'menu'             :'∠',             'info':'angle'},
				\{'word': '\[pp]',       'menu'             :'⊥',             'info':'perpendicular'},
				\{'word': '\[is]',       'menu'             :'∫',             'info':'integral +'},
				\{'word': '\[integral]', 'menu'             :'∫',             'info':'integral ***'},
				\{'word': '\[sum]',      'menu'             :'∑',             'info':'summation ***'},
				\{'word': '\[product]',  'menu'             :'∏',             'info':'product ***'},
				\{'word': '\[coproduct]','menu'             :'∐',             'info':'coproduct ***'},
				\{'word': '\[gr]',       'menu'             :'∇',             'info':'gradient +'},
				\{'word': '\[sr]',       'menu'             :'√',             'info':'square root +'},
				\{'word': '\[sqrt]',     'menu'             :'√',             'info':'square root'},
				\{'word': '\[lc]',       'menu'             :'⌈',             'info':'left ceiling +'},
				\{'word': '\[rc]',       'menu'             :'⌉',             'info':'right ceiling +'},
				\{'word': '\[lf]',       'menu'             :'⌊',             'info':'left floor +'},
				\{'word': '\[rf]',       'menu'             :'⌋',             'info':'right floor +'},
				\{'word': '\[if]',       'menu'             :'∞',             'info':'infinity +'},
				\{'word': '\[Ah]',       'menu'             :'ℵ',             'info':'aleph'},
				\{'word': '\[Im]',       'menu'             :'ℑ',             'info':'Gothic I, imaginary'},
				\{'word': '\[Re]',       'menu'             :'ℜ',             'info':'Gothic R, real'},
				\{'word': '\[wp]',       'menu'             :'℘',             'info':'Weierstrass p'},
				\{'word': '\[pd]',       'menu'             :'∂',             'info':'partial differentiation +'},
				\{'word': '\[-h]',       'menu'             :'ℏ',             'info':'Planck constant / 2pi (h-bar)'},
				\{'word': '\[hbar]',     'menu'             :'ℏ',             'info':'Planck constant / 2pi (h-bar)'},
				\]
	return glyph
endfunction

let s:cmp = 'stridx(v:val, l:pat) >= 0'
function! Groffcomplete() abort
	let l:pat = matchstr(getline('.'), '\S\+\%' . col('.') . 'c')
    let l:candidates = GroffcompleteCandidates()
	if !empty(l:candidates)
		call complete(col('.') - len(l:pat), l:candidates)
	endif
	return ''
endfunction

function! GroffMan()
	let [line, col] = [line('.'), col('.')]
	" get the syntax type at the cursor
	let syntype = reverse(map(synstack(line, col), 'synIDattr(v:val,"name")'))
	for synt in syntype
		if synt ==# 'nroffEquation'
			Man eqn
			return
		elseif synt ==# 'nroffTable'
			Man tbl
			return
		elseif synt ==# 'nroffPicture'
			Man pic
			return
		endif
	endfor
	Man 7 groff
endfunction
inoreabbrev <buffer> linup lineup
inoreabbrev <buffer> abvoe above

inoremap T{<CR> T{<CR>T}<c-o><s-o>

let b:surround_92 = "\\f[\1environment: \1]\r\\f[P]"
