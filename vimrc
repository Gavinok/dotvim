" File: .vimrc
" Maintainer: Gavin Jaeger-Freeborn
"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"       ░   ░         ░      ░     ░ ░
"      ░                           ░

" Quick Init: {{{1 "
" tell neovim where runtime is
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" where to find python
let g:python_host_prog  = '/usr/bin/python2' "speed up python2 startup
let g:python3_host_prog = '/usr/bin/python3' "speed up python3 startup
" Disable extra plugins
let  g:loaded_gzip            =  1
let  g:loaded_tarPlugin       =  1
let  g:loaded_zipPlugin       =  1
let  g:loaded_2html_plugin    =  1
"dont use any remote plugins so no need to load them
let  g:loaded_rrhelper        =  1
let  g:loaded_remote_plugins  =  1
" 1}}} "Quick Init

" Plugins: {{{1 "
" install vim-plug if it's not already
augroup PLUGGED
	if empty(glob('~/.vim/autoload/plug.vim'))  " vim
		silent !curl -fo ~/.vim/autoload/plug.vim --create-dirs
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
augroup end
call plug#begin('~/.vim/plugged')
" Plug 'kristijanhusak/vim-dirvish-git'
" Plug 'justinmk/vim-dirvish'
" lsc {{{2
" using:
" c: ccls
" go: gopls (go-tools)
" java: jdtls (eclips.jdt.ls)
" javascript: typescript-language-server
" python: python-language-server
" 	autopep8
" 	yapf :guidline linting
" 	python-pylint :linting
" 	python-rope
" 	python-pydocstyle
" 	python-pyflakes :linting
if exists('*job_start') || exists('*jobstart')
	Plug 'natebosch/vim-lsc'
endif
" 2}}} "lsc
" Autocompletion {{{2 "
Plug 'fcpg/vim-complimentary'
"better default completion used for easyier vim scripting
if has('nvim')
	Plug 'ncm2/float-preview.nvim'
	let g:float_preview#docked = 0
else 
	"I find this super distracting
	set completeopt-=preview
endif
" 2}}} "Autocompletion
" Snippets {{{2 "
if has('patch-7.4.775')
	Plug 'lifepillar/vim-mucomplete' "main source for completion
	Plug 'jonasw234/vim-mucomplete-minisnip'
endif
Plug 'joereynolds/vim-minisnip'
let g:name = 'Gavin Jaeger-Freeborn'
let g:email = 'gavinfreeborn@gmail.com'
let g:minisnip_trigger = '<C-f>'
let g:minisnip_dir = '~/.vim/extra/snip:' . join(split(glob('~/.vim/extra/snip/**/'), '\n'), ':')
imap <Nop> <Plug>(minisnip-complete)
" 2}}} "Snippets
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gpush', 'Gedit', 'Ggrep'] }
Plug 'mhinz/vim-signify'
" 2}}} "Git
" Writing {{{2 "
" Plug 'lervag/vimtex' " Latex support
Plug 'KeitaNakamura/tex-conceal.vim'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
let g:table_mode_map_prefix = '<Leader>T'
let g:table_mode_realign_map = '<Leader>TT'
set conceallevel=2
let g:tex_conceal='abdgm'
" 2}}} "Writing
" Org Mode {{{2 "
Plug 'dhruvasagar/vim-dotoo'
" 2}}} "Org Mode
" My Pluggins {{{2 "
Plug 'gavinok/spaceway.vim'
" 2}}} " My Plugins
" Tpope god bless the man {{{2 "
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
" 2}}} "Tpope
" vimscript {{{2 "
Plug 'tpope/vim-scriptease'
Plug 'mhinz/vim-lookup'
Plug 'tweekmonster/helpful.vim'
" 2}}} "vimscript
" etc {{{2 "
Plug 'chrisbra/colorizer', { 'on': 'ColorToggle' }
let g:colorizer_colornames_disable = 1
" 2}}} "etc.
call plug#end()

" Aesthetics: {{{2 "
" set termguicolors
colorscheme spaceway
highlight Normal ctermbg=NONE
highlight Conceal ctermbg=NONE
highlight link DirvishPathTail Statement
hi Todo cterm=bold ctermfg=160 gui=bold

function! s:statusline_expr()
	let mod  = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
	let ft   = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
	let fug  = "%3*%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
	let job  = "%2*%{exists('g:job') ? '[Job Running!]' : ''}%*"
	let zoom = "%3*%{exists('t:maximize_hidden_save') ? '[Z]' : ''}%*"
	let sep  = ' %= '
	let pos  = ' %-14.(%l,%c%V%) '
	let pct  = ' %P'

	return '%<%f %<'.mod.fug.job.zoom.sep.pos.pct
endfunction
let &statusline = s:statusline_expr()
highlight User1 ctermbg=107  ctermfg=black
highlight User2 ctermbg=103  ctermfg=black
highlight User3 ctermbg=59   ctermfg=black
" 2}}} Aesthetics "
" 1}}} "Plugins

" General Mappings: {{{1
let g:mapleader="\\"
let maplocalleader = '|'
nmap <space> <leader>
vmap <space> <leader>

" shortcut to files and dirs uses shortcuts.sh
" it can be found at my scripts repo
runtime vimshortcuts.vim

nnoremap <leader>y :let @+ = expand("%:p")<cr>

if has('nvim')
	augroup TERMINAL
		autocmd!
		" autocmd BufWinEnter,WinEnter term://* startinsert
		autocmd BufLeave term://* stopinsert
		au TermOpen * setlocal nonumber
		au TermOpen * setlocal norelativenumber
	augroup end
	map <leader>ct :w! \| :split \| te cheat.sh <c-r>%
	tnoremap <leader>esc <C-\><C-N>
	nnoremap <leader><cr>  :split \| te<cr>i
	tnoremap <C-\>       <C-\><C-N>
	tnoremap <C-H>       <C-\><C-N><C-W><C-H>
	tnoremap <C-J>       <C-\><C-N><C-W><C-J>
	tnoremap <C-K>       <C-\><C-N><C-W><C-K>
	tnoremap <C-L>       <C-\><C-N><C-W><C-L>
	set noshowmode
else
	set timeout           " for mappings
	set timeoutlen=1000   " default value
	set ttimeout          " for key codes
	set ttimeoutlen=10    " unnoticeable small value
	runtime macro/matchit
endif

" delete a buffer
nnoremap <leader>bd :bdelete<CR>

" Open or compile file
map <silent><leader>co :!opout <c-r>%<CR><CR>
map <leader>cc :w! \| !compiler <c-r>%<CR>
" Write To File As Sudo
nnoremap <leader>sudo :w !sudo tee > /dev/null %

" POSIX Commands
nmap <leader>cp :!cp  <C-R>% ~/
nmap <leader>mv :!mv  <C-R>% ~/
nmap cd :cd <C-R>=expand('%:h')<CR>

" Toggle *conceallevel*
nnoremap <Leader>cl :let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>

" Alignment Text
xnoremap <silent> gl :<C-u>silent call Align()<CR>

" mark position before search
nnoremap / ms/

nnoremap <silent> <leader>/        :nohlsearch<CR>

" if this is a normal buffer use <CR> to toggle folding
nmap <expr> <CR> &buftype ==# '' ? 'za' : "\<CR>"

" Find References
if executable('ag')
	set grepprg=ag\ --vimgrep
endif

nnoremap <leader>G :Grep <C-R><C-W> .<CR>:copen<CR>

" change variable and repeat with .
nnoremap c*			*Ncgn
nnoremap <C-N>      yiW/<C-r>0<CR>Ncgn
xnoremap <C-N>      y/<C-r>0<CR>Ncgn
nnoremap <leader>n  yiw:%s/<C-r>0//gc<left><left><left>
xnoremap <leader>n  y:%s/<C-r>0//gc<left><left><left>

map ]a :cnext<CR>
map [a :cprevious<CR>
map ]A :lnext<CR>
map [A :lprevious<CR>

"quick buffer navigation
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>

" Find Files {{{2 "
nnoremap <leader>fT  :setfiletype<space>
nnoremap <leader>ff  :Root<CR>:edit **/*
nnoremap <leader>fs  :find<space>
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
nnoremap <leader>ft  :tjump<space>
nnoremap <leader>hg  :helpgrep .*.*<Left><Left>
nnoremap <leader>hh  :help<Space>
" bookmarked directories
nnoremap <leader>fp  :edit ~/Programming/**/**<Left>
nnoremap <leader>fh  :edit ~/**/*
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fw  :edit ~/Dropbox/DropsyncFiles/vimwiki/**/**

nnoremap <leader>fj  :ME<space>
command! -nargs=1 -complete=customlist,dotvim#MRUComplete ME call dotvim#MRU('edit', <f-args>)
" 2}}} "Find Files

" better navigation of command history
" allow next completion after / alternative 
" is <C-E> if <C-D> makes to long of a list
cnoremap <expr> / wildmenumode() ? "\<C-D>" : "/"
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>
cnoremap <expr> <SPACE> dotvim#CSPACE()
cnoremap <expr> <CR> dotvim#CCR()
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))

" better alternative to <C-W>_<C-W>\|
nnoremap <C-W>f		:call dotvim#ZoomToggle()<CR>
nnoremap <C-W><C-f>	:call dotvim#ZoomToggle()<CR>


"Better Mappings Imho
nnoremap Y  y$
xnoremap * "xy/<C-R>x<CR>

"i never use s so i may as well make it useful
function! Sort(type, ...)
	'[,']sort
endfunction
nmap <silent> gS :set opfunc=Sort<CR>g@

" close preview if open when hitting escape
nnoremap <silent> <esc> :pclose<cr>

" copy all matches with the last seach
nmap ym :YankMatch<CR>
" delete matches
nmap dm :%s/<c-r>///g<CR>
" change matches
nmap cm :%s/<c-r>///g<Left><Left>

" Using Fugitive
nnoremap Q  :Gstatus<CR>

" Some Readline Keybindings When In Insertmode
inoremap <C-A> <C-O>^<C-g>u
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>
			\strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"

"For Proper Tabbing And Bracket Insertion"
inoremap {<CR> {<CR>}<c-o><s-o>
inoremap (<CR> (<CR>)<c-o><s-o>

" commandline mappings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>

" when rightclicking highlight copy it
xnoremap <RightMouse> "*y

" Toggle Quickfix
nnoremap <script> <silent> <leader>v :call dotvim#ToggleQuickfix()<CR>
" Quick format file
nnoremap gq :<C-U>call dotvim#FormatFile()<CR>
" win resize
nnoremap <C-W>+ :call dotvim#RepeatResize('+')<CR>
nnoremap <C-W>- :call dotvim#RepeatResize('-')<CR>
nnoremap <C-W>< :call dotvim#RepeatResize('<')<CR>
nnoremap <C-W>> :call dotvim#RepeatResize('>')<CR>
" 1}}} "General

" Editing: {{{1 "
" use syntax for omnicomplete if none exists
augroup SyntaxComplete
	" this one is which you're most likely to use?
	autocmd Filetype *
				\	if &omnifunc == '' |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
augroup end
" Capital Quick first letter of a word or a regain
nnoremap + m[viwb<esc>gUl`[
nnoremap <leader>+ V:s/\<./\u&/g <BAR> nohlsearch<CR>
xnoremap + :s/\<./\u&/g <BAR> nohlsearch<CR>

"Insert Empty Line Above And Below
map <silent><leader>o  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
map <silent><leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>

" Quick spell correction shortcut
nnoremap <silent> <leader>ss :call dotvim#WordProcessor()<CR>
nmap <silent> <Left>     mz[s1z=`z
imap <silent> <Left>     <C-G>u<esc>mz[s1z=`za

" Move a line of text using ALT+[jk] and shift the indentation with ALT+[hl]
xnoremap J :m'>+<cr>`<my`>mzgv`yo`z
xnoremap K :m'<-2<cr>`>my`<mzgv`yo`z
xnoremap < <gv
xnoremap > >gv
" 1}}} "Editing

" Plugin Configuration: {{{1 "
" Minimal Async Command {{{2
if exists('*job_start') || exists('*jobstart')
	command! -nargs=+ Term call dotvim#TermCmd(<f-args>)
	command! -nargs=+ -complete=shellcmd Do call dotvim#Do(<f-args>)
	" dispatch compatability
	command! -bang -nargs=+ -complete=file Dispatch call dotvim#Do(<f-args>)
	command! -bang -nargs=+ -complete=file_in_path Grep call dotvim#Do(&grepprg,<f-args>)
	command! -bang -nargs=0 -complete=file Make call dotvim#Do(&makeprg,<f-args>)
	nnoremap  '<CR>     :Term<Up><CR>
	nnoremap  '<Space>  :Term<Space>
	nnoremap  '<TAB>    :Term<Up>
	nnoremap  `<CR>     :Do<Up><CR>
	nnoremap  `<Space>  :Do<Space>
	nnoremap  `<TAB>    :Do<Up>
	nnoremap  m<CR>     :Make<CR>
	nnoremap  m<Space>  :Make<Space>
	nnoremap  m!		:setlocal makeprg=compiler\ %<CR>
	nnoremap  m?		:echo &makeprg<CR>
	nnoremap <leader>mm :call dotvim#ToggleAutocompile()<CR>
	"async tagging
	nnoremap <leader>t  :call dotvim#Quicktag(0)<CR>
else
	nnoremap  `<TAB>    :!<Up>
	nnoremap  `<Space>  :!
	nnoremap  m!        :make!<Space>
	nnoremap  m<CR>		:make!<CR>
endif
" 2}}} "Minimal Async Command
" netrw {{{2
" Poor mans Vim vinegar
let g:netrw_browsex_viewer='setsid xdg-open' "force gx to use xdg-open
let g:netrw_bufsettings = 'noswf noma nomod nowrap ro nobl'
let g:netrw_sort_options = 'i'
let g:netrw_banner=0 "disable banner
let g:netrw_fastbrowse=0
let g:netrw_localrmdir='rm -r'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" move up a directory and focus on the file
nmap - :call dotvim#Opendir('edit')<CR>

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call dotvim#NetrwMapping()
	autocmd FileType netrw setl bufhidden=wipe
augroup end
" 2}}} "netrw
" Orgmode {{{2 "
map <silent>gO :e ~/Documents/org/mylife.org<CR>
command! -nargs=1 Ngrep grep "<args>" ~/Dropbox/Documents/org/**/*.org
nmap <leader><leader> :Ngrep 
command! -nargs=1 Wgrep grep "<args>" ~/Dropbox/DropsyncFiles/vimwiki/**/*.md
nmap <leader><SPACE> :Wgrep 
" 2}}} "Orgmode
" LSC {{{2 "
if exists('*job_start') || exists('*jobstart')
	nmap <leader>V :LSClientAllDiagnostics<CR>
	let g:lsc_enable_autocomplete = v:false
	let g:lsc_auto_map = {
				\ 'GoToDefinition': 'gd',
				\ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
				\ 'FindReferences': 'gr',
				\ 'NextReference': '<leader>*',
				\ 'PreviousReference': '<leader>#',
				\ 'FindImplementations': 'gI',
				\ 'FindCodeActions': 'ga',
				\ 'Rename': 'gR',
				\ 'ShowHover': v:true,
				\ 'DocumentSymbol': 'go',
				\ 'WorkspaceSymbol': 'gz',
				\ 'SignatureHelp': 'gm',
				\ 'Completion': 'omnifunc',
				\}
	let g:lsc_server_commands={}

	if executable('ccls')
		let g:lsc_server_commands['c'] = {
					\ 'command': 'ccls',
					\ 'suppress_stderr': v:true,
					\ 'message_hooks': {
					\    'initialize': {
					\       'initializationOptions': {'cache': {'directory': '/tmp/ccls/cache'}},
					\       'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(findfile('compile_commands.json', expand('%:p') . ';'), ':p:h'))}
					\    },
					\   'textDocument/didOpen': {'metadata': {'extraFlags': ['-Wall']}},
					\ },
					\}
	endif
	if executable('pyls')
		let g:lsc_server_commands['python'] = 'pyls'
	endif
	if executable('gopls')
		let g:lsc_server_commands['go'] = {
					\ 'command': 'gopls serve',
					\ 'log_level': -1,
					\ 'suppress_stderr': v:true,
					\}
	endif
	if executable('typescript-language-server')
		let g:lsc_server_commands['javascript'] = {
					\ 'name': 'javascript support using typescript-language-server',
					\ 'command': 'typescript-language-server --stdio',
					\    'message_hooks': {
					\        'initialize': {
					\            'rootUri': {m, p -> lsc#uri#documentUri(fnamemodify(finddir('.git/', expand('%:p') . ';'), ':p:h'))}
					\        },
					\    },
					\}
	endif
endif
" 2}}} LSC
" Mucomplete {{{2 "
let g:mucomplete#user_mappings = {
			\'mini': "\<C-r>=MUcompleteMinisnip#complete()\<CR>",
			\ }
set completeopt+=menuone
"-----------
if has('patch-7.4.775')
	" Tab complete dont accept until told to
	set completeopt+=noselect
	let g:mucomplete#enable_auto_at_startup = 1
	"----------- completion chains
	set complete-=i
	set complete-=t

	imap <C-Space> <C-X><C-O>
	let g:mucomplete#wordlist = {
				\       '': ['gavinfreeborn@gmail.com', 'Gavin', 'Jaeger-Freeborn'],
				\ }
	let g:mucomplete#chains = {
				\ 'default'     : ['mini', 'list', 'omni', 'path', 'c-p',   'uspl'],
				\ 'html'        : ['mini', 'omni', 'path', 'c-p',  'uspl'],
				\ 'vim'         : ['mini', 'list', 'omni', 'path', 'cmd',   'keyp'],
				\ 'tex'         : ['mini', 'path', 'omni', 'uspl', 'c-p'],
				\ 'markdown'    : ['mini', 'path', 'c-p',  'uspl', 'dict'],
				\ 'dotoo'		: ['mini', 'path', 'c-p',  'uspl', 'dict'],
				\ 'sh'          : ['mini', 'omni', 'file', 'dict', 'keyp'],
				\ 'java'        : ['mini', 'tags', 'keyp', 'omni', 'c-n'],
				\ 'c'           : ['mini', 'list', 'omni', 'c-n'],
				\ 'go'          : ['mini', 'list', 'omni', 'c-n'],
				\ 'mail'		: ['mini', 'uspl', 'list', 'c-p'],
				\ }

	if !exists('g:mucomplete#can_complete')
		let  s:c_cond = { t -> t =~# '\%(->\|\.\)$' }
		let  s:latex_cond= { t -> t =~# '\%(\\\)$' }
		let  s:html_cond= { t -> t =~# '\%(<\/\)$' }
		let  g:mucomplete#can_complete = {}
		let  g:mucomplete#can_complete.c         =  {  'omni':  s:c_cond    }
		let  g:mucomplete#can_complete.python    =  {  'omni':  s:c_cond    }
		let  g:mucomplete#can_complete.go        =  {  'omni':  s:c_cond    }
		let  g:mucomplete#can_complete.markdown  =  {  'dict':  s:latex_cond  }
		let  g:mucomplete#can_complete.dotoo     =  {  'dict':  s:latex_cond  }
		let  g:mucomplete#can_complete.org       =  {  'dict':  s:latex_cond  }
		let  g:mucomplete#can_complete.html      =  {  'omni':  s:html_cond   }
	endif
	let g:mucomplete#no_popup_mappings = 0
	"spelling
	let g:mucomplete#spel#good_words = 1
endif
" 2}}} "Mucomplete
" TableMode {{{2 "
function! s:isAtStartOfLine(mapping)
	let text_before_cursor = getline('.')[0 : col('.')-1]
	let mapping_pattern = '\V' . escape(a:mapping, '\')
	let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
	return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
			\ <SID>isAtStartOfLine('\|\|') ?
			\ '<c-o>:TableModeEnable<cr><bar>' : '<bar><bar>'
" 2}}} "TableMode
" Signify {{{2 "
nnoremap <leader>hp :SignifyHunkDiff<cr>
nnoremap <leader>hu :SignifyHunkUndo<cr>
command! Diff :SignifyDiff
" 2}}} "Signify
" 1}}} "Plugin Configuration

" Functions And Commands: {{{1 "
" termdebug {{{2
nmap gD <Plug>DumpDebugStringVar
nmap gL <Plug>DumpDebugStringVar
command! -nargs=0 Debug :packadd termdebug<CR>:Termdebug
nnoremap <leader>bb :Break<CR>
nnoremap <leader>b] :Step<CR>
nnoremap <leader>b} :Over<CR>
nnoremap <leader>bp :call TermDebugSendCommand('print' . expand(<cword>) )<CR>
" 2}}} "termdebug
" Dead Simple Align {{{2 "
" Use a bunch of standard UNIX commands for quick an dirty
function! Align()
	exec "'<,'>!column -t|sed 's/  \(\S\)/ \1/g'"
	exec 'normal! gv='
endfunction
" 2}}} "Dead Simple Align
" CustomSections {{{2 "
function! CustomSections(dir, regex)
	if a:dir ==# 'up'
		call search(a:regex,'bW')
	else
		call search(a:regex,'W')
	endif
endfunction
" 2}}} "CustomSections
" White space {{{2
" Highlight whitespace problems.
nnoremap <Leader>ws :call ToggleShowWhitespace()<CR>
function! ToggleShowWhitespace()
	if !exists('b:showws')
		let b:showws = 1
	endif
	let pat = '^\t*\zs \+\|\s\+$\| \+\ze\t\|[^\t]\zs\t\+'
	if !b:showws
		syntax clear ExtraWhitespace
		let b:showws = 1
	else
		exec 'syntax match ExtraWhitespace "'.pat.'" containedin=ALL'
		exec 'normal! /' . pat
		let b:showws = 0
	endif
endfunction

" Highlight trailing whitespace characters
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" remove trailing whitespaces
command! StripWhitespace :%s/\s\+$//e
" 2}}} "White Space

nmap <silent> gs :set opfunc=dotvim#WebSearch<CR>g@
vmap <silent> gs :<C-u>call dotvim#WebSearch(visualmode(), 1)<Cr>

" Minimal Gist this is actually IX but i always think its XI
command! -range=% XI  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | xsel -i"
" sort based on visual block
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call dotvim#VisSort(<bang>0)
command! -register YankMatch call dotvim#YankMatches(<q-reg>)
command! -nargs=0 MW call dotvim#MkdirWrite()
command! -nargs=0 Todo call dotvim#Todo('~/Documents/org')
" 1}}} "Functions and Commands

" General Settings: {{{1 "
filetype plugin indent on
set encoding=utf-8      " allow emojis in vimrc
scriptencoding utf-8      " allow emojis in vimrc
if has('virtualedit')
	set virtualedit=block " virtual block can go anywhere
endif

if has('gui_running')
	call dotvim#LoadGui()
endif

set mouse=a           "Add mouse control not that I use them very much
set clipboard^=unnamed,unnamedplus	"xclip support
set tags+=.tags	  "make tagefiles hidden
set title             "Update window title
set hidden            "Allow to leave buffer without saving
set showcmd           "Show keys pressed in normal
set autochdir         "Auto cd
set tabstop=4         "Shorter hard tabs
set softtabstop=0     "Spaces are for wimps
set smarttab
set shiftwidth=4      "Shorter shiftwidth
set autoindent        "Auto indent newline
set ruler             "Show line number and column
set scrolljump=-15    "Jump 15 when moving cursor bellow screen
set belloff=all
set undofile          "Undo function after reopening
" set autowrite
" set autoread        "read/file when switching buffers
set lazyredraw        "redraw only when needed faster macros
set shortmess=aAtcT   "get rid of annoying messagesc
set incsearch         smartcase ignorecase hlsearch "better search
set backspace=2       "backspace through anything
set foldmethod=syntax "Enable folding
set foldlevel=99      "start with all folds open
set path+=**/*          "Autocompletion of path
set wildmenu          "Autocompletion of commands
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.tags,tags,*.o,*.class
set laststatus=2      "hide status bar for nvim
set splitbelow splitright

" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
if exists('##CmdLineEnter')
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif
" 1}}} "General Settings

" FileType Specific Stuff: {{{1 "
augroup GITCOMMITS
	" spelling for gitcommits
	autocmd FileType gitcommit silent call dotvim#WordProcessor()
	autocmd FileType gitcommit startinsert
augroup end
augroup AUTOEXEC
	autocmd!
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts.sh
	" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
augroup end

augroup VIM
	autocmd!
	" used by 
	autocmd BufRead *.vimrc nnoremap <buffer><silent> gx yi':!<C-R>=dotvim#Open()<CR> https://github.com/<C-r>0<CR>
augroup END

augroup WRIGHTING
	autocmd!
	autocmd FileType pandoc nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>
	autocmd BufRead,BufNewFile /tmp/neomutt* call dotvim#WordProcessor()
	autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'))
	autocmd FileType dotoo,org nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'))
	autocmd BufRead,BufNewFile *.md,*.tex,*.wiki call dotvim#WordProcessor()
	autocmd FileType markdown,pandoc,dotoo,org execute 'setlocal dict=~/.vim/extra/dict/latex_comp.txt'
augroup END

" 1 }}}" FileType Specific Stuff

" Abbreviations: {{{1 "
" Command Alias:  {{{2
fun! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun
call SetupCommandAlias('W','w')
call SetupCommandAlias("w'",'w')
call SetupCommandAlias('Wq','wq')
call SetupCommandAlias('Q','q')
call SetupCommandAlias('man','Man')
call SetupCommandAlias('git','!git')
" 2}}} Command Alias

" quickly print the date
iab <expr> dts strftime("%c")
"add a comment in any language
iab com <C-R>=&commentstring<CR><esc>F%c2w

" spelling
iab pyhton python
iab hte the
" 1}}} "Abbreviations

" Textobjects: {{{1
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

" line text-objects
" -----------------
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o0
onoremap al :normal val<CR>

" number text-objects (integer and float)
" ---------------------------------------
" in an
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal! v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :normal vin<CR>

" square brackets text-objects
" ----------------------------
" ir ar
xnoremap ir i[
xnoremap ar a[
onoremap ir :normal vi[<CR>
onoremap ar :normal va[<CR>

" quote text-objects
" ----------------------------
" iq aq
xnoremap iq i"
xnoremap aq a"
onoremap iq :normal vi"<CR>
onoremap aq :normal va"<CR>
" 1}}} "textobjects

" Etc {{{1 "
" Diffs: {{{2 "
if has('patch-8.0.0283')
	set diffopt=vertical,filler,context:3,
				\indent-heuristic,algorithm:patience,internal
endif
" 2}}} "Diffs
" Autoclose Quickfix {{{2 "
" auto close quickfix when quitting vim
augroup QFClose
	autocmd!
	autocmd WinEnter * if winnr('$') == 1
				\&& &buftype == "quickfix"|q|endif
augroup END

" 2}}}" Autoclose Quickfix
if filereadable(expand('~/.config/vimlocal'))
	source ~/.config/vimlocal
endif
"}}} Etc "
" vim:foldmethod=marker:foldlevel=0
