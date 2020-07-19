" File: groff.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Wed 22 Apr 2020 06:41:12 PM
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" extended syntax support for groff

fun! s:GroffConceal(group,pat,cchar)
	exe 'syn match '.a:group." '".a:pat."' contained conceal cchar=".a:cchar
endfun
 
if exists('g:groff_greek')
	call s:GroffConceal('roffGreek'  ,'\<alpha\>'		      ,'α')
	call s:GroffConceal('roffGreek'  ,'\<beta\>'		      ,'β')
	call s:GroffConceal('roffGreek'  ,'\<gamma\>'		      ,'γ')
	call s:GroffConceal('roffGreek'  ,'\<delta\>'		      ,'δ')
	call s:GroffConceal('roffGreek'  ,'\<epsilon\>'		      ,'ϵ')
	call s:GroffConceal('roffGreek'  ,'\<varepsilon\>'	      ,'ε')
	call s:GroffConceal('roffGreek'  ,'\<zeta\>'		      ,'ζ')
	call s:GroffConceal('roffGreek'  ,'\<eta\>'		          ,'η')
	call s:GroffConceal('roffGreek'  ,'\<theta\>'		      ,'θ')
	call s:GroffConceal('roffGreek'  ,'\<vartheta\>'	      ,'ϑ')
	call s:GroffConceal('roffGreek'  ,'\<iota\>'              ,'ι')
	call s:GroffConceal('roffGreek'  ,'\<kappa\>'		      ,'κ')
	call s:GroffConceal('roffGreek'  ,'\<lambda\>'		      ,'λ')
	call s:GroffConceal('roffGreek'  ,'\<mu\>'		          ,'μ')
	call s:GroffConceal('roffGreek'  ,'\<nu\>'		          ,'ν')
	call s:GroffConceal('roffGreek'  ,'\<xi\>'		          ,'ξ')
	call s:GroffConceal('roffGreek'  ,'\<pi\>'		          ,'π')
	call s:GroffConceal('roffGreek'  ,'\<varpi\>'		      ,'ϖ')
	call s:GroffConceal('roffGreek'  ,'\<rho\>'		          ,'ρ')
	call s:GroffConceal('roffGreek'  ,'\<varrho\>'		      ,'ϱ')
	call s:GroffConceal('roffGreek'  ,'\<sigma\>'		      ,'σ')
	call s:GroffConceal('roffGreek'  ,'\<varsigma\>'	      ,'ς')
	call s:GroffConceal('roffGreek'  ,'\<tau\>'		          ,'τ')
	call s:GroffConceal('roffGreek'  ,'\<upsilon\>'		      ,'υ')
	call s:GroffConceal('roffGreek'  ,'\<phi\>'		          ,'ϕ')
	call s:GroffConceal('roffGreek'  ,'\<varphi\>'		      ,'φ')
	call s:GroffConceal('roffGreek'  ,'\<chi\>'		          ,'χ')
	call s:GroffConceal('roffGreek'  ,'\<psi\>'		          ,'ψ')
	call s:GroffConceal('roffGreek'  ,'\<omega\>'		      ,'ω')
	call s:GroffConceal('roffGreek'  ,'\<GAMMA\>'		      ,'Γ')
	call s:GroffConceal('roffGreek'  ,'\<DELTA\>'		      ,'Δ')
	call s:GroffConceal('roffGreek'  ,'\<THETA\>'		      ,'Θ')
	call s:GroffConceal('roffGreek'  ,'\<LAMBDA\>'		      ,'Λ')
	call s:GroffConceal('roffGreek'  ,'\<XI\>'                ,'Ξ')
	call s:GroffConceal('roffGreek'  ,'\<PI\>'		          ,'Π')
	call s:GroffConceal('roffGreek'  ,'\<SIGMA\>'		      ,'Σ')
	call s:GroffConceal('roffGreek'  ,'\<UPSILON\>'		      ,'Υ')
	call s:GroffConceal('roffGreek'  ,'\<PHI\>'		          ,'Φ')
	call s:GroffConceal('roffGreek'  ,'\<CHI\>'		          ,'Χ')
	call s:GroffConceal('roffGreek'  ,'\<PSI\>'		          ,'Ψ')
	call s:GroffConceal('roffGreek'  ,'\<OMEGA\>'		      ,'Ω')
endif 

if exists('g:groff_math')
	call s:GroffConceal('roffMath'   , '>= '		          , '≥')
	call s:GroffConceal('roffMath'   , '<= '		          , '≤')
	call s:GroffConceal('roffMath'   , '== '		          , '≡')
	call s:GroffConceal('roffMath'   , '!= '		          , '≠')
	call s:GroffConceal('roffMath'   , '\<int\>'		      , '∫')
	call s:GroffConceal('roffMath'   , '\<inf\>'		      , '∞')
	call s:GroffConceal('roffMath'   , '\<leftarrow\>'	      , '←')
	call s:GroffConceal('roffMath'   , '\<rightarrow\>'	      , '→')
	call s:GroffConceal('roffMath'   , '\<partial\>'	      , '∂')
	call s:GroffConceal('roffMath'   , '\<prime \>'		      , '′')
	call s:GroffConceal('roffMath'   , '\<times\>'		      , '×')
	call s:GroffConceal('roffMath'   , '\<prod\>'		      , '∏')
	call s:GroffConceal('roffMath'   , '\<del\>'              , '∇')
	call s:GroffConceal('roffMath'   , '\<grad\>'             , '∇')
	call s:GroffConceal('roffMath'   , '\<inter\>'		      , '∩')
	call s:GroffConceal('roffMath'   , '\<union\>'		      , '∪')
	call s:GroffConceal('roffMath'   , '\<sum\>'		      , '∑')
	call s:GroffConceal('roffMath'   , '\<sqrt\>' 		      , '√')
	call s:GroffConceal('roffMath'   , '\<over\>' 		      , '/')
endif

if exists('g:groff_supsub')
	fun! s:SuperSub(group,leader,pat,cchar)
		"     call Decho("SuperSub: group<".a:group."> leader<".a:leader."> pat<".a:pat."> cchar<".a:cchar.">")
		exe 'syn match '.a:group." '".a:leader.a:pat."' contained conceal cchar=".a:cchar
		exe 'syn match '.a:group."s '".a:pat        ."' contained conceal cchar=".a:cchar.' nextgroup='.a:group.'s'
	endfun

	call s:SuperSub('roffSuperscript',' sup ','0','⁰')
	call s:SuperSub('roffSuperscript',' sup ','1','¹')
	call s:SuperSub('roffSuperscript',' sup ','2','²')
	call s:SuperSub('roffSuperscript',' sup ','3','³')
	call s:SuperSub('roffSuperscript',' sup ','4','⁴')
	call s:SuperSub('roffSuperscript',' sup ','5','⁵')
	call s:SuperSub('roffSuperscript',' sup ','6','⁶')
	call s:SuperSub('roffSuperscript',' sup ','7','⁷')
	call s:SuperSub('roffSuperscript',' sup ','8','⁸')
	call s:SuperSub('roffSuperscript',' sup ','9','⁹')
	call s:SuperSub('roffSuperscript',' sup ','a','ᵃ')
	call s:SuperSub('roffSuperscript',' sup ','b','ᵇ')
	call s:SuperSub('roffSuperscript',' sup ','c','ᶜ')
	call s:SuperSub('roffSuperscript',' sup ','d','ᵈ')
	call s:SuperSub('roffSuperscript',' sup ','e','ᵉ')
	call s:SuperSub('roffSuperscript',' sup ','f','ᶠ')
	call s:SuperSub('roffSuperscript',' sup ','g','ᵍ')
	call s:SuperSub('roffSuperscript',' sup ','h','ʰ')
	call s:SuperSub('roffSuperscript',' sup ','i','ⁱ')
	call s:SuperSub('roffSuperscript',' sup ','j','ʲ')
	call s:SuperSub('roffSuperscript',' sup ','k','ᵏ')
	call s:SuperSub('roffSuperscript',' sup ','l','ˡ')
	call s:SuperSub('roffSuperscript',' sup ','m','ᵐ')
	call s:SuperSub('roffSuperscript',' sup ','n','ⁿ')
	call s:SuperSub('roffSuperscript',' sup ','o','ᵒ')
	call s:SuperSub('roffSuperscript',' sup ','p','ᵖ')
	call s:SuperSub('roffSuperscript',' sup ','r','ʳ')
	call s:SuperSub('roffSuperscript',' sup ','s','ˢ')
	call s:SuperSub('roffSuperscript',' sup ','t','ᵗ')
	call s:SuperSub('roffSuperscript',' sup ','u','ᵘ')
	call s:SuperSub('roffSuperscript',' sup ','v','ᵛ')
	call s:SuperSub('roffSuperscript',' sup ','w','ʷ')
	call s:SuperSub('roffSuperscript',' sup ','x','ˣ')
	call s:SuperSub('roffSuperscript',' sup ','y','ʸ')
	call s:SuperSub('roffSuperscript',' sup ','z','ᶻ')
	call s:SuperSub('roffSuperscript',' sup ','A','ᴬ')
	call s:SuperSub('roffSuperscript',' sup ','B','ᴮ')
	call s:SuperSub('roffSuperscript',' sup ','D','ᴰ')
	call s:SuperSub('roffSuperscript',' sup ','E','ᴱ')
	call s:SuperSub('roffSuperscript',' sup ','G','ᴳ')
	call s:SuperSub('roffSuperscript',' sup ','H','ᴴ')
	call s:SuperSub('roffSuperscript',' sup ','I','ᴵ')
	call s:SuperSub('roffSuperscript',' sup ','J','ᴶ')
	call s:SuperSub('roffSuperscript',' sup ','K','ᴷ')
	call s:SuperSub('roffSuperscript',' sup ','L','ᴸ')
	call s:SuperSub('roffSuperscript',' sup ','M','ᴹ')
	call s:SuperSub('roffSuperscript',' sup ','N','ᴺ')
	call s:SuperSub('roffSuperscript',' sup ','O','ᴼ')
	call s:SuperSub('roffSuperscript',' sup ','P','ᴾ')
	call s:SuperSub('roffSuperscript',' sup ','R','ᴿ')
	call s:SuperSub('roffSuperscript',' sup ','T','ᵀ')
	call s:SuperSub('roffSuperscript',' sup ','U','ᵁ')
	call s:SuperSub('roffSuperscript',' sup ','W','ᵂ')
	call s:SuperSub('roffSuperscript',' sup ',',','︐')
	call s:SuperSub('roffSuperscript',' sup ',':','︓')
	call s:SuperSub('roffSuperscript',' sup ',';','︔')
	call s:SuperSub('roffSuperscript',' sup ','+','⁺')
	call s:SuperSub('roffSuperscript',' sup ','-','⁻')
	call s:SuperSub('roffSuperscript',' sup ','<','˂')
	call s:SuperSub('roffSuperscript',' sup ','>','˃')
	call s:SuperSub('roffSuperscript',' sup ','/','ˊ')
	call s:SuperSub('roffSuperscript',' sup ','(','⁽')
	call s:SuperSub('roffSuperscript',' sup ',')','⁾')
	call s:SuperSub('roffSuperscript',' sup ','\.','˙')
	call s:SuperSub('roffSuperscript',' sup ','=','˭')
	call s:SuperSub('roffSuperscript',' sup ','4','⁴')
	call s:SuperSub('roffSuperscript',' sup ','5','⁵')
	call s:SuperSub('roffSuperscript',' sup ','6','⁶')
	call s:SuperSub('roffSuperscript',' sup ','7','⁷')
	call s:SuperSub('roffSuperscript',' sup ','8','⁸')
	call s:SuperSub('roffSuperscript',' sup ','9','⁹')
	call s:SuperSub('roffSuperscript',' sup ','a','ᵃ')
	call s:SuperSub('roffSuperscript',' sup ','b','ᵇ')
	call s:SuperSub('roffSuperscript',' sup ','c','ᶜ')
	call s:SuperSub('roffSuperscript',' sup ','d','ᵈ')
	call s:SuperSub('roffSuperscript',' sup ','e','ᵉ')
	call s:SuperSub('roffSuperscript',' sup ','f','ᶠ')
	call s:SuperSub('roffSuperscript',' sup ','g','ᵍ')
	call s:SuperSub('roffSuperscript',' sup ','h','ʰ')
	call s:SuperSub('roffSuperscript',' sup ','i','ⁱ')
	call s:SuperSub('roffSuperscript',' sup ','j','ʲ')
	call s:SuperSub('roffSuperscript',' sup ','k','ᵏ')
	call s:SuperSub('roffSuperscript',' sup ','l','ˡ')
	call s:SuperSub('roffSuperscript',' sup ','m','ᵐ')
	call s:SuperSub('roffSuperscript',' sup ','n','ⁿ')
	call s:SuperSub('roffSuperscript',' sup ','o','ᵒ')
	call s:SuperSub('roffSuperscript',' sup ','p','ᵖ')
	call s:SuperSub('roffSuperscript',' sup ','r','ʳ')
	call s:SuperSub('roffSuperscript',' sup ','s','ˢ')
	call s:SuperSub('roffSuperscript',' sup ','t','ᵗ')
	call s:SuperSub('roffSuperscript',' sup ','u','ᵘ')
	call s:SuperSub('roffSuperscript',' sup ','v','ᵛ')
	call s:SuperSub('roffSuperscript',' sup ','w','ʷ')
	call s:SuperSub('roffSuperscript',' sup ','x','ˣ')
	call s:SuperSub('roffSuperscript',' sup ','y','ʸ')
	call s:SuperSub('roffSuperscript',' sup ','z','ᶻ')
	call s:SuperSub('roffSuperscript',' sup ','A','ᴬ')
	call s:SuperSub('roffSuperscript',' sup ','B','ᴮ')
	call s:SuperSub('roffSuperscript',' sup ','D','ᴰ')
	call s:SuperSub('roffSuperscript',' sup ','E','ᴱ')
	call s:SuperSub('roffSuperscript',' sup ','G','ᴳ')
	call s:SuperSub('roffSuperscript',' sup ','H','ᴴ')
	call s:SuperSub('roffSuperscript',' sup ','I','ᴵ')
	call s:SuperSub('roffSuperscript',' sup ','J','ᴶ')
	call s:SuperSub('roffSuperscript',' sup ','K','ᴷ')
	call s:SuperSub('roffSuperscript',' sup ','L','ᴸ')
	call s:SuperSub('roffSuperscript',' sup ','M','ᴹ')
	call s:SuperSub('roffSuperscript',' sup ','N','ᴺ')
	call s:SuperSub('roffSuperscript',' sup ','O','ᴼ')
	call s:SuperSub('roffSuperscript',' sup ','P','ᴾ')
	call s:SuperSub('roffSuperscript',' sup ','R','ᴿ')
	call s:SuperSub('roffSuperscript',' sup ','T','ᵀ')
	call s:SuperSub('roffSuperscript',' sup ','U','ᵁ')
	call s:SuperSub('roffSuperscript',' sup ','W','ᵂ')
	call s:SuperSub('roffSuperscript',' sup ','+','⁺')
	call s:SuperSub('roffSuperscript',' sup ','-','⁻')

	call s:SuperSub('roffSubscript',' sub ','0','₀')
	call s:SuperSub('roffSubscript',' sub ','1','₁')
	call s:SuperSub('roffSubscript',' sub ','2','₂')
	call s:SuperSub('roffSubscript',' sub ','3','₃')
	call s:SuperSub('roffSubscript',' sub ','4','₄')
	call s:SuperSub('roffSubscript',' sub ','5','₅')
	call s:SuperSub('roffSubscript',' sub ','6','₆')
	call s:SuperSub('roffSubscript',' sub ','7','₇')
	call s:SuperSub('roffSubscript',' sub ','8','₈')
	call s:SuperSub('roffSubscript',' sub ','9','₉')
	call s:SuperSub('roffSubscript',' sub ','a','ₐ')
	call s:SuperSub('roffSubscript',' sub ','e','ₑ')
	call s:SuperSub('roffSubscript',' sub ','h','ₕ')
	call s:SuperSub('roffSubscript',' sub ','i','ᵢ')
	call s:SuperSub('roffSubscript',' sub ','j','ⱼ')
	call s:SuperSub('roffSubscript',' sub ','k','ₖ')
	call s:SuperSub('roffSubscript',' sub ','l','ₗ')
	call s:SuperSub('roffSubscript',' sub ','m','ₘ')
	call s:SuperSub('roffSubscript',' sub ','n','ₙ')
	call s:SuperSub('roffSubscript',' sub ','o','ₒ')
	call s:SuperSub('roffSubscript',' sub ','p','ₚ')
	call s:SuperSub('roffSubscript',' sub ','r','ᵣ')
	call s:SuperSub('roffSubscript',' sub ','s','ₛ')
	call s:SuperSub('roffSubscript',' sub ','t','ₜ')
	call s:SuperSub('roffSubscript',' sub ','u','ᵤ')
	call s:SuperSub('roffSubscript',' sub ','v','ᵥ')
	call s:SuperSub('roffSubscript',' sub ','x','ₓ')
	call s:SuperSub('roffSubscript',' sub ',',','︐')
	call s:SuperSub('roffSubscript',' sub ','+','₊')
	call s:SuperSub('roffSubscript',' sub ','-','₋')
	call s:SuperSub('roffSubscript',' sub ','/','ˏ')
	call s:SuperSub('roffSubscript',' sub ','(','₍')
	call s:SuperSub('roffSubscript',' sub ',')','₎')
	call s:SuperSub('roffSubscript',' sub ','\.','‸')
	call s:SuperSub('roffSubscript',' sub ','r','ᵣ')
	call s:SuperSub('roffSubscript',' sub ','v','ᵥ')
	call s:SuperSub('roffSubscript',' sub ','x','ₓ')
	call s:SuperSub('roffSubscript',' sub ','\\beta\>' ,'ᵦ')
	call s:SuperSub('roffSubscript',' sub ','\\delta\>','ᵨ')
	call s:SuperSub('roffSubscript',' sub ','\\phi\>'  ,'ᵩ')
	call s:SuperSub('roffSubscript',' sub ','\\gamma\>','ᵧ')
	call s:SuperSub('roffSubscript',' sub ','\\chi\>'  ,'ᵪ')
	delfun s:SuperSub
endif
hi def link roffMath Special

syn region nroffEquation start=/^\.\s*EQ\>/ end=/^\.\s*EN\>/ contains=roffGreek,roffMath,roffSuperscript,roffSubscript fold
syn region nroffTable start=/^\.\s*TS\>/ end=/^\.\s*TE\>/ fold
syn region nroffPicture start=/^\.\s*PS\>/ end=/^\.\s*PE\>/ fold
syn region nroffRefer start=/^\.\s*\[\>/ end=/^\.\s*\]\>/ fold
syn region nroffGrap start=/^\.\s*G1\>/ end=/^\.\s*G2\>/ fold
syn region nroffGremlin start=/^\.\s*GS\>/ end=/^\.\s*GE|GF\>/ fold



" Enable spell check for non syntax highlighted text
syntax spell toplevel
syn match nroffEscChar /\\[CN]/ nextgroup=nroffEscCharArg contains=@NoSpell
syn match nroffEscape /\\[*fgmnYV]/ nextgroup=nroffEscRegPar,nroffEscRegArg contains=@NoSpell
syn match nroffEscape /\\s[+-]\=/ nextgroup=nroffSize contains=@NoSpell
syn match nroffEscape /\\[$AbDhlLRvxXZ]/ nextgroup=nroffEscPar,nroffEscArg  contains=@NoSpell
syn match nroffEscRegArg /./ contained contains=@NoSpell
syn match nroffEscRegArg2 /../ contained contains=@NoSpell
syn match nroffEscRegPar /(/ contained nextgroup=nroffEscRegArg2 contains=@NoSpell
syn match nroffEscArg /./ contained contains=@NoSpell
syn match nroffEscArg2 /../ contained contains=@NoSpell
syn match nroffEscPar /(/ contained nextgroup=nroffEscArg2 contains=@NoSpell
syn match nroffSize /\((\d\)\=\d/ contained contains=@NoSpell
syn region nroffEscCharArg start=/'/ end=/'/ contained contains=@NoSpell
syn match nroffEscape /\\[adprtu{}]/ contains=@NoSpell
syn match nroffEscape /\\$/ contains=@NoSpell
syn match nroffEscape /\\\$[@*]/ contains=@NoSpell
syn match nroffSpecialChar /\\[\\eE?!-]/ contains=@NoSpell
syn match nroffSpace "\\[&%~|^0)/,]" contains=@NoSpell
syn match nroffSpecialChar /\\(../ contains=@NoSpell
syn match nroffSpecialChar /\\\[[^]]*]/ contains=@NoSpell
syn match nroffBadChar /./ contained contains=@NoSpell
syn match nroffUnit /[icpPszmnvMu]/ contained contains=@NoSpell
    syn match nroffReqName /[^\t \\\[?]\+/ contained nextgroup=nroffReqArg contains=@NoSpell
    syn match nroffReqName /[^\t \\\[?]\{1,2}/ contained nextgroup=nroffReqArg contains=@NoSpell
syn match nroffReqName /\(if\|ie\)/ contained nextgroup=nroffCond skipwhite contains=@NoSpell
syn match nroffReqName /el/ contained nextgroup=nroffReqLeader skipwhite contains=@NoSpell
syn match nroffCond /\S\+/ contained nextgroup=nroffReqLeader skipwhite contains=@NoSpell
syn match nroffReqname /[da]s/ contained nextgroup=nroffDefIdent skipwhite contains=@NoSpell
syn match nroffDefIdent /\S\+/ contained nextgroup=nroffDefinition skipwhite contains=@NoSpell
syn region nroffDefinition matchgroup=nroffSpecialChar start=/"/ matchgroup=NONE end=/\\"/me=e-2 skip=/\\$/ start=/\S/ end=/$/ contained contains=nroffDefSpecial,@NoSpell
syn match nroffDefSpecial /\\$/ contained contains=@NoSpell
syn match nroffDefSpecial /\\\((.\)\=./ contained contains=@NoSpell
    syn match nroffDefSpecial /\\\[[^]]*]/ contained contains=@NoSpell
if exists("b:nroff_is_groff")
"
" GNU troff allows long request names
"
	syn match nroffReqName /[^\t \\\[?]\+/ contained nextgroup=nroffReqArg contains=@NoSpell
else
	syn match nroffReqName /[^\t \\\[?]\{1,2}/ contained nextgroup=nroffReqArg contains=@NoSpell
endif

syn region nroffBold matchgroup=Delimiter start="\\fB\|\\f\[B\]" end="\\fP\|\\f\[P\?\]" keepend contains=@NoSpell concealends
syn region nroffItalic matchgroup=Delimiter start="\\fI\|\\f\[I\]" end="\\fP\|\\f\[P\?\]" keepend contains=@NoSpell concealends

syn region  nroffMacro  transparent start="\.\s*de\s*\a*\>" end="\.\.$" fold

hi def nroffBold   term=bold                 cterm=bold        gui=bold
hi def nroffItalic term=italic               cterm=italic      gui=italic
" hi def link        Delimiter         
" hi def link        nroffBoldDelimiter           Special
