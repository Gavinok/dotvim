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
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
	if exists('g:qfix_win') && a:forced == 0
		cclose
		unlet g:qfix_win
	else
		copen 10
		let g:qfix_win = bufnr('$')
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

