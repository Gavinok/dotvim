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

" Handle all kinds for tracebacks
setlocal errorformat=%o:<standard\ input>\ (%f):%l:%m
setlocal errorformat+=%o:%f:%l:%m
setlocal errorformat+=%o:\ %f:%l:%m
" invalid symbol
setlocal errorformat+=refer:%f:%l:%m
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
" imap <buffer> <c-x><c-o> <c-r>=Groffcomplete()<CR>

" add tmac files to path
setlocal path+=,/usr/share/groff/1.22.4/tmac
" TODO: Check that file exists and if it doesnt create it <04-06-20 Gavin Jaeger-Freeborn>
setlocal tags+=/usr/share/groff/1.22.4/tmac/.tags

set complete+=t
set complete+=i

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
				\{'word': 'AN]',       'menu'             :'∧',             'info':'logical and'},
				\{'word': 'OR]',       'menu'             :'∨',             'info':'logical or'},
				\{'word': 'no]',       'menu'             :'¬',             'info':'logical not + ***'},
				\{'word': 'tno]',      'menu'             :'¬',             'info':'text variant of ‘no’'},
				\{'word': 'te]',       'menu'             :'∃',             'info':'there exists'},
				\{'word': 'fa]',       'menu'             :'∀',             'info':'for all'},
				\{'word': 'st]',       'menu'             :'∋',             'info':'sucht that'},
				\{'word': '3d]',       'menu'             :'∴',             'info':'therefore'},
				\{'word': 'tf]',       'menu'             :'∴',             'info':'therefore'},
				\{'word': 'or]',       'menu'             :'|',             'info':'bitwise OR operator (as used in C) +'},
				\{'word': '12]',       'menu'             :'½',             'info':'1/2 symbol +'},
				\{'word': '14]',       'menu'             :'¼',             'info':'1/4 symbol +'},
				\{'word': '34]',       'menu'             :'¾',             'info':'3/4 symbol +'},
				\{'word': '18]',       'menu'             :'⅛',             'info':'1/8 symbol'},
				\{'word': '38]',       'menu'             :'⅜',             'info':'3/8 symbol'},
				\{'word': '58]',       'menu'             :'⅝',             'info':'5/8 symbol'},
				\{'word': '78]',       'menu'             :'⅞',             'info':'7/8 symbol'},
				\{'word': 'S1]',       'menu'             :'¹',             'info':'superscript 1'},
				\{'word': 'S2]',       'menu'             :'²',             'info':'superscript 2'},
				\{'word': 'S3]',       'menu'             :'³',             'info':'superscript 3'},
				\{'word': 'pl]',       'menu'             :'+',             'info':'plus in special font +'},
				\{'word': 'mi]',       'menu'             :'−',             'info':'minus in special font +'},
				\{'word': '-+]',       'menu'             :'∓',             'info':'minus-plus'},
				\{'word': '+-]',       'menu'             :'±',             'info':'plus-minus + ***'},
				\{'word': 't+-]',       'menu'            :'±',             'info':'text variant of \[+-]'},
				\{'word': 'pc]',       'menu'             :'·',             'info':'period centered'},
				\{'word': 'md]',       'menu'             :'⋅',             'info':'multiplication dot'},
				\{'word': 'mu]',       'menu'             :'×',             'info':'multiply sign + ***'},
				\{'word': 'tmu]',       'menu'            :'×',             'info':'text variant of \[mu]'},
				\{'word': 'c*]',       'menu'             :'⊗',             'info':'multiply sign in circle'},
				\{'word': 'c+]',       'menu'             :'⊕',             'info':'plus sign in circle'},
				\{'word': 'di]',       'menu'             :'÷',             'info':'division sign + ***'},
				\{'word': 'tdi]',       'menu'            :'÷',             'info':'text variant of \[di]'},
				\{'word': 'f/]',       'menu'             :'⁄',             'info':'bar for fractions'},
				\{'word': '**]',       'menu'             :'∗',             'info':'mathematical asterisk +'},
				\{'word': '<=]',       'menu'             :'≤',             'info':'less or equal +'},
				\{'word': '>=]',       'menu'             :'≥',             'info':'greater or equal +'},
				\{'word': '<<]',       'menu'             :'≪',             'info':'much less'},
				\{'word': '>>]',       'menu'             :'≫',             'info':'much greater'},
				\{'word': 'eq]',       'menu'             :'=',             'info':'equals in special font +'},
				\{'word': '!=]',       'menu'             :'≠',             'info':'not equal +'},
				\{'word': '==]',       'menu'             :'≡',             'info':'equivalent +'},
				\{'word': 'ne]',       'menu'             :'≢',             'info':'not equivalent'},
				\{'word': '=~]',       'menu'             :'≅',             'info':'congruent, approx. equal'},
				\{'word': '|=]',       'menu'             :'≃',             'info':'asymptot. equal to +'},
				\{'word': 'ap]',       'menu'             :'∼',             'info':'similar +'},
				\{'word': '~~]',       'menu'             :'≈',             'info':'almost equal to'},
				\{'word': '~=]',       'menu'             :'≈',             'info':'almost equal to'},
				\{'word': 'pt]',       'menu'             :'∝',             'info':'proportional +'},
				\{'word': 'es]',       'menu'             :'∅',             'info':'empty set +'},
				\{'word': 'mo]',       'menu'             :'∈',             'info':'element of a set +'},
				\{'word': 'nm]',       'menu'             :'∉',             'info':'not element of set'},
				\{'word': 'sb]',       'menu'             :'⊂',             'info':'proper subset +'},
				\{'word': 'nb]',       'menu'             :'⊄',             'info':'not supset'},
				\{'word': 'sp]',       'menu'             :'⊃',             'info':'proper superset +'},
				\{'word': 'nc]',       'menu'             :'⊅',             'info':'not superset'},
				\{'word': 'ib]',       'menu'             :'⊆',             'info':'subset or equal +'},
				\{'word': 'ip]',       'menu'             :'⊇',             'info':'superset or equal +'},
				\{'word': 'ca]',       'menu'             :'∩',             'info':'intersection, cap +'},
				\{'word': 'cu]',       'menu'             :'∪',             'info':'union, cup +'},
				\{'word': '/_]',       'menu'             :'∠',             'info':'angle'},
				\{'word': 'pp]',       'menu'             :'⊥',             'info':'perpendicular'},
				\{'word': 'is]',       'menu'             :'∫',             'info':'integral +'},
				\{'word': 'integral]', 'menu'             :'∫',             'info':'integral ***'},
				\{'word': 'sum]',      'menu'             :'∑',             'info':'summation ***'},
				\{'word': 'product]',  'menu'             :'∏',             'info':'product ***'},
				\{'word': 'coproduct]','menu'             :'∐',             'info':'coproduct ***'},
				\{'word': 'gr]',       'menu'             :'∇',             'info':'gradient +'},
				\{'word': 'sr]',       'menu'             :'√',             'info':'square root +'},
				\{'word': 'sqrt]',     'menu'             :'√',             'info':'square root'},
				\{'word': 'lc]',       'menu'             :'⌈',             'info':'left ceiling +'},
				\{'word': 'rc]',       'menu'             :'⌉',             'info':'right ceiling +'},
				\{'word': 'lf]',       'menu'             :'⌊',             'info':'left floor +'},
				\{'word': 'rf]',       'menu'             :'⌋',             'info':'right floor +'},
				\{'word': 'if]',       'menu'             :'∞',             'info':'infinity +'},
				\{'word': 'Ah]',       'menu'             :'ℵ',             'info':'aleph'},
				\{'word': 'Im]',       'menu'             :'ℑ',             'info':'Gothic I, imaginary'},
				\{'word': 'Re]',       'menu'             :'ℜ',             'info':'Gothic R, real'},
				\{'word': 'wp]',       'menu'             :'℘',             'info':'Weierstrass p'},
				\{'word': 'pd]',       'menu'             :'∂',             'info':'partial differentiation +'},
				\{'word': '-h]',       'menu'             :'ℏ',             'info':'Planck constant / 2pi (h-bar)'},
				\{'word': 'hbar]',     'menu'             :'ℏ',             'info':'Planck constant / 2pi (h-bar)'},
				\]
	return glyph
endfunction

let s:base_macros = [
			\{ 'word': 'ab'        , 'menu': 'ab string'                                                                                 , 'info': 'Print string on standard error                                                                                                                             , exit program.' }                                                                  ,
			\{ 'word': 'ad'        , 'menu': 'ad'                                                                                        , 'info': 'Begin line adjustment for output lines in current adjust mode.' }                                                                                          ,
			\{ 'word': 'ad'        , 'menu': 'ad c'                                                                                      , 'info': 'Start line adjustment in mode c (c=l,r,c,b,n).' }                                                                                                                ,
			\{ 'word': 'af'        , 'menu': 'af register c '                                                                            , 'info': 'Assign format c to register (c=l,i,I,a,A).' }                                                                                                                ,
			\{ 'word': 'aln'       , 'menu': 'aln alias register '                                                                       , 'info': 'Create alias name for register.' }                                                                                                                         ,
			\{ 'word': 'als'       , 'menu': 'als alias object '                                                                         , 'info': 'Create alias name for request, string, macro, or diversion object.' } ,
			\{ 'word': 'am'        , 'menu': 'am macro', 'info': 'Append to macro until .. is encountered.' }                             ,
			\{ 'word': 'am'        , 'menu': 'am macro end '                                                                             , 'info': 'Append to macro until .end is called.' }                                                                                                                   ,
			\{ 'word': 'am1'       , 'menu': 'am1 macro '                                                                                , 'info': 'Same as .am but with compatibility mode switched off during macro expansion.' }                                                                            ,
			\{ 'word': 'am1'       , 'menu': 'am1 macro end '                                                                            , 'info': 'Same as .am but with compatibility mode switched off during macro expansion.' }                                                                            ,
			\{ 'word': 'ami'       , 'menu': 'ami macro '                                                                                , 'info': 'Append to a macro whose name is contained in the string register macro until .. is encountered.' }                                                         ,
			\{ 'word': 'ami'       , 'menu': 'ami macro end '                                                                            , 'info': 'Append to a macro indirectly.  macro and end are string registers whose contents are interpolated for the macro name and the end macro, respectively.' }                                                                  ,
			\{ 'word': 'ami1'      , 'menu': 'ami1 macro '                                                                               , 'info': 'Same as .ami but with compatibility mode switched off during macro expansion.' }                                                                           ,
			\{ 'word': 'ami1'      , 'menu': 'ami1 macro end '                                                                           , 'info': 'Same as .ami but with compatibility mode switched off during macro expansion.' }                                                                           ,
			\{ 'word': 'as'        , 'menu': 'as stringvar anything '                                                                    , 'info': 'Append anything to stringvar.' }                                                                                                                           ,
			\{ 'word': 'as1'       , 'menu': 'as1 stringvar anything '                                                                   , 'info': 'Same as .as but with compatibility mode switched off during string expansion.' }                                                                           ,
			\{ 'word': 'asciify'   , 'menu': 'asciify diversion '                                                                        , 'info': 'Unformat ASCII characters, spaces, and some escape sequences in diversion.' }                              ,
			\{ 'word': 'backtrace' , 'menu': 'backtrace '                                                                                , 'info': 'Print a backtrace of the input on stderr.' }                                                                                                               ,
			\{ 'word': 'bd'        , 'menu': 'bd font N '                                                                                , 'info': 'Embolden font by N-1 units.' }                                                                                                                             ,
			\{ 'word': 'bd'        , 'menu': 'bd S font N '                                                                              , 'info': 'Embolden Special Font S when current font is font.' }                                                                                                      ,
			\{ 'word': 'blm'       , 'menu': 'blm'                                                                                       , 'info': 'Unset the blank line macro.' }                                                                                                                             ,
			\{ 'word': 'blm'       , 'menu': 'blm macro '                                                                                , 'info': 'Set the blank line macro to macro.' }                                                                                                                      ,
			\{ 'word': 'box'       , 'menu': 'box'                                                                                       , 'info': 'End current diversion.' }                                                                                                                                  ,
			\{ 'word': 'box'       , 'menu': 'box macro '                                                                                , 'info': 'Divert to macro, omitting a partially filled line.' }                                              ,
			\{ 'word': 'boxa'      , 'menu': 'boxa'                                                                                      , 'info': 'End current diversion.' }                                                                                                                                  ,
			\{ 'word': 'boxa'      , 'menu': 'boxa macro '                                                                               , 'info': 'Divert and append to macro, omitting a partially filled line.' }                                              ,
			\{ 'word': 'bp'        , 'menu': 'bp'                                                                                        , 'info': 'Eject current page and begin new page.' }                                                                                                                  ,
			\{ 'word': 'bp'        , 'menu': 'bp ±N'                                                                                     , 'info': 'Eject current page; next page number ±N.' }                                                                                                                ,
			\{ 'word': 'br'        , 'menu': 'br'                                                                                        , 'info': 'Line break.' }                                                                                                                                             ,
			\{ 'word': 'brp'       , 'menu': 'brp'                                                                                       , 'info': 'Break output line; adjust if applicable.' }                                                                                                                ,
			\{ 'word': 'break'     , 'menu': 'break'                                                                                     , 'info': 'Break out of a while loop.' }                                                                                                                              ,
			\{ 'word': 'c2'        , 'menu': 'c2'                                                                                        , 'info': 'Reset no-break control character to quotes ' }                                                                                                             ,
			\{ 'word': 'c2'        , 'menu': 'c2 c'                                                                                      , 'info': 'Set no-break control character to c.' }                                                                                                                    ,
			\{ 'word': 'cc'        , 'menu': 'cc'                                                                                        , 'info': 'Reset control character to ‘.’.' }                                                                                                                         ,
			\{ 'word': 'cc'        , 'menu': 'cc c'                                                                                      , 'info': 'Set control character to c.' }                                                                                                                             ,
			\{ 'word': 'ce'        , 'menu': 'ce'                                                                                        , 'info': 'Center the next input line.' }                                                                                                                             ,
			\{ 'word': 'ce'        , 'menu': 'ce N'                                                                                      , 'info': 'Center following N input lines.' }                                                                                                                         ,
			\{ 'word': 'cf'        , 'menu': 'cf filename '                                                                              , 'info': 'Copy contents of file filename unprocessed to stdout or to the diversion.' }                                                                               ,
			\{ 'word': 'cflags'    , 'menu': 'cflags mode c1 c2 ...'                                                                     , 'info': 'Treat characters c1, c2 , ... according to mode number.' }                                        ,
			\{ 'word': 'ch'        , 'menu': 'ch trap N '                                                                                , 'info': 'Change trap location to N.' }                                                                                                                              ,
			\{ 'word': 'char'      , 'menu': 'char c anything '                                                                          , 'info': 'Define entity c as string anything.' }                                                                                                                     ,
			\{ 'word': 'chop'      , 'menu': 'chop object '                                                                              , 'info': 'Chop the last character off macro, string, or diversion object.' }                                                 ,
			\{ 'word': 'class'     , 'menu': 'class name c1 c2 ...'                                                                      , 'info': 'Assign a set of characters, character ranges, or classes c1, c2, ... to name.' }                                                                                                      ,
			\{ 'word': 'close'     , 'menu': 'close stream '                                                                             , 'info': 'Close the stream.' }                                                                                                                                       ,
			\{ 'word': 'color'     , 'menu': 'color'                                                                                     , 'info': 'Enable colors.' }                                                                                                                                          ,
			\{ 'word': 'color'     , 'menu': 'color N'                                                                                   , 'info': 'If N is zero disable colors                                                                                                                                , otherwise enable them.' }                                                         ,
			\{ 'word': 'composite' , 'menu': 'composite from to '                                                                        , 'info': 'Map glyph name from to glyph name to while constructing a composite glyph name.' }                                                                         ,
			\{ 'word': 'continue'  , 'menu': 'continue'                                                                                  , 'info': 'Finish the current iteration of a while loop.' }                                                                                                           ,
			\{ 'word': 'cp'        , 'menu': 'cp'                                                                                        , 'info': 'Enable compatibility mode.' }                                                                                                                              ,
			\{ 'word': 'cp'        , 'menu': 'cp N'                                                                                      , 'info': 'If N is zero disable compatibility mode                                                                                                                    , otherwise enable it.' }                                                           ,
			\{ 'word': 'cs'        , 'menu': 'cs font N M '                                                                              , 'info': 'Set constant character width mode for font to N/36 ems with em M.' }                                                                                       ,
			\{ 'word': 'cu'        , 'menu': 'cu N'                                                                                      , 'info': 'Continuous underline in nroff                                                                                                                              , like .ul in troff.' }                                                             ,
			\{ 'word': 'da'        , 'menu': 'da'                                                                                        , 'info': 'End current diversion.' }                                                                                                                                  ,
			\{ 'word': 'da'        , 'menu': 'da macro'                                                                                  , 'info': 'Divert and append to macro.' }                                                                                                                             ,
			\{ 'word': 'de'        , 'menu': 'de macro'                                                                                  , 'info': 'Define or redefine macro until .. is encountered.' }                                                                                                       ,
			\{ 'word': 'de'        , 'menu': 'de macro end '                                                                             , 'info': 'Define or redefine macro until .end is called.' }                                                                                                          ,
			\{ 'word': 'de1'       , 'menu': 'de1 macro '                                                                                , 'info': 'Same as .de but with compatibility mode switched off during macro expansion.' }                                                                            ,
			\{ 'word': 'de1'       , 'menu': 'de1 macro end '                                                                            , 'info': 'Same as .de but with compatibility mode switched off during macro expansion.' }                                                                            ,
			\{ 'word': 'defcolor'  , 'menu': 'defcolor color scheme component '                                                          , 'info': 'Define or redefine a color with name color.  scheme can be rgb, cym, cymk, gray, or grey.  component can be single components specified as fractions in the range 0 to 1 (default scaling indicator f), as a string of two-digit hexadecimal color components with a leading #, or as a string of four-digit hexadecimal components with two leading #.  The color default cant be redefined.' },
			\{ 'word': 'dei'       , 'menu': 'dei macro '                                                                                , 'info': 'Define or redefine a macro whose name is contained in the string register macro until .. is encountered.' }                                                ,
			\{ 'word': 'dei'       , 'menu': 'dei macro end '                                                                            , 'info': 'Define or redefine a macro indirectly.  macro and end are string registers whose contents are interpolated for the macro name and the end macro, respectively.' }                                                                  ,
			\{ 'word': 'dei1'      , 'menu': 'dei1 macro '                                                                               , 'info': 'Same as .dei but with compatibility mode switched off during macro expansion.' }                                                                           ,
			\{ 'word': 'dei1'      , 'menu': 'dei1 macro end '                                                                           , 'info': 'Same as .dei but with compatibility mode switched off during macro expansion.' }                                                                           ,
			\{ 'word': 'device'    , 'menu': 'device anything '                                                                          , 'info': 'Write anything to the intermediate output as a device control function.' }                                                                                 ,
			\{ 'word': 'devicem'   , 'menu': 'devicem name '                                                                             , 'info': 'Write contents of macro or string name uninterpreted to the intermediate output as a device control function.' }                                           ,
			\{ 'word': 'di'        , 'menu': 'di'                                                                                        , 'info': 'End current diversion.' }                                                                                                                                  ,
			\{ 'word': 'di'        , 'menu': 'di macro Divert to macro.'                                                                 , 'info': 'See groff_tmac(5) for more details.' }                                                                                                                     ,
			\{ 'word': 'do'        , 'menu': 'do name'                                                                                   , 'info': 'Interpret .name with compatibility mode disabled.' }                                                                                                       ,
			\{ 'word': 'ds'        , 'menu': 'ds stringvar anything '                                                                    , 'info': 'Set stringvar to anything.' }                                                                                                                              ,
			\{ 'word': 'ds1'       , 'menu': 'ds1 stringvar anything '                                                                   , 'info': 'Same as .ds but with compatibility mode switched off during string expansion.' }                                                                           ,
			\{ 'word': 'dt'        , 'menu': 'dt N trap '                                                                                , 'info': 'Set diversion trap to position N (default scaling indicator v).' }                                                                                         ,
			\{ 'word': 'ec'        , 'menu': 'ec'                                                                                        , 'info': 'Reset escape character to ‘\’.' }                                                                                                                          ,
			\{ 'word': 'ec'        , 'menu': 'ec c'                                                                                      , 'info': 'Set escape character to c.' }                                                                                                                              ,
			\{ 'word': 'ecr'       , 'menu': 'ecr'                                                                                       , 'info': 'Restore escape character saved with .ecs.' }                                                                                                               ,
			\{ 'word': 'ecs'       , 'menu': 'ecs'                                                                                       , 'info': 'Save current escape character.' }                                                                                                                          ,
			\{ 'word': 'el'        , 'menu': 'el anything '                                                                              , 'info': 'Else part for if-else (.ie) request.' }                                                                                                                    ,
			\{ 'word': 'em'        , 'menu': 'em macro'                                                                                  , 'info': 'The macro is run after the end of input.' }                                                                                                                ,
			\{ 'word': 'eo'        , 'menu': 'eo'                                                                                        , 'info': 'Turn off escape character mechanism.' }                                                                                                                    ,
			\{ 'word': 'ev'        , 'menu': 'ev'                                                                                        , 'info': 'Switch to previous environment and pop it off the stack.' }                                                                                                ,
			\{ 'word': 'ev'        , 'menu': 'ev env'                                                                                    , 'info': 'Push down environment number or name env to the stack and switch to it.' }                                                                                 ,
			\{ 'word': 'evc'       , 'menu': 'evc env'                                                                                   , 'info': 'Copy the contents of environment env to the current environment.  No pushing or popping.' }                                                                ,
			\{ 'word': 'ex'        , 'menu': 'ex'                                                                                        , 'info': 'Exit from roff processing.' }                                                                                                                              ,
			\{ 'word': 'fam'       , 'menu': 'fam'                                                                                       , 'info': 'Return to previous font family.' }                                                                                                                         ,
			\{ 'word': 'fam'       , 'menu': 'fam name'                                                                                  , 'info': 'Set the current font family to name.' }                                                                                                                    ,
			\{ 'word': 'fc'        , 'menu': 'fc'                                                                                        , 'info': 'Disable field mechanism.' }                                                                                                                                ,
			\{ 'word': 'fc'        , 'menu': 'fc a'                                                                                      , 'info': 'Set field delimiter to a and pad glyph to space.' }                                                                                                        ,
			\{ 'word': 'fc'        , 'menu': 'fc a b'                                                                                    , 'info': 'Set field delimiter to a and pad glyph to b.' }                                                                                                            ,
			\{ 'word': 'fchar'     , 'menu': 'fchar c anything '                                                                         , 'info': 'Define fallback character (or glyph) c as string anything.' }                                                                                              ,
			\{ 'word': 'fcolor'    , 'menu': 'fcolor'                                                                                    , 'info': 'Set fill color to previous fill color.' }                                                                                                                  ,
			\{ 'word': 'fcolor'    , 'menu': 'fcolor c'                                                                                  , 'info': 'Set fill color to c.' }                                                                                                                                    ,
			\{ 'word': 'fi'        , 'menu': 'fi'                                                                                        , 'info': 'Fill output lines.' }                                                                                                                                      ,
			\{ 'word': 'fl'        , 'menu': 'fl'                                                                                        , 'info': 'Flush output buffer.' }                                                                                                                                    ,
			\{ 'word': 'fp'        , 'menu': 'fp n font '                                                                                , 'info': 'Mount font on position n.' }                                                                                                                               ,
			\{ 'word': 'fp'        , 'menu': 'fp n internal external'                                                                   , 'info': 'Mount font with long external name to short internal name on position n.' }                                                                                ,
			\{ 'word': 'fschar'    , 'menu': 'fschar f c anything'                                                                      , 'info': 'Define fallback character (or glyph) c for font f as string anything.' }                                                                                   ,
			\{ 'word': 'fspecial'  , 'menu': 'fspecial font '                                                                            , 'info': 'Reset list of special fonts for font to be empty.' }                                                                                                       ,
			\{ 'word': 'fspecial'  , 'menu': 'fspecial font s1 s2 ...'                                                                   , 'info': 'When the current font is font, then the fonts s1, s2, ... are special.' }     ,
			\{ 'word': 'ft'        , 'menu': 'ft'                                                                                        , 'info': 'Return to previous font.  Same as \ or \.' }                                                                                                               ,
			\{ 'word': 'ft'        , 'menu': 'ft font'                                                                                   , 'info': 'Change to font name or number font; same as \f[font] escape sequence.' }                                                                                   ,
			\{ 'word': 'ftr'       , 'menu': 'ftr font1 font2'                                                                          , 'info': 'Translate font1 to font2.' }                                                                                                                               ,
			\{ 'word': 'fzoom'     , 'menu': 'fzoom font'                                                                               , 'info': 'Dont magnify font.' }                                                                                                                                      ,
			\{ 'word': 'fzoom'     , 'menu': 'fzoom font zoom'                                                                          , 'info': 'Set zoom factor for font (in multiples of 1/1000th).' }                                                                                                    ,
			\{ 'word': 'gcolor'    , 'menu': 'gcolor'                                                                                    , 'info': 'Set glyph color to previous glyph color.' }                                                                                                                ,
			\{ 'word': 'gcolor'    , 'menu': 'gcolor c'                                                                                  , 'info': 'Set glyph color to c.' }                                                                                                                                   ,
			\{ 'word': 'hc'        , 'menu': 'hc'                                                                                        , 'info': 'Remove additional hyphenation indicator character.' }                                                                                                      ,
			\{ 'word': 'hc'        , 'menu': 'hc c'                                                                                      , 'info': 'Set up additional hyphenation indicator character c.' }                                                                                                    ,
			\{ 'word': 'hcode'     , 'menu': 'hcode c1 code1 [c2 code2] ...'                                                             , 'info': 'Set the hyphenation code of character c1 to code1, that of c2 to code2, etc.' }                                                                 ,
			\{ 'word': 'hla'       , 'menu': 'hla', 'info': 'lang Set the current hyphenation language to lang.' }                                  ,
			\{ 'word': 'hlm'       , 'menu': 'hlm n'                                                                                     , 'info': 'Set the maximum number of consecutive hyphenated lines to n.' }                                                                                            ,
			\{ 'word': 'hpf'       , 'menu': 'hpf file', 'info': 'Read hyphenation patterns from file.' }                                           ,
			\{ 'word': 'hpfa'      , 'menu': 'hpfa file'                                                                                , 'info': 'Append hyphenation patterns from file.' }                                                                                                                  ,
			\{ 'word': 'hpfcode'   , 'menu': 'hpfcode a b c d ...'                                                                       , 'info': 'Set input mapping for .hpf.' }                                                                                                                    ,
			\{ 'word': 'hw'        , 'menu': 'hw words'                                                                                  , 'info': 'List of words with exceptional hyphenation.' }                                                                                                             ,
			\{ 'word': 'hy'        , 'menu': 'hy N'                                                                                      , 'info': 'Switch to hyphenation mode N.' }                                                                                                                           ,
			\{ 'word': 'hym'       , 'menu': 'hym n'                                                                                     , 'info': 'Set the hyphenation margin to n (default scaling indicator m).' }                                                                                          ,
			\{ 'word': 'hys'       , 'menu': 'hys n'                                                                                     , 'info': 'Set the hyphenation space to n.' }                                                                                                                         ,
			\{ 'word': 'ie'        , 'menu': 'ie cond anything'                                                                         , 'info': 'If cond then anything else goto .el.' }                                                                                                                    ,
			\{ 'word': 'if'        , 'menu': 'if cond anything'                                                                         , 'info': 'If cond then anything; otherwise do nothing.' }                                                                                                            ,
			\{ 'word': 'ig'        , 'menu': 'ig'                                                                                        , 'info': 'Ignore text until .. is encountered.' }                                                                                                                    ,
			\{ 'word': 'ig'        , 'menu': 'ig end'                                                                                    , 'info': 'Ignore text until .end is called.' }                                                                                                                       ,
			\{ 'word': 'in'        , 'menu': 'in'                                                                                        , 'info': 'Change to previous indentation value.' }                                                                                                                   ,
			\{ 'word': 'in'        , 'menu': 'in ±N'                                                                                     , 'info': 'Change indentation according to ±N (default scaling indicator m).' }                                                                                       ,
			\{ 'word': 'it'        , 'menu': 'it N trap'                                                                                , 'info': 'Set an input-line count trap for the next N lines.' }                                                                                                      ,
			\{ 'word': 'itc'       , 'menu': 'itc N trap'                                                                               , 'info': 'Same as .it but dont count lines interrupted with \c.' }                                                                                                   ,
			\{ 'word': 'kern'      , 'menu': 'kern'                                                                                      , 'info': 'Enable pairwise kerning.' }                                                                                                                                ,
			\{ 'word': 'kern'      , 'menu': 'kern n'                                                                                    , 'info': 'If n is zero, disable pairwise kerning, otherwise enable it.' }                                                 ,
			\{ 'word': 'lc'        , 'menu': 'lc'                                                                                        , 'info': 'Remove leader repetition glyph.' }                                                                                                                         ,
			\{ 'word': 'lc'        , 'menu': 'lc c'                                                                                      , 'info': 'Set leader repetition glyph to c.' }                                                                                                                       ,
			\{ 'word': 'length'    , 'menu': 'length register anything'                                                                 , 'info': 'Write the length of the string anything to register.' }                                                                                                    ,
			\{ 'word': 'linetabs'  , 'menu': 'linetabs' ,'info': 'Enable line-tabs mode (i.e., calculate tab positions relative to output line).' }                                                                                                                ,
			\{ 'word': 'linetabs'  , 'menu': 'linetabs n'                                                                               , 'info': 'If n is zero, disable line-tabs mode, otherwise enable it.' }                                                 ,
			\{ 'word': 'lf'        , 'menu': 'lf N'                                                                                      , 'info': 'Set input line number to N.' }                                                                                                                             ,
			\{ 'word': 'lf'        , 'menu': 'lf N file'                                                                                , 'info': 'Set input line number to N and filename to file.' }                                                                                                        ,
			\{ 'word': 'lg'        , 'menu': 'lg N'                                                                                      , 'info': 'Ligature mode on if N>0.' }                                                                                                                                ,
			\{ 'word': 'll'        , 'menu': 'll'                                                                                        , 'info': 'Change to previous line length.' }                                                                                                                         ,
			\{ 'word': 'll'        , 'menu': 'll ±N'                                                                                     , 'info': 'Set line length according to ±N (default length 6.5i, default scaling indicator m).' }                                                  ,
			\{ 'word': 'lsm'       , 'menu': 'lsm'                                                                                       , 'info': 'Unset the leading spaces macro.' }                                                                                                                         ,
			\{ 'word': 'lsm'       , 'menu': 'lsm macro'                                                                                , 'info': 'Set the leading spaces macro to macro.' }                                                                                                                  ,
			\{ 'word': 'ls'        , 'menu': 'ls'                                                                                        , 'info': 'Change to the previous value of additional intra-line skip.' }                                                                                             ,
			\{ 'word': 'ls'        , 'menu': 'ls N'                                                                                      , 'info': 'Set additional intra-line skip value to N, i.e., N-1 blank lines are inserted after each text output line.' }            ,
			\{ 'word': 'lt'        , 'menu': 'lt ±N'                                                                                     , 'info': 'Length of title (default scaling indicator m).' }                                                                                                          ,
			\{ 'word': 'mc'        , 'menu': 'mc'                                                                                        , 'info': 'Margin glyph off.' }                                                                                                                                       ,
			\{ 'word': 'mc'        , 'menu': 'mc c'                                                                                      , 'info': 'Print glyph c after each text line at actual distance from right margin.' }                                                                                ,
			\{ 'word': 'mc'        , 'menu': 'mc c N'                                                                                    , 'info': 'Set margin glyph to c and distance to N from right margin (default scaling indicator m).' }                                                                ,
			\{ 'word': 'mk'        , 'menu': 'mk [register] '                                                                            , 'info': 'Mark current vertical position in register, or in an internal register used by .rt if no argument.' }                         ,
			\{ 'word': 'mso'       , 'menu': 'mso file'                                                                                  , 'info': 'The same as .so except that file is searched in the tmac directories.' }                                                                                   ,
			\{ 'word': 'na'        , 'menu': 'na'                                                                                        , 'info': 'No output-line adjusting.' }                                                                                                                               ,
			\{ 'word': 'ne'        , 'menu': 'ne'                                                                                        , 'info': 'Need a one-line vertical space.' }                                                                                                                         ,
			\{ 'word': 'ne'        , 'menu': 'ne N'                                                                                      , 'info': 'Need N vertical space (default scaling indicator v).' }                                                                                                    ,
			\{ 'word': 'nf'        , 'menu': 'nf'                                                                                        , 'info': 'No filling or adjusting of output lines.' }                                                                                                                ,
			\{ 'word': 'nh'        , 'menu': 'nh'                                                                                        , 'info': 'No hyphenation.' }                                                                                                                                         ,
			\{ 'word': 'nm'        , 'menu': 'nm'                                                                                        , 'info': 'Number mode off.' }                                                                                                                                        ,
			\{ 'word': 'nm'        , 'menu': 'nm ±N [M [S [I]]] '                                                                        , 'info': 'In line number mode, set number, multiple, spacing, and indentation.' }                                                                                                  ,
			\{ 'word': 'nn'        , 'menu': 'nn'                                                                                        , 'info': 'Do not number next line.' }                                                                                                                                ,
			\{ 'word': 'nn'        , 'menu': 'nn N'                                                                                      , 'info': 'Do not number next N lines.' }                                                                                                                             ,
			\{ 'word': 'nop'       , 'menu': 'nop anything'                                                                             , 'info': 'Always process anything.' }                                                                                                                                ,
			\{ 'word': 'nr'        , 'menu': 'nr register ±N [M] '                                                                       , 'info': 'Define or modify register using ±N with auto-increment M.' }                                                                                               ,
			\{ 'word': 'nroff'     , 'menu': 'nroff'                                                                                     , 'info': 'Make the built-in conditions n true and t false.' }                                                                                                        ,
			\{ 'word': 'ns'        , 'menu': 'ns'                                                                                        , 'info': 'Turn on no-space mode.' }                                                                                                                                  ,
			\{ 'word': 'nx'        , 'menu': 'nx'                                                                                        , 'info': 'Immediately jump to end of current file.' }                                                                                                                ,
			\{ 'word': 'nx'        , 'menu': 'nx filename'                                                                              , 'info': 'Immediately continue processing with file file.' }                                                                                                         ,
			\{ 'word': 'open'      , 'menu': 'open stream filename'                                                                     , 'info': 'Open filename for writing and associate the stream named stream with it.' }                                                                                ,
			\{ 'word': 'opena'     , 'menu': 'opena stream filename'                                                                    , 'info': 'Like .open but append to it.' }                                                                                                                            ,
			\{ 'word': 'os'        , 'menu': 'os'                                                                                        , 'info': 'Output vertical distance that was saved by the sv request.' }                                                                                              ,
			\{ 'word': 'output'    , 'menu': 'output string'                                                                            , 'info': 'Emit string directly to intermediate output, allowing leading whitespace if string starts with " (which is stripped off).' }   ,
			\{ 'word': 'pc'        , 'menu': 'pc'                                                                                        , 'info': 'Reset page number character to ‘%’.' }                                                                                                                     ,
			\{ 'word': 'pc'        , 'menu': 'pc c'                                                                                      , 'info': 'Page number character.' }                                                                                                                                  ,
			\{ 'word': 'pev'       , 'menu': 'pev'                                                                                       , 'info': 'Print the current environment and each defined environment state to stderr.' }                                                                             ,
			\{ 'word': 'pi'        , 'menu': 'pi program'                                                                               , 'info': 'Pipe output to program (nroff only).' }                                                                                                                    ,
			\{ 'word': 'pl'        , 'menu': 'pl'                                                                                        , 'info': 'Set page length to default 11i.  The current page length is stored in register .p.' }                                                                      ,
			\{ 'word': 'pl'        , 'menu': 'pl ±N'                                                                                     , 'info': 'Change page length to ±N (default scaling indicator v).' }                                                                                                 ,
			\{ 'word': 'pm'        , 'menu': 'pm'                                                                                        , 'info': 'Print macro names and sizes (number of blocks of 128 bytes).' }                                                                                            ,
			\{ 'word': 'pm'        , 'menu': 'pm t'                                                                                      , 'info': 'Print only total of sizes of macros (number of 128 bytes blocks).' }                                                                                       ,
			\{ 'word': 'pn'        , 'menu': 'pn ±N'                                                                                     , 'info': 'Next page number N.' }                                                                                                                                     ,
			\{ 'word': 'pnr'       , 'menu': 'pnr'                                                                                       , 'info': 'Print the names and contents of all currently defined number registers on stderr.' }                                                                       ,
			\{ 'word': 'po'        , 'menu': 'po'                                                                                        , 'info': 'Change to previous page offset.  The current page offset is available in register .o.' }                                                                   ,
			\{ 'word': 'po'        , 'menu': 'po ±N'                                                                                     , 'info': 'Page offset N.' }                                                                                                                                          ,
			\{ 'word': 'ps'        , 'menu': 'ps'                                                                                        , 'info': 'Return to previous point size.' }                                                                                                                          ,
			\{ 'word': 'ps'        , 'menu': 'ps ±N'                                                                                     , 'info': 'Point size; same as \s[±N].' }                                                                                                                             ,
			\{ 'word': 'psbb'      , 'menu': 'psbb filename'                                                                            , 'info': 'Get the bounding box of a PostScript image filename.' }                                                                                                    ,
			\{ 'word': 'pso'       , 'menu': 'pso command'                                                                              , 'info': 'This behaves like the so request except that input comes from the standard output of command.' }                                                           ,
			\{ 'word': 'ptr'       , 'menu': 'ptr'                                                                                       , 'info': 'Print the names and positions of all traps (not including input line traps and diversion traps) on stderr.' }                                              ,
			\{ 'word': 'pvs'       , 'menu': 'pvs'                                                                                       , 'info': 'Change to previous post-vertical line spacing.' }                                                                                                          ,
			\{ 'word': 'pvs'       , 'menu': 'pvs ±N'                                                                                    , 'info': 'Change post-vertical line spacing according to ±N (default scaling indicator p).' }                                                                        ,
			\{ 'word': 'rchar'     , 'menu': 'rchar c1 c2 ...'                                                                           , 'info': 'Remove the definitions of entities c1, c2, ...' }                                                                  ,
			\{ 'word': 'rd'        , 'menu': 'rd prompt'                                                                                , 'info': 'Read insertion.' }                                                                                                                                         ,
			\{ 'word': 'return'    , 'menu': 'return'                                                                                    , 'info': 'Return from a macro.' }                                                                                                                                    ,
			\{ 'word': 'return'    , 'menu': 'return anything'                                                                          , 'info': 'Return twice, namely from the macro at the current level and from the macro one level higher.' },
			\{ 'word': 'rfschar'   , 'menu': 'rfschar f c1 c2 ...'                                                                       , 'info': 'Remove the definitions of entities c1, c2, ... for font f.' }                                                      ,
			\{ 'word': 'rj'        , 'menu': 'rj n'                                                                                      , 'info': 'Right justify the next n input lines.' }                                                                                                                   ,
			\{ 'word': 'rm'        , 'menu': 'rm name'                                                                                   , 'info': 'Remove request, macro, diversion, or string name.' }      ,
			\{ 'word': 'rn'        , 'menu': 'rn old new'                                                                               , 'info': 'Rename request, macro, diversion, or string old to new.' },
			\{ 'word': 'rnn'       , 'menu': 'rnn reg1 reg2'                                                                            , 'info': 'Rename register reg1 to reg2.' }                                                                                                                           ,
			\{ 'word': 'rr'        , 'menu': 'rr register'                                                                              , 'info': 'Remove register.' }                                                                                                                                        ,
			\{ 'word': 'rs'        , 'menu': 'rs'                                                                                        , 'info': 'Restore spacing; turn no-space mode off.' }                                                                                                                ,
			\{ 'word': 'rt'        , 'menu': 'rt'                                                                                        , 'info': 'Return (upward only) to vertical position marked by .mk on the current page.' }                                                                            ,
			\{ 'word': 'rt'        , 'menu': 'rt ±N'                                                                                     , 'info': 'Return (upward only) to specified distance from the top of the page (default scaling indicator v).' }                                                      ,
			\{ 'word': 'schar'     , 'menu': 'schar c anything'                                                                         , 'info': 'Define global fallback character (or glyph) c as string anything.' }                                                                                       ,
			\{ 'word': 'shc'       , 'menu': 'shc'                                                                                       , 'info': 'Reset soft hyphen glyph to \(hy.' }                                                                                                                        ,
			\{ 'word': 'shc'       , 'menu': 'shc c'                                                                                     , 'info': 'Set the soft hyphen glyph to c.' }                                                                                                                         ,
			\{ 'word': 'shift'     , 'menu': 'shift n'                                                                                   , 'info': 'In a macro, shift the arguments by n positions.' }                                            ,
			\{ 'word': 'sizes'     , 'menu': 'sizes s1 s2 ... sn [0] '                                                                   , 'info': 'Set available font sizes similar to the sizes command in a DESC file.' }                                                                                   ,
			\{ 'word': 'so'        , 'menu': 'so filename'                                                                              , 'info': 'Include source file.' }                                                                                                                                    ,
			\{ 'word': 'sp'        , 'menu': 'sp'                                                                                        , 'info': 'Skip one line vertically.' }                                                                                                                               ,
			\{ 'word': 'sp'        , 'menu': 'sp N'                                                                                      , 'info': 'Space vertical distance N up or down according to sign of N (default scaling indicator v).' }                                                              ,
			\{ 'word': 'special'   , 'menu': 'special'                                                                                   , 'info': 'Reset global list of special fonts to be empty.' }                                                                                                         ,
			\{ 'word': 'special'   , 'menu': 'special s1 s2 ...'                                                                         , 'info': 'Fonts s1, s2, etc. are special and are searched for glyphs not in the current font.' },
			\{ 'word': 'spreadwarn', 'menu': 'spreadwarn'                                                                               , 'info': 'Toggle the spread warning on and off without changing its value.' }                                                                                        ,
			\{ 'word': 'spreadwarn', 'menu': 'spreadwarn limit'                                                                         , 'info': 'Emit a warning if each space in an output line is widened by limit or more (default scaling indicator m).' }                                               ,
			\{ 'word': 'ss'        , 'menu': 'ss N'                                                                                      , 'info': 'Set space glyph size to N/12 of the space width in the current font.' }                                                                                    ,
			\{ 'word': 'ss'        , 'menu': 'ss N M'                                                                                    , 'info': 'Set space glyph size to N/12 and sentence space size set to M/12 of the space width in the current font.' }                                                ,
			\{ 'word': 'sty'       , 'menu': 'sty n style'                                                                              , 'info': 'Associate style with font position n.' }                                                                                                                   ,
			\{ 'word': 'substring' , 'menu': 'substring xx n1 n2'                                                                       , 'info': 'Replace the string named xx with the substring defined by the indices n1 and n2.' }                                                                        ,
			\{ 'word': 'sv'        , 'menu': 'sv'                                                                                        , 'info': 'Save 1 v of vertical space.' }                                                                                                                             ,
			\{ 'word': 'sv'        , 'menu': 'sv N'                                                                                      , 'info': 'Save the vertical distance N for later output with os request (default scaling indicator v).' }                                                            ,
			\{ 'word': 'sy'        , 'menu': 'sy command-line'                                                                          , 'info': 'Execute program command-line.' }                                                                                                                           ,
			\{ 'word': 'ta'        , 'menu': 'ta T N'                                                                                    , 'info': 'Set tabs after every position that is a multiple of N (default scaling indicator m).' }                                                                    ,
			\{ 'word': 'ta'        , 'menu': 'ta n1 n2 ... nn T r1 r2 ... rn'                                                           , 'info': 'Set tabs at positions n1, n2, ..., nn, then set tabs at nn+m×rn+r1 through nn+m×rn+rn, where m increments from 0, 1, 2, ... to infinity.' },
			\{ 'word': 'tc'        , 'menu': 'tc'                                                                                        , 'info': 'Remove tab repetition glyph.' }                                                                                                                            ,
			\{ 'word': 'tc'        , 'menu': 'tc c'                                                                                      , 'info': 'Set tab repetition glyph to c.' }                                                                                                                          ,
			\{ 'word': 'ti'        , 'menu': 'ti ±N'                                                                                     , 'info': 'Temporary indent next line (default scaling indicator m).' }                                                                                               ,
			\{ 'word': 'tkf'       , 'menu': 'tkf font s1 n1 s2 n2'                                                                     , 'info': 'Enable track kerning for font.' }                                                                                                                          ,
			\{ 'word': 'tl'        , 'menu': 'tl ’left’center’right'                                                                    , 'info': 'Three-part title.' }                                                                                                                                       ,
			\{ 'word': 'tm'        , 'menu': 'tm anything'                                                                               , 'info': 'Print anything on stderr.' }                                                                                                                               ,
			\{ 'word': 'tm1'       , 'menu': 'tm1 anything'                                                                             , 'info': 'Print anything on stderr, allowing leading whitespace if anything starts with " (which is stripped off).' } ,
			\{ 'word': 'tmc'       , 'menu': 'tmc anything'                                                                             , 'info': 'Similar to .tm1 without emitting a final newline.' }                                                                                                       ,
			\{ 'word': 'tr'        , 'menu': 'tr abcd...'                                                                                , 'info': 'Translate a to b, c to d, etc. on output.' }                                                      ,
			\{ 'word': 'trf'       , 'menu': 'trf filename '                                                                             , 'info': 'Transparently output the contents of file filename.' }                                                                                                     ,
			\{ 'word': 'trin'      , 'menu': 'trin abcd...'                                                                              , 'info': 'This is the same as the tr request except that the asciify request uses the character code (if any) before the character translation.' }          ,
			\{ 'word': 'trnt'      , 'menu': 'trnt abcd...'                                                                              , 'info': 'This is the same as the tr request except that the translations do not apply to text that is transparently throughput into a diversion with \!.' },
			\{ 'word': 'troff'     , 'menu': 'troff'                                                                                     , 'info': 'Make the built-in conditions t true and n false.' }                                                                                                        ,
			\{ 'word': 'uf'        , 'menu': 'uf font'                                                                                   , 'info': 'Set underline font to font (to be switched to by .ul).' }                                                                                                  ,
			\{ 'word': 'ul'        , 'menu': 'ul N'                                                                                      , 'info': 'Underline (italicize in troff) N input lines.' }                                                                                                           ,
			\{ 'word': 'unformat'  , 'menu': 'unformat diversion '                                                                       , 'info': 'Unformat space characters and tabs in diversion, preserving font information.' }                                                   ,
			\{ 'word': 'vpt'       , 'menu': 'vpt n'                                                                                     , 'info': 'Enable vertical position traps if n is non-zero, disable them otherwise.' }                                                        ,
			\{ 'word': 'vs'        , 'menu': 'vs'                                                                                        , 'info': 'Change to previous vertical base line spacing.' }                                                                                                          ,
			\{ 'word': 'vs'        , 'menu': 'vs ±N'                                                                                     , 'info': 'Set vertical base line spacing to ±N (default scaling indicator p).' }                                                                                     ,
			\{ 'word': 'warn'      , 'menu': 'warn n'                                                                                    , 'info': 'Set warnings code to n.' }                                                                                                                                 ,
			\{ 'word': 'warnscale' , 'menu': 'warnscale si '                                                                             , 'info': 'Set scaling indicator used in warnings to si.' }                                                                                                           ,
			\{ 'word': 'wh'        , 'menu': 'wh N'                                                                                      , 'info': 'Remove (first) trap at position N.' }                                                                                                                      ,
			\{ 'word': 'wh'        , 'menu': 'wh N trap '                                                                                , 'info': 'Set location trap; negative means from page bottom.' }                                                                                                     ,
			\{ 'word': 'while'     , 'menu': 'while cond anything '                                                                      , 'info': 'While condition cond is true, accept anything as input.' }                                                      ,
			\{ 'word': 'write'     , 'menu': 'write stream anything '                                                                    , 'info': 'Write anything to the stream named stream.' }                                                                                                              ,
			\{ 'word': 'writec'    , 'menu': 'writec stream anything '                                                                   , 'info': 'Similar to .write without emitting a final newline.' }                                                                                                     ,
			\{ 'word': 'writem'    , 'menu': 'writem stream xx '                                                                         , 'info': 'Write contents of macro or string xx to the stream named stream.' }                                                                                        ,
			\]

let s:general_macros = [
			\{ 'word': 'EQ', 'icase': 1 },
			\{ 'word': 'TS', 'icase': 1 },
			\{ 'word': 'PS', 'icase': 1 },
			\{ 'word': 'G1', 'icase': 1 },
			\{ 'word': 'G2', 'icase': 1 },
			\{ 'word': 'PSPIC', 'icase': 1 }
			\]

" TODO: add support for more macros <13-07-20 Gavin Jaeger-Freeborn>
let s:mom_prestart_macros = [ 
			\{ 'word': 'TITLE "', 'icase': 1 },
			\{ 'word': 'SUBTITLE "', 'icase': 1 },
			\{ 'word': 'AUTHOR "', 'icase': 1 },
			\{ 'word': 'PRINTSTYLE', 'icase': 1 },
			\{ 'word': 'COPYRIGHT', 'icase': 1 },
			\{ 'word': 'COVERTITLE "', 'icase': 1 },
			\{ 'word': 'HEADING_STYLE', 'icase': 1 },
			\{ 'word': 'COPYRIGHT_STYLE', 'icase': 1 },
			\{ 'word': 'CHAPTER', 'icase': 1 },
			\{ 'word': 'CHAPTER_TITLE "', 'icase': 1 },
			\{ 'word': 'DRAFT', 'icase': 1 },
			\{ 'word': 'REVISION', 'icase': 1 },
			\{ 'word': 'DOCTYPE', 'icase': 1 },
			\{ 'word': 'COPYSTYLE', 'icase': 1 },
			\{ 'word': 'FAMILY', 'icase': 1 },
			\{ 'word': 'PT_SIZE', 'icase': 1 },
			\{ 'word': 'START', 'icase': 1 },
			\{ 'word': 'DOC_COVERTITLE "', 'icase': 1 },
			\{ 'word': 'PDF_TITLE "', 'icase': 1 },
			\{ 'word': 'TOC_HEADING "', 'icase': 1 },
			\{ 'word': 'L_MARGIN', 'icase': 1 },
			\{ 'word': 'R_MARGIN',  'icase': 1 }
			\]

let s:mom_style_options = [
			\{ 'word': 'FAMILY', 'icase': 1 },
			\{ 'word': 'FONT', 'icase': 1 },
			\{ 'word': 'UNDERSCORE', 'icase': 1 },
			\{ 'word': 'SIZE', 'icase': 1 },
			\{ 'word': 'COLOR', 'icase': 1 },
			\{ 'word': 'QUAD', 'icase': 1 },
			\{ 'word': 'SPACE_ABOVE', 'icase': 1 },
			\{ 'word': 'SPACE_BENEATH',  'icase': 1 }
			\]
let s:mom_poststart_macros = [
			\{ 'word': 'HEADING', 'icase': 1 },
			\{ 'word': 'PP', 'icase': 1 },
			\{ 'word': 'LINEBREAK', 'icase': 1 },
			\{ 'word': 'SECTION', 'icase': 1 },
			\{ 'word': 'LIST', 'icase': 1 },
			\{ 'word': 'ITEM', 'icase': 1 },
			\{ 'word': 'PP_FONT', 'icase': 1 },
			\{ 'word': 'PARA_INDENT', 'icase': 1 },
			\{ 'word': 'EPIGRAPH', 'icase': 1 },
			\{ 'word': 'EL',  'icase': 1 }
			\]
let s:mom_heading_options = [ 
			\{ 'word': 'NUMBER',  'icase': 1 },
			\]
let s:mom_poststart_toggle_macros = [ 
			\{ 'word': 'QUOTE', 'icase': 1 },
			\{ 'word': 'FLOAT', 'icase': 1 },
			\{ 'word': 'BLOCKQUOTE', 'icase': 1 },
			\{ 'word': 'CODE', 'icase': 1 },
			\{ 'word': 'JUSTIFY', 'icase': 1 },
			\{ 'word': 'FOOTNOTE', 'icase': 1 },
			\]

let s:ms_macros = [
			\{ 'word': 'NH', 'icase': 1 },
			\{ 'word': 'SH', 'icase': 1 },
			\{ 'word': 'PP', 'icase': 1 },
			\{ 'word': 'LP', 'icase': 1 },
			\{ 'word': 'B' , 'icase': 1 },
			\{ 'word': 'R' , 'icase': 1 },
			\{ 'word': 'I' , 'icase': 1 },
			\{ 'word': 'CW', 'icase': 1 },
			\{ 'word': 'BI', 'icase': 1 },
			\{ 'word': 'UL', 'icase': 1 },
			\{ 'word': 'LG', 'icase': 1 },
			\{ 'word': 'SM', 'icase': 1 },
			\{ 'word': 'IP', 'icase': 1 },
			\{ 'word': 'KS', 'icase': 1 },
			\{ 'word': 'KE', 'icase': 1 },
			\{ 'word': 'RS', 'icase': 1 },
			\{ 'word': 'RE', 'icase': 1 },
			\{ 'word': 'TL', 'icase': 1 },
			\{ 'word': 'BX', 'icase': 1 },
			\{ 'word': 'B1', 'icase': 1 },
			\{ 'word': 'B2', 'icase': 1 }
			\]

let s:font = [
			\{ 'word': 'B', 'icase': 1 },
			\{ 'word': 'I', 'icase': 1 },
			\{ 'word': 'BI', 'icase': 1 },
			\{ 'word': 'R', 'icase': 1 },
			\{ 'word': 'P', 'icase': 1 }
			\]
let s:registers = [
			\{ 'word': 'PS', 'icase': 1 },
			\{ 'word': 'VS', 'icase': 1 },
			\{ 'word': 'PSINCR', 'icase': 1 },
			\{ 'word': 'GROWPS', 'icase': 1 }
			\]
let s:strings = ['ce']

let s:macros = s:general_macros + s:base_macros

" Preprocessors
let s:eqn = [ 'sub', 'sup', 'sum', 'from', 'to', 'times', 'approx', 'int', 'inf', 'alpha', 'beta', 'ccol', 'matrix', 'pile', 'left', 'right', 'mark', 'lineup' ]


" TODO: add pic commands and arguments <13-07-20 Gavin Jaeger-Freeborn>
" you can find more of them at /home/gavinok/groff/doc/pic.pdf
let s:pic_closed_objects = [ 'box', 'circle', 'ellipse' ]
let s:pic_open_objects = [ 'arc', 'line', 'arrow', 'spline' ]
let s:pic_circle_attribute = [ 'diam', 'rad']
let s:pic_closed_objects_attribute = [ 'ht', 'wid', 'solid']
let s:pic_open_objects_attribute = [ 'from', 'to']
let s:pic_objects_attribute = [ 'colored', 'shaded', 'outlined', 'invis', 'dotted', 'dashed']
let s:pic_directions = ['down', 'up', 'right', 'left']
let s:pic_options = [ 'dashed', 'inves', 'at (' ]
let s:pic_expressions = [
			\{ 'word': 'sin(', 'info': 'sin(x)' },
			\{ 'word': 'cos(', 'info': 'cos(x)' },
			\{ 'word': 'atan2(', 'info': 'atan2(y, x)' },
			\{ 'word': 'log(x)', 'info': 'log(x) (base 10)' },
			\{ 'word': 'exp(x)', 'info': 'exp(x) (base 10, i.e. 10^x)' },
			\{ 'word': 'sqrt(', 'info': 'sqrt(x)' },
			\{ 'word': 'int(', 'info': 'int(x)' },
			\{ 'word': 'rand()', 'info': 'rand() (return a random number between 0 and 1)' },
			\{ 'word': 'rand(', 'info': 'rand(x) (return a random number between 1 and x; deprecated)' },
			\{ 'word': 'srand(', 'info': 'srand(x) (set the random number seed)' },
			\{ 'word': 'max(', 'info': 'max(e1, e2)' },
			\{ 'word': 'min(', 'info': 'min(e1, e2)' },
			\]

let s:pic = s:pic_closed_objects + s:pic_open_objects
let s:tbl = ['allbox', 'box', 'center', 'delim(', 'doublebox', 'expand', 'frame', 'linesize(', ]
let s:gnu_tbl = [ 'decimapoint(', 'nokeep', 'nospaces', 'nowarn', 'tab(' ]

function! CheckMacros()
	if search('^\.\s*START\s*', 'bnW') > 0
		return 'mom_poststart'
	elseif search('^\.\s*START\s*', 'nW') > 0 || expand('%:e') ==# 'mom'
		return 'mom_prestart'
	elseif search('^\.\s*\(UL\|TL\|NH\|XP\|XN\)\s*', 'bnw') > 0 || expand('%:e') ==# 'ms'
		return 'ms'
	elseif search('^\.\s*[ilnp]p\s*', 'bnw') > 0 || expand('%:e') ==# 'ms'
		return 'me'
	endif
endfunction

function! PicComplete(context)

	"
	let object = matchstr(a:context, '^\zs\k\+\ze\s\+$')
	if object =~ '\(box\|circle\|ellipse\)'
		return s:pic_closed_objects_attribute + s:pic_objects_attribute + s:pic_options
	elseif object =~ '\(arc\|line\|arrow\|spline\)'
		return s:pic_open_objects_attribute + s:pic_objects_attribute + s:pic_options
	endif
	" if a:context =~? '\(^\|^.*;\)$'
	return s:pic_open_objects + s:pic_closed_objects + s:pic_directions
	" endif
	return [] 
endfunction

" Omnifunc for use with groff (currently only supports ms macros)
fun! GroffOmnifunc(findstart, base)
	if a:findstart
		" set filetype
		let line = getline('.')
		let start = col('.') - 1
		let curline = line('.')
		let compl_begin = col('.') - 2
		while start >= 0 && line[start - 1] =~? '\k'
			let start -= 1
		endwhile
		let b:compl_context = getline('.')[0:compl_begin]
		return start
	else
		" calling a macro
		let res = []
		let res2 = []
		" a:base is very short - we need context
		" Shortcontext is context without a:base, useful for checking if we are
		" looking for objects and for what objects we are looking for
		let context = b:compl_context
		let shortcontext = substitute(context, a:base.'$', '', '')
		unlet! b:compl_context
		" echoerr a:base
		" echoerr shortcontext

		" let object = matchstr(shortcontext, '^\.\s*\zs\k\+\ze\s\+$')

		" if len(object) > 0
		" 	if search(object.'\s*\s*', 'bn') > 0
		" 		let object_type = 'Register'
		" 	elseif search(object.'\.\s*ds\s*', 'bn') > 0
		" 		let object_type = 'String'
		" 	elseif search(object.'\.\s*', 'bn') > 0
		" 		let object_type = 'Macro'
		" 	endif
		" endif

		" if !exists('object_type')
		" 	let object_type = ''
		" endif

		" if object_type == 'Macro'
		" 	let values = s:macros
		" elseif object_type == 'String'
		" 	let values = s:strings
		" elseif object_type == 'Register'
		" 	let values = s:registers
		" elseif object_type == 'Object'
		" 	let values = s:objes
		" endif
		let [line, col] = [line('.'), col('.')]
		let syntype = reverse(map(synstack(line, col), 'synIDattr(v:val,"name")'))
		for synt in syntype
			if synt ==# 'nroffEquation'
				let values = s:eqn
				if shortcontext =~? '\.\s*$'
					let values = [ { 'word': 'EN', 'icase': 1 } ]
				endif
			elseif synt ==# 'nroffTable'
				let values = s:tbl
				if shortcontext =~? '\.\s*$'
					let values = [ { 'word': 'TE', 'icase': 1 } ]
				endif
			elseif synt ==# 'nroffPicture'
				let values = PicComplete(shortcontext)
				if shortcontext =~? '\.\s*$'
					let values = [ { 'word': 'PE', 'icase': 1 } ]
				endif
				if values == [] | unlet values | endif
			endif
		endfor

		" add to the end of the completion
		if !exists('values')
			if shortcontext =~? '\.\s*$'
				let ft = CheckMacros()
				if exists('ft')
					if ft ==# 'mom_poststart'
						let s:macros = s:mom_poststart_macros + s:mom_poststart_toggle_macros + s:general_macros + s:base_macros
					elseif ft ==# 'mom_prestart'
						let s:macros = s:mom_prestart_macros + s:general_macros + s:base_macros
					elseif ft == 'ms'
						let s:macros = s:ms_macros + s:general_macros + s:base_macros
					endif
					let values = s:macros
				endif
			elseif shortcontext =~# '\\f$'
				let values = s:font
			elseif shortcontext =~# '\\f\([\|(\)$'
				let values = s:font
			elseif shortcontext =~? '\\[$'
				let values = GroffcompleteCandidates()
				if values == [] | unlet values | endif
			elseif shortcontext =~# '^\.\s*nr\s\+$'
				let values = s:registers
			elseif shortcontext =~# '^\\n$'
				let values = s:registers
			elseif shortcontext =~# '^\\n\([\|(\)$'
				let values = s:registers
			elseif shortcontext =~# '^\.\s*ds\s\+$'
				let values = s:strings
			elseif shortcontext =~# '\\s$'
				let values = s:strings
			elseif shortcontext =~# '\\s\([\|(\)$'
				let values = s:strings
			endif
		endif

		if exists('values')
			for m in values
				if type(m) ==# v:t_dict
					if m['word'] =~? '^'.a:base
						call add(res, m)
					endif
				elseif m =~? '^'.a:base
					call add(res, m)
				endif
			endfor
			return res + res2
		endif
	endif
endfunction

setlocal omnifunc=GroffOmnifunc

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

	" let macro = CheckMacros()
	Man 7 groff
endfunction
inoreabbrev <buffer> linup lineup
inoreabbrev <buffer> abvoe above

inoremap T{<CR> T{<CR>T}<c-o><s-o>


" prevent indenting anything
let b:surround_indent = 1
let b:surround_102 = "\\f[\1environment: \1]\r\\f[P]"
let b:surround_92 = "\\[\r]"
let b:surround_69 = ".EQ\r.EN"
let b:surround_67 = ".CD\r.DE"
let b:surround_75 = ".KS\r.KE"


augroup AUTOCOMP
	autocmd!
	try

		autocmd BufWrite <buffer> :silent! Make!
	catch /.*/
		echo 'busy'
	endtry
augroup END
let b:autocompile = 1
