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
if has('nvim')
	set runtimepath^=~/.vim runtimepath+=~/.vim/after
endif
" block plugins and extra dependency's
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
" Disable extra plugins
let g:loaded_gzip               =  1
let g:loaded_tarPlugin          =  1
let g:loaded_zipPlugin          =  1
let g:loaded_2html_plugin       =  1
let g:loaded_fzf                =  1
"dont use any remote plugins so no need to load them
let g:loaded_rrhelper           =  1
let g:loaded_remote_plugins     =  1
let g:loaded_netrw              =  1
let g:loaded_netrwPlugin        =  1
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

" Autocompletion {{{2 "
if has('patch-7.4.775')
	let g:mymu_enabled=1
	Plug 'othree/jspc.vim', { 'for': ['javascript',  'html', 'javascript.jsx'] }
	" This may not be needed
	Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html', 'javascript.jsx'] }
	" java completion is slow with lsp
	Plug 'artur-shaik/vim-javacomplete2'
	if exists('*job_start') || exists('*jobstart')
		" Settings at ./plugin/lsc.vim
		Plug 'natebosch/vim-lsc'
		" Settings at ./plugin/lsp.vim
		" Plug 'prabirshrestha/async.vim'
		" Plug 'prabirshrestha/vim-lsp'
	endif
	" Plug 'jcarreja/vim-customcpt'
	" Settings at ./plugin/mucomplete.vim
	Plug 'lifepillar/vim-mucomplete', {'on' : []}
	Plug 'jonasw234/vim-mucomplete-minisnip'
endif
if has('nvim')
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
	" floating preview window for neovim
	Plug 'ncm2/float-preview.nvim'
	set completeopt-=preview
	let g:float_preview#docked = 0
else
	set completeopt+=preview
	" set completeopt+=popup
endif
" 2}}} "Autocompletion
" Snippets {{{2 "
Plug 'mattn/emmet-vim', { 'for' : ['html'] }

Plug 'Gavinok/vim-minisnip', { 'branch': 'optionalautoindent' }
" Plug 'henricattoire/aergia'
let g:minisnip_autoindent = 0
let g:name = 'Gavin Jaeger-Freeborn'
let g:email = 'gavinfreeborn@gmail.com'
let g:minisnip_trigger = '<C-f>'
" let g:aergia_key = '<c-f>'
let g:aergia_snippets = '/home/gavinok/.vim/extra/snip'
let s:snipdir=globpath(&runtimepath, 'extra/snip')
let g:minisnip_dir = s:snipdir . ':' . join(split(glob( s:snipdir . '**/'), '\n'), ':')
imap <Nop> <Plug>(minisnip-complete)
" 2}}} "Snippets
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gpush', 'Gedit', 'Ggrep'] }
if has('nvim') || has('patch-8.0.902')
	Plug 'mhinz/vim-signify'
else
	Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
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
" My Pluggins {{{2 "
Plug 'tpope/vim-speeddating', { 'for': [ 'org', 'dotoo' ] }
Plug 'gavinok/spaceway.vim'
" 2}}} " My Plugins
" Tpope god bless the man {{{2 "
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease', {'on': []}
Plug 'tweekmonster/helpful.vim'
" let g:helpful = 1
" 2}}} "Tpope
" etc {{{2 "
Plug 'tommcdo/vim-lion' " aligning text 
" Plug 'wellle/targets.vim'
" only seek on the same line
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll'

Plug 'jelera/vim-javascript-syntax'
" color support
if executable('go')
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
	let g:Hexokinase_highlighters = [ 'backgroundfull' ]
endif

" Plug 'axvr/org.vim'
Plug 'dhruvasagar/vim-dotoo'
nmap <Nop> <Plug>(dotoo-capture)
Plug 'justinmk/vim-dirvish'
" 2}}} "etc.
call plug#end()

" faster updates
set updatetime=100

augroup LazyLoadFugitive
	autocmd!
	autocmd CursorHold,CursorHoldI * call plug#load('vim-fugitive') | call plug#load('vim-scriptease') | autocmd! LazyLoadFugitive
augroup end

" Aesthetics: {{{2 "
colorscheme spaceway
highlight Normal ctermbg=NONE
highlight Conceal ctermbg=NONE


if exists('g:started_by_firenvim')
	set laststatus=0
else
	set laststatus=2 "show statusbar
endif

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
" highlight User1 ctermbg=107  ctermfg=black guibg=#87af5f guifg=black
" highlight User2 ctermbg=103  ctermfg=black guibg=#8787af guifg=black
" highlight User3 ctermbg=59   ctermfg=black guibg=#5f5f5f guifg=black

if has('gui_running')
	call dotvim#LoadGui()
elseif g:colors_name !=# 'acme'
	hi Normal      guibg=NONE
	hi ColorColumn guibg=NONE
	hi SignColumn  guibg=NONE
	hi Folded      guibg=NONE
	hi Conceal     guibg=NONE
	hi Terminal    guibg=NONE
	hi LineNr      guibg=NONE
endif

" 2}}} Aesthetics "
" 1}}} "Plugins

" General Mappings: {{{1
let g:mapleader="\\"
let maplocalleader = '|'
nmap <space> <leader>
xmap <space> <leader>

nnoremap <leader>y :let @+ = expand("%:p")<cr>

if has('nvim')
	set termguicolors
	set mouse=a                                         "Add mouse control not that I use them very much
	" when rightclicking highlight copy it
	xmap <LeftRelease> "*ygv
	nmap <RightMouse> gv
	xmap <RightMouse> gx
	nmap <MiddleDrag> :Term <c-r><c-w>
	nmap <MiddleMouse> :Term <c-r><c-w>
	xmap <MiddleMouse> y:Term <c-r>0

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
	set inccommand=nosplit
	" tell neovim where runtime is
	let &packpath = &runtimepath
else
	set timeout           " for mappings
	set timeoutlen=1000   " default value
	set ttimeout          " for key codes
	set ttimeoutlen=10    " unnoticeable small value
	" set Vim-specific sequences for RGB colors allowing for gui colors
	" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	if has('patch-7.4.1649') " Enable % to go to matching keyword/tag
		packadd! matchit
	else
		runtime! macros/matchit.vim 
	endif
endif
" shortcut to files and dirs uses shortcuts.sh
" it can be found at my scripts repo
runtime vimshortcuts.vim
" delete a buffer
" nnoremap <leader>bd :bdelete<CR>

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

" mark position before search
nnoremap / ms/

nnoremap <silent> <leader>/ :nohlsearch<CR>

" if this is a normal buffer use <CR> to toggle folding
nmap <expr> <CR> &buftype ==# '' ? 'za' : "\<CR>"

" Find References
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat^=%f:%l:%c:%m
elseif executable('ag')
	set grepprg=ag\ --vimgrep
else
	set grepprg=grep\ -r\ -n\ --exclude-dir=.git,.cache
	" set grepprg=find\ -iname
	" set grepformat=%f
endif
" nmap gW :grep <C-R><C-W>
command! -nargs=+ WikiGrep let s:gp=&gp|set gp+=\ -i| grep "<args>" ~/.local/Dropbox/DropsyncFiles/vimwiki/**/*.md|let &gp=s:gp|unl s:gp

" change variable and repeat with .
nnoremap c*			*Ncgn
nnoremap <C-N>      yiW/<C-r>0<CR>Ncgn
xnoremap <C-N>      y/<C-r>0<CR>Ncgn
nnoremap <leader>n  yiw:%s/<C-r>0//gc<left><left><left>
xnoremap <leader>n  y:%s/<C-r>0//gc<left><left><left>

map ]a :silent! cnext<CR>
map [a :silent! cprevious<CR>
map ]A :silent! lnext<CR>
map [A :silent! lprevious<CR>

map ]t :silent! tnext<CR>
map [t :silent! tprevious<CR>

"quick buffer navigation
nnoremap ]b :silent! bnext<CR>
nnoremap [b :silent! bprevious<CR>

" Find Files {{{2 "
nnoremap <leader>a   :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>b   :b <C-d>
nnoremap <leader>fT  :setfiletype<space>
nnoremap <leader>ff  :edit <c-r>=FindRootDirectory()<CR>/**/*
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
nnoremap <leader>j   :tjump /
nnoremap <leader>hg  :helpgrep .*.*<Left><Left>
nnoremap <leader>hh  :help<Space>

" bookmarked directories
nnoremap <leader>fp  :edit ~/Programming/**/*
nnoremap <leader>fd  :edit ~/Documents/**/*
nnoremap <leader>fw  :edit ~/.local/Dropbox/DropsyncFiles/vimwiki/**/**
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fh  :edit ~/**

nnoremap <leader>fj  :ME<space>
command! -nargs=1 -complete=customlist,dotvim#MRUComplete ME call dotvim#MRU('edit', <f-args>)

let g:shortcuts = ['~/.scripts', '~/.config']
nnoremap <leader>fs  :Sc<space>
command! -nargs=1 -complete=customlist,dotvim#ShortcutComplete Sc call dotvim#Shortcut('edit', <f-args>)
" 2}}} "Find Files

" better navigation of command history
" allow next completion after / alternative
" is <C-E> if <C-D> makes to long of a list
if has('nvim-0.5.0')
	cnoremap <expr> / wildmenumode() ? "\<C-Y>" : "/"
else
	cnoremap <expr> / wildmenumode() ? "\<C-E>" : "/"
endif


"quick substitution
xnoremap ss :s//g<left><left>
cnoremap <expr> <SPACE> dotvim#CSPACE()
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))

" better alternative to <C-W>_<C-W>\|
nnoremap <C-W>z		:silent call dotvim#ZoomToggle()<CR>
nnoremap <C-W><C-z>	:silent call dotvim#ZoomToggle()<CR>

"Better Mappings Imho
nnoremap gf gF
nnoremap Y  y$
xnoremap * "xy/<C-R>x<CR>

"i never use s so make it d wthout cutting
nmap <silent> s "_d

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
inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

"For Proper Tabbing And Bracket Insertion"
inoremap {<CR> {<CR>}<c-o><s-o>
inoremap (<CR> (<CR>)<c-o><s-o>

" commandline mappings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>
" inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

" Toggle Quickfix
nnoremap <script> <silent> <leader>v :call dotvim#ToggleQuickfix()<CR>
" Quick format file
nnoremap gQ :<C-U>call dotvim#FormatFile()<CR>
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
nmap <leader>t :<C-U>set opfunc=dotvim#titlecase<CR>g@
xmap <leader>t :<C-U> call dotvim#titlecase(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
nmap <leader>T :<C-U>set opfunc=dotvim#titlecase<Bar>exe 'norm! 'v:count1.'g@_'<CR>

"Insert Empty Line Above And Below
map <silent><leader>o  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
map <silent><leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>

" Quick spell correction shortcut
let g:quickdict='~/.vim/extra/dict/en_common.dict'
nnoremap <silent> <leader>ss :call dotvim#WordProcessor()<CR>
nmap <BS>         mz[s1z=`z
nmap <leader><BS> 1z=

" Move a line of text
xnoremap J :m'>+<cr>`<my`>mzgv`yo`z
xnoremap K :m'<-2<cr>`>my`<mzgv`yo`z
xnoremap < <gv
xnoremap > >gv

snoremap <BS> <BS>i
" 1}}} "Editing

" Plugin Configuration: {{{1 "
" Minimal Async Command {{{2
" TODO: make fallbacks for ` and m if jobs dont exist <05-05-20 Gavin Jaeger-Freeborn>
if exists('*job_start') || exists('*jobstart')
	command! -nargs=+ -complete=shellcmd Term call dotvim#TermCmd(<f-args>)
	command! -nargs=* -complete=file TMake call dotvim#TermCmd(&makeprg,<f-args>)
	command! -nargs=+ -complete=shellcmd Do call dotvim#Do(<f-args>)


	" dispatch compatability
	command! -bang -nargs=+ -complete=shellcmd Dispatch call dotvim#Do(<f-args>)
	command! -bang -nargs=+ -complete=file_in_path Grep call dotvim#Do(&grepprg,<f-args>)
	command! -bang -nargs=* -complete=file Make call dotvim#Do(&makeprg,<f-args>)
	nnoremap  '<CR>     :Term<Up><CR>
	nnoremap  '<Space>  :Term<Space>
	nnoremap  '<TAB>    :Term<Up>
	nnoremap  mt        :silent w\|TMake<CR>
	nnoremap  `<CR>     :Do<Up><CR>
	nnoremap  `<Space>  :Do<Space>
	nnoremap  `<TAB>    :Do<Up>
	nnoremap  m<CR>     :w\|Make<CR>
	nnoremap  m<Space>  :Make<Space>
	nnoremap  m!		:setlocal makeprg=compiler\ %<CR>
	nnoremap  m?		:echo &makeprg<CR>
	nnoremap <leader>mm :call dotvim#ToggleAutocompile()<CR>
	"async tagging
	nnoremap <leader>T  :call dotvim#Quicktag(0)<CR>
	" asyncronus manpages
	let g:loaded_man 				=  1
	command! -nargs=+ -complete=shellcmd Man call dotvim#Man(<f-args>)
else
	nnoremap  `<TAB>    :!<Up>
	nnoremap  `<Space>  :!
	nnoremap  m!        :make!<Space>
	nnoremap  m<CR>		:make!<CR>
endif
" 2}}} "Minimal Async Command
" dirvish {{{2 
set noautochdir
augroup auto_ch_dir
	autocmd!
	autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
augroup END
nmap gx :silent !$PLUMBER -s neovim -- "<c-r><c-f>"<cr>
vmap gx :silent !$PLUMBER -s neovim -- "<c-r><c-f>"<cr>
" }}} dirvish "2
" netrw {{{2
" Poor mans Vim vinegar
" set autochdir                                       "Auto cd
if !empty($PLUMBER)
	let g:netrw_browsex_viewer='setsid ' . $PLUMBER . ' -s neovim --' "force gx to use cabl if available
endif
let g:netrw_sort_options = 'i'
let g:netrw_banner=0 "disable banner
let g:netrw_fastbrowse=2
let g:netrw_localrmdir='rm -r'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" move up a directory and focus on the file
nmap - :call dotvim#Opendir('edit')<CR>

augroup netrw_mapping
	autocmd!
	autocmd FileType netrw setl bufhidden=delete
	autocmd Filetype netrw call dotvim#NetrwMapping()
augroup end
" 2}}} "netrw
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
" info {{{2
function! InfoMappings()
	nmap <buffer> <c-n> <Plug>(InfoNext)
	nmap <buffer> <c-p> <Plug>(InfoPrev)
	nmap <buffer> gu <Plug>(InfoUp)
endfunction
augroup info
	" this one is which you're most likely to use?
	autocmd FileType info call InfoMappings()
augroup end
" 2}}} "info
" 1}}} "Plugin Configuration

" Functions And Commands: {{{1 "
" termdebug {{{2
" nmap gD <Plug>DumpDebugStringVar
" nmap gL <Plug>DumpDebugStringVar
" command! -nargs=0 Debug :packadd termdebug<CR>:Termdebug
" nnoremap <leader>bb :Break<CR>
" nnoremap <leader>b] :Step<CR>
" nnoremap <leader>b} :Over<CR>
" nnoremap <leader>bp :call TermDebugSendCommand('print' . expand(<cword>) )<CR>
" 2}}} "termdebug
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
" VisualSort {{{2
" sort based on visual block
command! -range -nargs=0 -bang SortVis sil! keepj <line1>,<line2>call dotvim#VisSort(<bang>0)
" use s to sort visual selection
xmap s :SortVis<CR>
" 2}}} "VisualSort
" Extra commands {{{2
" Minimal Gist this is actually IX but i always think its XI
command! -range=% XI  silent execute <line1> . "," . <line2> . "w !curl -F 'f:1=<-' ix.io | tr -d '\\n' | xsel -i"
" Hub
command! -range=% Gist  silent execute <line1> . "," . <line2> . "w !hub gist create -c -"
command! -nargs=0 Gissue :Term hub issue
" Yank all matches in last search
command! -register YankMatch call dotvim#YankMatches(<q-reg>)
command! -nargs=0 Todo call dotvim#Todo('~/Documents/org')
" 2}}} "Extra commands
" 1}}} "Functions and Commands

" General Settings: {{{1 "
filetype plugin indent on
set encoding=utf-8                                  " allow emojis in vimrc
scriptencoding utf-8                                " allow emojis in vimrc
if has('virtualedit')
	set virtualedit=block                           " virtual block can go anywhere
endif

set clipboard^=unnamed,unnamedplus	                "xclip support
set tags+=.tags;	                                "make tagefiles hidden
set tags+=./.tags;../.tags                          "extra directories
set title                                           "Update window title
set hidden                                          "Allow to leave buffer without saving
set showcmd                                         "Show keys pressed in normal
set tabstop=4                                       "Shorter hard tabs
set softtabstop=0                                   "no spaces
set smarttab
set shiftwidth=4                                    "Shorter shiftwidth
set autoindent                                      "Auto indent newline
set ruler                                           "Show line number and column
set scrolljump=-15                                  "Jump 15 when moving cursor bellow screen
set lazyredraw                                      "redraw only when needed faster macros
set shortmess=aAtcT                                 "get rid of annoying messagesc
set incsearch smartcase ignorecase hlsearch         "better search
set backspace=2                                     "backspace through anything
set foldmethod=syntax                               "Enable folding
set foldlevel=99                                    "start with all folds open
set path=**/*                                      "Autocompletion of path
set wildmenu                                        "Autocompletion of commands
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*,*.tags,tags,*.o,*.class
set splitbelow splitright

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
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo


" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
if exists('##CmdLineEnter')
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif
" 1}}}                   "General Settings

" FileType Specific Stuff: {{{1 "
augroup GITCOMMITS
	" spelling for gitcommits
	autocmd!
	autocmd FileType gitcommit silent call dotvim#WordProcessor()
	autocmd FileType gitcommit startinsert
augroup end
augroup AUTOEXEC
	autocmd!
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts.sh
	" Run xrdb whenever Xresources are updated.
	autocmd BufWritePost *Xresources !xrdb ~/.Xresources
augroup end

augroup VIM
	autocmd!
	" used by
	autocmd BufRead *.vimrc nnoremap <buffer><silent> gx yi':!<C-R>=dotvim#Open()<CR> https://github.com/<C-r>0<CR>
augroup END

augroup WRIGHTING
	autocmd!
	autocmd FileType pandoc nnoremap <buffer> cic :call pandoc#after#nrrwrgn#NarrowCodeblock()<cr>
	autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'),'.png')
	autocmd FileType dotoo,org nnoremap <buffer> <leader>i       :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'),'.png')
	autocmd FileType groff,nroff nnoremap <buffer> <leader>i     :<C-U>call dotvim#ImportScreenShot(function('dotvim#GroffScreenShot'),'.eps')
	autocmd BufRead,BufNewFile *.md,*.tex,*.wiki call dotvim#WordProcessor()
	autocmd FileType markdown,pandoc,dotoo,org execute 'setlocal dictionary+=~/.vim/extra/dict/latex_comp.txt'
augroup END

" 1 }}}" FileType Specific Stuff

" Abbreviations: {{{1 "
" Command Alias:  {{{2
function! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction
call SetupCommandAlias('W','w')
call SetupCommandAlias("w'",'w')
call SetupCommandAlias('Wq','wq')
call SetupCommandAlias('Q','q')
call SetupCommandAlias('man','Man')
call SetupCommandAlias('git','Git')
call SetupCommandAlias('cp','!cp')
call SetupCommandAlias('mv','!mv')
call SetupCommandAlias('rm','!rm')
call SetupCommandAlias('mkdir','!mkdir')
" 2}}} Command Alias

" quickly print the date
iab <expr> dts strftime("%c")
"add a comment in any language
" iab com <C-R>=&commentstring<CR><esc>F%c2w

" spelling
iab pyhton python
iab hte the
" 1}}} "Abbreviations

" Etc {{{1 "
" Diffs: {{{2 "
if has('patch-8.0.0283')
	set diffopt=vertical,filler,context:3,
				\indent-heuristic,algorithm:patience,internal
endif
" 2}}} "Diffs
if filereadable(expand('~/.config/vimlocal'))
	source ~/.config/vimlocal
endif
"}}} Etc "
" vim:foldmethod=marker:foldlevel=0
