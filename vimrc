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
	" Settings at ./plugin/mucomplete.vim
	let g:mymu_enabled=1
	Plug 'othree/jspc.vim', { 'for': ['javascript',  'html', 'javascript.jsx'] }
 	" This may not be needed
	Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'html', 'javascript.jsx'] }
	if exists('*job_start') || exists('*jobstart')
		Plug 'natebosch/vim-lsc'
	endif
	" Plug 'jcarreja/vim-customcpt'
	Plug 'lifepillar/vim-mucomplete', {'on' : []}
	Plug 'jonasw234/vim-mucomplete-minisnip'
else
	Plug 'skywind3000/vim-auto-popmenu'
	let g:apc_enable_ft = {'*':1} " enable for all filetypes
	set complete=.,k,w,b
	set completeopt=menu,menuone,noselect
endif
if has('nvim')
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

Plug 'eemed/vim-minisnip'
let g:name = 'Gavin Jaeger-Freeborn'
let g:email = 'gavinfreeborn@gmail.com'
let g:minisnip_trigger = '<C-f>'
let s:snipdir=globpath(&rtp, 'extra/snip')
let g:minisnip_dir = s:snipdir . ':' . join(split(glob( s:snipdir . '**/'), '\n'), ':')
imap <Nop> <Plug>(minisnip-complete)
" 2}}} "Snippets
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gpush', 'Gedit', 'Ggrep'] }
Plug 'HiPhish/info.vim'
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
Plug 'tpope/vim-speeddating', { 'for': 'org' }
Plug 'gavinok/spaceway.vim'
" 2}}} " My Plugins
" Tpope god bless the man {{{2 "
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease', {'on': []}
" 2}}} "Tpope
" etc {{{2 "
Plug 'tommcdo/vim-lion' " aligning text 
Plug 'wellle/targets.vim'
" only seek on the same line
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll'

Plug 'jelera/vim-javascript-syntax'
" color support
if executable('go')
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
	let g:Hexokinase_highlighters = [ 'backgroundfull' ]
endif

Plug 'axvr/zepl.vim'
Plug 'axvr/org.vim'
" 2}}} "etc.
call plug#end()
augroup zepl
	autocmd!
	autocmd FileType python     let b:repl_config = { 'cmd': 'python3' }
	autocmd FileType sh         let b:repl_config = { 'cmd': 'sh' }
	autocmd FileType r          let b:repl_config = { 'cmd': 'R' }
	autocmd FileType javascript let b:repl_config = { 'cmd': 'node' }
	autocmd FileType clojure    let b:repl_config = { 'cmd': 'clj' }
	autocmd FileType lisp       let b:repl_config = { 'cmd': 'sbcl' }
augroup END

" faster updates
set updatetime=100

augroup LazyLoadFugitive
	autocmd!
	autocmd CursorHold,CursorHoldI * call plug#load('vim-fugitive') | call plug#load('vim-scriptease') | autocmd! LazyLoadFugitive
augroup end

" Aesthetics: {{{2 "
colorscheme spaceway
set termguicolors
highlight Normal ctermbg=NONE
highlight Conceal ctermbg=NONE

set laststatus=2 "show statusbar

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
elseif g:colors_name !=# "acme"
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
set mouse=a                                         "Add mouse control not that I use them very much
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
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	runtime macro/matchit
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

nnoremap <silent> <leader>/        :nohlsearch<CR>

" if this is a normal buffer use <CR> to toggle folding
nmap <expr> <CR> &buftype ==# '' ? 'za' : "\<CR>"

" Find References
if executable('rg')
	set grepprg=rg\ --vimgrep
elseif executable('ag')
	set grepprg=ag\ --vimgrep
endif

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

"quick buffer navigation
nnoremap ]b :silent! bnext<CR>
nnoremap [b :silent! bprevious<CR>

" Find Files {{{2 "
nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
nnoremap <leader>b :b <C-d>
nnoremap <leader>fT  :setfiletype<space>
nnoremap <leader>ff  :Root<CR>:edit **/*
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
" nnoremap <leader>ft  :tjump<space>
nnoremap <leader>j :tjump /
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

cnoremap <C-N> <DOWN>
cnoremap <C-P> <UP>
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

"For Proper Tabbing And Bracket Insertion"
inoremap {<CR> {<CR>}<c-o><s-o>
inoremap (<CR> (<CR>)<c-o><s-o>

" commandline mappings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>

" when rightclicking highlight copy it
vmap <LeftRelease> "*ygv
nmap <RightMouse> gv
xmap <RightMouse> gx

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
nnoremap + m[viwb<esc>gUl`[
nnoremap <leader>+ V:s/\<./\u&/g <BAR> nohlsearch<CR>
xnoremap + :s/\<./\u&/g <BAR> nohlsearch<CR>

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
if exists('*job_start') || exists('*jobstart')
	command! -nargs=+ -complete=shellcmd Term call dotvim#TermCmd(<f-args>)
	command! -nargs=+ -complete=shellcmd Do call dotvim#Do(<f-args>)
	" dispatch compatability
	command! -bang -nargs=+ -complete=shellcmd Dispatch call dotvim#Do(<f-args>)
	command! -bang -nargs=+ -complete=file_in_path Grep call dotvim#Do(&grepprg,<f-args>)
	command! -bang -nargs=* -complete=file Make call dotvim#Do(&makeprg,<f-args>)
	nnoremap  '<CR>     :Term<Up><CR>
	nnoremap  '<Space>  :Term<Space>
	nnoremap  '<TAB>    :Term<Up>
	nnoremap  `<CR>     :Do<Up><CR>
	nnoremap  `<Space>  :Do<Space>
	nnoremap  `<TAB>    :Do<Up>
	nnoremap  m<CR>     :w\|Make<CR>
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
if executable('cabl')
let g:netrw_browsex_viewer='cabl' "force gx to use cabl if available
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
" Orgmode {{{2 "
" Simple implementation of org-capture using minisnip
function! CreateCapture(window)
	" if this file has a name
	let g:org_refile='~/Documents/org/refile.org'
	if expand('%:p') !=# ''
		let g:temp_org_file=printf('file:%s:%d', expand('%:p') , line('.'))
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/template.org')
	else
		exec a:window . ' ' . g:org_refile
		exec '$read ' . globpath(&rtp, 'extra/org/templatenofile.org')
	endif
	call feedkeys("i\<Plug>(minisnip)", 'i')
endfunction

function! W3m(url)
	let newurl = substitute(a:url, 'https\?:\/\/', '', 'g')
	call dotvim#TermCmd("w3m '" . newurl . "'")
endfunction

nmap gX :call W3m('<c-r>=expand('<cfile>')<CR>')<CR>

let g:org_state_keywords = [ 'TODO', 'NEXT', 'DONE', 'SOMEDAY', 'CANCELLED' ]
hi link orgHeading2 Normal
map <silent>gO :e ~/Documents/org<CR>
map <silent>gC :call CreateCapture('split')<CR>
command! -nargs=+ NGrep let s:gp=&gp|set gp+=\ -i| grep "<args>" ~/.local/Dropbox/Documents/org/**/*.org       |let &gp=s:gp|unl s:gp
com! -nargs=+ -complete=file GitGrep let s:gp=&gp|set gp=git\ grep\ -n|gr <args>|let &gp=s:gp|unl s:gp
command! -nargs=+ WikiGrep let s:gp=&gp|set gp+=\ -i| grep "<args>" ~/.local/Dropbox/DropsyncFiles/vimwiki/**/*.md|let &gp=s:gp|unl s:gp
" 2}}} "Orgmode
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
" Yank all matches in last search
command! -register YankMatch call dotvim#YankMatches(<q-reg>)
command! -nargs=0 MW call dotvim#MkdirWrite()
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
set autochdir                                       "Auto cd
set tabstop=4                                       "Shorter hard tabs
set softtabstop=0                                   "no spaces
set smarttab
set shiftwidth=4                                    "Shorter shiftwidth
set autoindent                                      "Auto indent newline
set ruler                                           "Show line number and column
set scrolljump=-15                                  "Jump 15 when moving cursor bellow screen
set undofile                                        "Undo function after reopening

" check that directories exist
if !isdirectory(expand('~/.cache/vim'))
	call mkdir($HOME.'/.cache/vim/undo', 'p')
	call mkdir($HOME.'/.cache/vim/backup', 'p')
endif
set undodir=$HOME/.cache/vim/undo
set backupdir=$HOME/.cache/vim/backup
" set autowrite
" set autoread                                      "read/file when switching buffers
set lazyredraw                                      "redraw only when needed faster macros
set shortmess=aAtcT                                 "get rid of annoying messagesc
set incsearch smartcase ignorecase hlsearch         "better search
set backspace=2                                     "backspace through anything
set foldmethod=syntax                               "Enable folding
set foldlevel=99                                    "start with all folds open
set path+=**/*                                      "Autocompletion of path
set wildmenu                                        "Autocompletion of commands
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.tags,tags,*.o,*.class
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
	autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'))
	autocmd FileType dotoo,org nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'))
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
call SetupCommandAlias('git','!git')
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
