" File: vim-old.vim
" Maintainer: Gavin Jaeger-Freeborn <gavinfreeborn@gmail.com>
" Created: Tue 19 Nov 2019 09:52:50 AM MST
" License:
" Copyright (c) Gavin Jaeger-Freeborn.  Distributed under the same terms as Vim itself.
" See :help license
"
" Description: 
" old vim conigurations that I nolonger use

"++++++++++++++++++++++++++GENERAL++++++++++++++++++++++++++++++++++++++++++
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"--------------------------FUNCTIONS------------------------------------------
" QFixToggle {{{1"
" will toggle the quickfix open and closed
command -nargs=0 QFix call ToggleQuickfix()
function! ToggleQuickfix()
	let nr = winnr("$")
	copen
	if exists('g:autoloaded_dispatch')
		Copen
	endif
	let nr2 = winnr("$")
	if nr == nr2
		cclose
	endif
endfunction
"2}}} QFixToggle "

" Dead simple Align {{{1 "
" Use a bunch of standard UNIX commands for quick an dirty
" whitespace-based alignment
function! Align()
	'<,'>!column -t|sed 's/  \(\S\)/ \1/g'
	normal gv=
endfunction
"2}}} "Dead simple Align

" Ask Abbreviations {{{1 "
function! s:Ask(abbr,expansion,defprompt)
	let answer = confirm("Expand '" . a:abbr . "'?", "&Yes\n&No", a:defprompt)
	" testing against 1 and not 2, I correctly take care of <abort>
	return answer == 1 ? a:expansion : a:abbr
endfunction
" 2}}} "

"++++++++++++++++++++++++++PLUGINS++++++++++++++++++++++++++++++++++++++++++
" FloatingFZF {{{1 "
nnoremap <silent> <leader>fs	:call fzf#run({'window': 'call FloatingFZF()', 'source':
			\'find ~/.config/ ~/.scripts/  -path */.config/coc -prune -o -path "*.git" -prune -o -print', 'sink':  'edit'})<CR>
if has('nvim') && executable('fzf')
	" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
	function! FloatingFZF()
		let buf = nvim_create_buf(v:false, v:true)
		call setbufvar(buf, '&signcolumn', 'no')
		let height = float2nr(&lines/2)
		" let row = (&lines - height) " bottom of screen
		let row = (&lines - height)/2 " open in midel hight
		let width = float2nr(&columns - (&columns * 2 / 10))
		" let width = float2nr(&columns)
		let col = float2nr((&columns - width) / 2)
		let opts = {
					\ 'relative': 'editor',
					\ 'row': row,
					\ 'col': col,
					\ 'width': width,
					\ 'height': height
					\ }
		call nvim_open_win(buf, v:true, opts)
	endfunction
endif
" 2}}} "FloatingFZF

"  LanguageClient  {{{1 "
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
" nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
autocmd FileType * call LC_maps()
function LC_maps()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
		nnoremap <buffer> <silent> <leader>l :call LanguageClient#contextMenu()<cr>
		nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
	endif
endfunction
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_serverCommands = {
			\ 'c': ['ccls'],
			\ 'cpp': ['ccls'],
			\ 'objc': ['ccls'],
			\ 'java': ['jdtls', '-data', getcwd()],
			\ }
" 1}}} "LanguageClient

" Deoplete {{{1
let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('ultisnips', 'rank', 1000)
call deoplete#custom#source('look', 'filetypes', ['markdown','org', 'mail'] )
call deoplete#custom#source('look', 'rank', 0 )
call deoplete#custom#source('look', 'min_pattern_length', 0 )
call deoplete#custom#source('look', 'max_candidates', 12 )

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" map <tab> to trigger completion and navigate to the next item
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ deoplete#manual_complete()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-V><Tab>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 1}}} "Deoplete

" UltiSnips {{{1 "
"plug settings
if has('python3')
	Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets' "snippets
	let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips/"
endif

if has('python3')
	let g:UltiSnipsExpandTrigger = '<c-f>'        " Do not use <tab>
	let g:UltiSnipsJumpForwardTrigger = '<c-f>'  " Do not use <c-j>
	let g:UltiSnipsSnippetDirectories=['UltiSnips', 'plugged/vim-snippets/UltiSnips']
endif
" 1}}} "UltiSnips

" LSC {{{1 "
let g:lsc_auto_completeopt='menu,menuone,noinsert,noselect'
" Use all the defaults (recommended):
let g:lsc_auto_map = v:true
autocmd CompleteDone * silent! pclose
let g:lsc_hover_popup='v:true'
let g:lsc_server_commands = {
			\ 'c': {
			\    'command': 'ccls',
			\    'message_hooks': {
			\        'initialize': {
			\            'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
			\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
			\        },
			\    },
			\  },
			\}
" 2}}} LSC

" NCM2 {{{1 "
set complete=.,w,b,u,t,kspell
if has('python3')
	inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" map <tab> to trigger completion and navigate to the next item
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ ncm2#manual_trigger()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-V><Tab>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 1}}} "NCM2

" Wilder.nvim {{{1 "
call wilder#enable_cmdline_enter()

set wildcharm=<tab>
cmap <expr> <tab> wilder#in_context() ? wilder#next() : "\<tab>"
cmap <expr> <s-tab> wilder#in_context() ? wilder#previous() : "\<s-tab>"

" enable cmdline completion (for neovim only)
call wilder#set_option('modes', ['/', '?'])
nnoremap <expr> <Leader>w wilder#toggle()
" 2}}} "Wilder.nvim

" COC {{{1 "
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'on' : []}
augroup LazyLoadPlug
	autocmd!
	autocmd CursorHold,CursorHoldI * call plug#load('coc.nvim') | autocmd! LazyLoadPlug
augroup end
if has('patch-8.0.0283')
	" TODO: setup diagnostics for vimrc "

	" Define Error Symbols and colors
	let g:coc_status_warning_sign = ''
	let g:coc_status_error_sign = ''
	hi CocWarningSign ctermfg=blue
	hi CocErrorSign ctermfg=red
	hi CocInfoSign ctermfg=yellow
	hi CocHintSign ctermfg=green

	" Extensions. Some need configuration.
	" coc-java needs a valid JVM filepath defined in coc-settings
	" coc-ccls needs ccls (available on aur)
	" coc-eslint needs eslint npm package installed globally
	let g:coc_global_extensions = [
				\'coc-diagnostic',
				\'coc-ccls',
				\'coc-dictionary',
				\'coc-word',
				\'coc-vimtex',
				\'coc-go',
				\'coc-java',
				\'coc-snippets',
				\'coc-json',
				\'coc-python',
				\'coc-lists',
				\'coc-utils'
				\]

	" KEY REMAPS
	set updatetime=100
	let g:coc_snippet_next = '<C-F>'
	let g:coc_snippet_prev = '<C-B>'

	" Remap keys for gotos
	" use [[ if need be
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gr <Plug>(coc-references)

	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)

	" Fix autofix problem of current line
	nnoremap <Leader>di :<C-u>CocList diagnostics<cr>

	" can always use Man if i need to"
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	nnoremap <leader>K 	:Man <c-r><c-w>

	inoremap <silent><expr> <c-space> coc#refresh()

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
endif
" 2}}} "COC

" Git-Gutter {{{1 "
" gitgutter colors and signs
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
nnoremap zG :GitGutterFold<CR>
nnoremap <leader>hc :Gcommit<CR>
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
if isdirectory(expand('~/.dotfiles'))
	command! -nargs=0 Gdot :let g:gitgutter_git_args = '--git-dir="$HOME/.dotfiles/"'
endif
" 1}}} "Git-Gutter

" Go {{{1 "
if executable('go')
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "make vim a go IDE
	" let g:go_def_mode = 'guru'
	let g:go_term_mode = 'split'
	augroup GOLANG
		autocmd!
		autocmd FileType go nmap K <Plug>(go-doc-split)
		autocmd FileType go nnoremap <leader>cc  :GoBuild<CR>
		autocmd FileType go nnoremap <leader>o  :GoRun<CR>
	augroup END
endif
" 1}}} "Go

" vim-lsp {{{2 "
if has('patch-8.0.0283')

	"diagnostics settings
	let g:lsp_virtual_text_enabled = 0
	let g:lsp_highlights_enabled = 0
	let g:lsp_signs_enabled = 1         " enable signs
	let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
	let g:lsp_signs_error = {'text': '✖'}
	let g:lsp_signs_warning = {'text': '‼'} " icons require GUI
	let g:lsp_signs_hint = {'text': 'ⓘ'} " icons require GUI
	let g:lsp_preview_float = 1
	hi LspErrorText       ctermfg=red    ctermbg=NONE
	hi LspWarningText     ctermfg=blue   ctermbg=NONE
	hi LspInformationText ctermfg=yellow ctermbg=NONE
	hi LspHintText        ctermfg=red    ctermbg=NONE

	"Specific lsp setup
	augroup LSP
		autocmd!
		if executable('pyls')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'pyls',
						\ 'cmd': {server_info->['pyls']},
						\ 'whitelist': ['python'],
						\ })
		endif
		if executable('ccls')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'ccls',
						\ 'cmd': {server_info->['ccls']},
						\ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
						\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
						\ })

		elseif executable('clangd')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'clangd',
						\ 'cmd': {server_info->['clangd', '--background-index']},
						\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
						\ })
		endif
		if executable('gopls')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'gopls',
						\ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
						\ 'whitelist': ['go'],
						\ })
			autocmd BufWritePre *.go "silent! LspDocumentFormatSync<CR>"
		endif
		if executable('typescript-language-server')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'javascript support using typescript-language-server',
						\ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
						\ 'root_uri': { server_info->lsp#utils#path_to_uri
						\(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
						\ 'whitelist': ['javascript', 'javascript.jsx']
						\ })
		endif
		if executable('bash-language-server')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'bash-language-server',
						\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
						\ 'whitelist': ['sh'],
						\ })
		endif
		if executable('java') && executable('jdtls')
			au User lsp_setup call lsp#register_server({
						\ 'name': 'jdt.ls',
						\ 'cmd': {server_info->["jdtls"]},
						\ 'whitelist': ['java'],
						\ })
		endif
		nmap ]l <plug>(lsp-next-error)
		nmap [l <plug>(lsp-previouse-error)
		nnoremap <leader>K :Man <C-r><C-w>

		autocmd FileType cpp,c,python,javascript,java,go   nmap <silent><buffer> K <plug>(lsp-hover)
		autocmd FileType cpp,c,python,javascript,java,go   nmap <silent><buffer> gd <plug>(lsp-definition)
		autocmd FileType cpp,c,python,javascript,java,go   setlocal omnifunc=lsp#complete


		let g:lsp_diagnostics_enabled = 1 


		"prevent mucomplete from blocking input
		autocmd FileType cpp,c,python,javascript,java,go   let g:mucomplete#completion_delay = 50
		autocmd FileType cpp,c,python,javascript,java,go   let g:mucomplete#reopen_immediately = 0

	augroup end
endif
" 2}}} "vim-lsp


" asyncomplete {{{1 
" basically just used for async omni complete
Plug 'prabirshrestha/asyncomplete.vim' | Plug 'prabirshrestha/asyncomplete-lsp.vim'

if exists('*job_start') || exists('*jobstart') 
	let g:asyncomplete_auto_popup = 0
	let g:asyncomplete_auto_completeopt = 0
	let g:asyncomplete_popup_delay = 0

	imap <c-space> <Plug>(asyncomplete_force_refresh)
	" let mucomplete call asynccomplete when it needs to

	let g:mucomplete#user_mappings = {
				\ 'xyz'  : "\<c-r>=asyncomplete#force_refresh()\<cr>",
				\'mini': "\<C-r>=MUcompleteMinisnip#complete()\<CR>"
				\ }
endif
" 1}}} "asyncomplete

" gutentags {{{1 
if has('patch-8.0.0283')
	" Tags {{{2 "
	if executable('ctags')
		" Plug 'ludovicchabant/vim-gutentags'
		let g:gutentags_exclude_filetypes = ['gitcommit']
		let g:gutentags_ctags_tagfile = '.tags'
		let g:gutentags_generate_on_new = 1
		let g:gutentags_generate_on_missing = 1
		let g:gutentags_generate_on_write = 1
		let g:gutentags_generate_on_empty_buffer = 0
		" ctags_exclude {{{3 "
		let g:gutentags_ctags_exclude = [
					\ '*.git', '*.svg', '*.hg',
					\ '*-lock.json',
					\ '*.lock',
					\ '*bundle*.js',
					\ '*build*.js',
					\ '.*rc*',
					\ '*.pyc',
					\ '*.class',
					\ '*.sln',
					\ '*.tmp',
					\ '*.cache',
					\ '*.pdb',
					\ 'tags*',
					\ '.tags*',
					\ '*.mp3', '*.ogg', '*.flac',
					\ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
					\ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
					\ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
					\ ]
		" 3}}} "ctags_exclude
	endif
	" 2}}} "Tags
endif
" 1}}} "gutentags

" emmet {{{1 
Plug 'mattn/emmet-vim'

let g:user_emmet_leader_key='<C-L>'
augroup HTML
	" this one is which you're most likely to use?
	autocmd FileType html setlocal completefunc=emmet#completeTag
augroup end
" 1}}} "emmet
" fzf {{{1 
if executable('fzf')
	Plug 'junegunn/fzf.vim'
else
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
	Plug 'junegunn/fzf.vim'
endif
" 1}}} "fzf
" pandoc {{{1 
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after' " work on replacing
let g:pandoc#modules#enabled = ['formatting', 'spell', 'hypertext']
let g:pandoc#formatting#mode = 'sA'
let g:pandoc#after#modules#enabled = ['nrrwrgn']
" 1}}} "pandoc
" minimal asyncdo {{{1 
func! s:populate(file, cmd) abort
	unlet! t:job
	try
		exe 'cgetfile '.a:file
	finally
		call setqflist([], 'a', {'title': a:cmd})
	endtry
endfunc

func! AsyncDo(...) abort
	if exists('t:job')
		echoerr 'There is currently running job, just wait'
		return
	endif

	call setqflist([], 'r')
	let tmp = tempname()
	let cmd = join(a:000)

	let g:qf_quickfix_titles = []
	if has('nvim')
		let t:job = jobstart([&sh, &shcf, printf(cmd.&srr, tmp)], {
					\ 'on_exit': {id, data, event -> s:populate(tmp, cmd)}
					\ })
	else
		let t:job = job_start([&sh, &shcf, printf(cmd.&srr, tmp)], {
					\ 'in_io': 'null','out_io': 'null','err_io': 'null',
					\ 'exit_cb': {job, result -> s:populate(tmp, cmd)}
					\ })
	endif
endfunc

com! -nargs=+ AsyncDo call AsyncDo(<f-args>)
" 1}}} "minimal asyncdo

" textobjects {{{1 
" 24 simple text-objects
" ----------------------
" i_ i. i: i, i; i| i/ i\ i* i+ i- i#
" a_ a. a: a, a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" line text-objects
" -----------------
" il al
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>

" number text-objects (integer and float)
" ---------------------------------------
" in an
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :normal vin<CR>

" buffer text-objects
" -------------------
" i% a%
xnoremap i% :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap i% :normal vi%<CR>
xnoremap a% GoggV
onoremap a% :normal va%<CR>

" comment text-objects
" --------------------
" i? a?
xnoremap <buffer> i? ?/\*<CR>o/\*\/<CR>
onoremap <buffer> i? :normal vi?<CR>

" square brackets text-objects
" ----------------------------
" ir ar
xnoremap ir i[
xnoremap ar a[
onoremap ir :normal vi[<CR>
onoremap ar :normal va[<CR>
" 1}}} "textobjects

" makery {{{ "1
function! Setopts(options)
	let l:save_options = {}
	if has_key(a:options, 'compiler')
		execute 'compiler' get(a:options, 'compiler')
	endif
	if has_key(a:options, 'makeprg')
		let l:save_options.makeprg = &l:makeprg
		let &l:makeprg = get(a:options, 'makeprg')
	endif
	if has_key(a:options, 'errorformat') && !has_key(a:options, 'compiler')
		let l:save_options.errorformat = &l:errorformat
		let &l:errorformat = get(a:options, 'errorformat')
	endif

	return l:save_options
endfunction

function! s:GetMakeCommand() abort
	return exists(':Make') == 2 ? 'Make' : 'make'
endfunction

function! ExecuteMake(bang, args) abort
	let l:make_command = s:GetMakeCommand() . a:bang
	execute l:make_command a:args
endfunction

function! RestoreOptions(options) abort
	for [l:option, l:value] in items(a:options)
		execute 'let &l:' . l:option '= "' . l:value . '"'
	endfor
endfunction

command! -bang -nargs=* -complete=file Mlint call RunMake( 'lint', <q-bang>, <q-args>)
command! -bang -nargs=* -complete=file Mbuild call RunMake( 'build', <q-bang>, <q-args>)
command! -bang -nargs=* -complete=file Mrun call RunMake( 'run', <q-bang>, <q-args>)
command! -bang -nargs=* -complete=file Mcomp call RunMake( 'compiler', <q-bang>, <q-args>)

function! RunMake(type, bang, args) abort
	if !has_key(g:makery_config, &filetype) || !has_key(g:makery_config[&filetype], a:type)
		return
	endif
	let l:options = g:makery_config[&filetype][a:type]

	let l:save_options = Setopts(l:options)
	call ExecuteMake(a:bang, a:args)
	call RestoreOptions(l:save_options)
endfunction
let g:makery_config = {
			\     "sh": {
			\ 		"lint":{"compiler": "shellcheck"},
			\ 		"run":{"makeprg": "compile %"}
			\ 		},
			\     "c": {
			\ 		"lint":{"makeprg": "make"},
			\ 		"build":{"makeprg": "gcc %"},
			\ 		"run":{"makeprg": "compile %"}
			\ 		},
			\     "python": {
			\ 		"lint":{"makeprg": "python3 %"},
			\ 		"run":{"compiler": "python"}
			\ 		},
			\     "vim": {
			\ 		"lint":{"compiler": "vint"}
			\ 		}
			\ }
" 1}}} "makery


" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
	let entries = []
	for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
				\ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
		let lines = split(system(cmd), '\n')
		if v:shell_error != 0 | continue | endif
		for line in lines
			let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
			call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
		endfor
		break
	endfor

	if !empty(entries)
		call setqflist(entries)
		copen
	endif
endfunction
command! Todo call s:todo()
" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
	if v:operator == 'c'
		augroup textobj_undo_empty_change
			autocmd InsertLeave <buffer> execute 'normal! u'
						\| execute 'autocmd! textobj_undo_empty_change'
						\| execute 'augroup! textobj_undo_empty_change'
		augroup END
	endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''
" ----------------------------------------------------------------------------
" Comment Object
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
	if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
		call s:textobj_cancel()
		if a:vis
			normal! gv
		endif
		return
	endif

	let origin = line('.')
	let lines = []
	for dir in [-1, 1]
		let line = origin
		let line += dir
		while line >= 1 && line <= line('$')
			execute 'normal!' line.'G^'
			if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
				break
			endif
			let line += dir
		endwhile
		let line -= dir
		call add(lines, line)
	endfor

	execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction

xmap <silent> iC :<C-U>call <SID>inner_comment(1)<CR><Plug>(TOC)
omap <silent> iC :<C-U>call <SID>inner_comment(0)<CR><Plug>(TOC)

" Zoom allow edit the same file {{{1 
augroup ZOOM
	" this one is which you're most likely to use?
	autocmd!
	autocmd SwapExists * let v:swapchoice='e'
				\| autocmd! Zoom
augroup end
" 1}}} "Zoom

" Auto Change Status Color {{{1 
highlight StatusLine ctermbg=NONE ctermfg=Grey
augroup WinEnterGroup
	" this one is which you're most likely to use?
	autocmd WinNew,WinEnter,BufHidden,BufDelete,BufWinLeave * if (winnr('j') > 1) || (winnr('l') > 1)
				\| highlight StatusLine ctermbg=145 ctermfg=235 guibg=#303537 guifg=#B3B8C4 cterm=NONE gui=NONE |
				\else
				\| highlight StatusLine ctermbg=NONE ctermfg=Grey
				\| endif

augroup end
" 1}}} "Auto Change Status Color
