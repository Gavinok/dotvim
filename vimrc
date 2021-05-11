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
" automate remove trailing whitespace
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
"don't use any remote plugins so no need to load them
let g:loaded_rrhelper           =  1
let g:loaded_remote_plugins     =  1
let g:loaded_netrw              =  1
let g:loaded_netrwPlugin        =  1
" 1}}} "Quick Init

" Plugins: {{{1 "
" install vim-plug if it's not already
augroup PLUGGED
	if empty(glob('~/.vim/autoload/plug.vim'))  " Vim
		silent !curl -fo ~/.vim/autoload/plug.vim --create-dirs
					\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
augroup end
call plug#begin('~/.vim/plugged')
" Auto completion {{{2 "
if has('patch-7.4.775')
	Plug 'axvr/zepl.vim'
	let g:mymu_enabled=1
	let g:mylsc_enabled=1
	" Java completion is slow with lsp
	Plug 'artur-shaik/vim-javacomplete2', { 'for': ['java'] }
	" let g:JavaComplete_UsePython3 = 1
	if exists('*job_start') || exists('*jobstart')
		" Settings at ./plugin/lsc.vim
		Plug 'natebosch/vim-lsc'
	endif
	" Settings at ./plugin/mucomplete.vim
	Plug 'lifepillar/vim-mucomplete', {'on' : []}
	Plug 'jonasw234/vim-mucomplete-minisnip'
endif
if has('nvim')
	" floating preview window for Neovim
	Plug 'ncm2/float-preview.nvim'
	let g:float_preview#docked = 0
	set completeopt-=preview
else
	set completeopt+=preview
endif
" 2}}} "Auto completion
" Snippets {{{2 "
Plug 'Gavinok/vim-minisnip', { 'branch': 'optionalautoindent' }
let g:minisnip_autoindent = 0
let g:name = 'Gavin Jaeger-Freeborn'
let g:email = 'gavinfreeborn@gmail.com'
let g:minisnip_trigger = '<C-f>'
let s:snipdir=globpath(&runtimepath, '**/*extra/snip')
let g:minisnip_dir = s:snipdir . ':' . join(split(glob( s:snipdir . '**/'), '\n'), ':')
imap <Nop> <Plug>(minisnip-complete)
" 2}}} "Snippets
" Terminal {{{2 "
Plug 'christoomey/vim-tmux-navigator'
" 2}}} "Terminal
" Git {{{2 "
Plug 'tpope/vim-fugitive', { 'on': ['Gstatus', 'Gedit', 'Git'] }
if has('nvim') || has('patch-8.0.902')
	Plug 'mhinz/vim-signify'
endif
" 2}}} "Git
" Writing {{{2 "
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeEnable' }
let g:table_mode_map_prefix = '<Leader>T'
let g:table_mode_realign_map = '<Leader>TT'
let g:tex_conceal='abdgm'
" 2}}} "Writing
" My Plugins {{{2 "
Plug 'Gavinok/spaceway.vim'
Plug 'Gavinok/vim-troff'
" 2}}} " My Plugins
" Tpope god bless the man {{{2 "
Plug 'tpope/vim-speeddating', { 'for': [ 'org', 'dotoo', 'rec' ] }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' "Surround motion
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-scriptease', {'on': []}
" let g:helpful = 1
" 2}}} "Tpope
" etc {{{2 "
Plug 'tommcdo/vim-lion' " aligning text
" only seek on the same line

" color support
if executable('go')
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' , 'on' : [] }
	let g:Hexokinase_highlighters = [ 'backgroundfull' ]
endif
" Plug 'axvr/org.vim'
Plug 'dhruvasagar/vim-dotoo'
Plug 'emaniacs/OrgEval.vim'
let g:org_eval_run_cmd = { 
			\'python': 'python3',
			\'clojure': 'clojure',
			\'racket': 'racket',
			\'haskell': 'runhaskell',
			\'sh': 'sh',
			\'bash': 'bash',
			\'awk': 'awk -f',
			\'java': 'java --source 11',
			\'c': 'tcc -run',
			\'math': 'qalc',
			\'apl': 'apl -s',
			\'javascript': 'node',
			\'r': 'Rscript -'}

nmap <Nop> <Plug>(dotoo-capture)
Plug 'justinmk/vim-dirvish'
" 2}}} "etc.
call plug#end()

augroup LazyLoadPlug
	autocmd!
	autocmd CursorHold,CursorHoldI *
				\ call plug#load('vim-fugitive') |
				\ call plug#load('vim-scriptease') |
				\ call plug#load('vim-hexokinase') |
				\ autocmd! LazyLoadPlug
augroup end
" 1}}} "Plugins

" Aesthetics: {{{1 "
" colorscheme acme
colorscheme spaceway
highlight Normal ctermbg=NONE
highlight Conceal ctermbg=NONE

function! Statusline_expr()
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
let &statusline = Statusline_expr()
set laststatus=2 "show statusbar

if has('gui_running')
	call dotvim#LoadGui()
elseif exists('g:colors_name') && g:colors_name !=# 'acme'
	hi Normal      guibg=NONE
	hi ColorColumn guibg=NONE
	hi SignColumn  guibg=NONE
	hi Folded      guibg=NONE
	hi Conceal     guibg=NONE
	hi Terminal    guibg=NONE
	hi LineNr      guibg=NONE
endif
" 1}}} Aesthetics "

" General Mappings: {{{1
let g:mapleader="\\"
let maplocalleader = '|'
nmap <space> <leader>
xmap <space> <leader>

nnoremap <leader>y :let @+ = expand("%:p")<cr>

if has('nvim')
	set termguicolors
	set mouse=a                                         "Add mouse control not that I use them very much
	augroup TERMINAL
		autocmd!
		" autocmd BufWinEnter,WinEnter term://* startinsert
		autocmd BufLeave term://* stopinsert
		au TermOpen * setlocal nonumber
		au TermOpen * setlocal norelativenumber
		au TermOpen * setlocal nolist
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
	if has('patch-7.4.1649') " Enable % to go to matching keyword/tag
		packadd! matchit
	else
		runtime! macros/matchit.vim
	endif
endif
" shortcut to files and dirs uses shortcuts.sh
" it can be found at my scripts repo
runtime vimshortcuts.vim

" Open or compile file
map <silent><leader>co :!opout <c-r>%<CR><CR>
" Write To File As Sudo
nnoremap <leader>sudo :w !sudo tee > /dev/null %

" POSIX Commands
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
	set grepprg=grep\ -R\ -n\ --exclude-dir=.git,.cache
endif

" change variable and repeat with .
nnoremap c*			*Ncgn
nnoremap <C-N>      yiW/<C-r>0<CR>Ncgn
xnoremap <C-N>      y/<C-r>0<CR>Ncgn

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
nnoremap <leader>b   :b <C-d>
nnoremap <leader>ft  :setfiletype<space>
nnoremap <leader>ff  :edit <c-r>=FindRootDirectory()<CR>/**/*
nnoremap <leader>fo  :!<C-R>=dotvim#Open()<CR> <C-R>=fnameescape(expand('%:p:h'))<cr>/*<C-d>*&<Left><Left>
nnoremap <leader>j   :tjump /
nnoremap <leader>hh  :help<Space>

" bookmarked directories
nnoremap <leader>fp  :edit ~/Programming/**/*
nnoremap <leader>fd  :edit ~/Documents/**/*
nnoremap <leader>fw  :edit ~/.local/Dropbox/DropsyncFiles/vimwiki/**/**
nnoremap <leader>fv  :edit ~/.vim/**/*
nnoremap <leader>fh  :edit ~/**

nnoremap <leader>fj  :ME<space>
command! -nargs=1 -complete=customlist,dotvim#MRUComplete ME call dotvim#MRU('edit', <f-args>)
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
" if we have 3 * in a row make them into **/*
" this is only applied on the end of a line
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" full path shortcut
cnoreabbr <expr> %% fnameescape(expand('%:p'))

" better alternative to <C-W>_<C-W>\|
nnoremap <C-W>z		<C-W>_<C-W>\|
nnoremap <C-W><C-z>	<C-W>_<C-W>\|

"Better Mappings Imho
nnoremap gf gF
nnoremap Y  y$
xnoremap * "xy/<C-R>x<CR>

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
nmap <leader>t :set opfunc=dotvim#titlecase<CR>g@
xmap <leader>t :<C-U>call dotvim#titlecase(visualmode(),visualmode() ==# 'V' ? 1 : 0)<CR>
nmap <leader>T :set opfunc=dotvim#titlecase<Bar>exe 'norm! 'v:count1.'g@_'<CR>

"Insert Empty Line Above And Below
nmap <silent><leader>o  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
nmap <silent><leader>O  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>

" Quick spell correction shortcut
let g:quickdict='~/.vim/extra/dict/en_common.dict'
nnoremap <silent> <leader>ss :call dotvim#WordProcessor()<CR>
nmap <BS>         mz[s1z=`z

" Move a line of text
xnoremap J :m'>+<cr>`<my`>mzgv`yo`z
xnoremap K :m'<-2<cr>`>my`<mzgv`yo`z

snoremap <BS> <BS>i
" 1}}} "Editing

" Plugin Configuration: {{{1 "
" zepl {{{ "2
augroup zepl
    autocmd!
    autocmd FileType apl        let b:repl_config = { 'cmd': 'apl' }
    autocmd FileType sh         let b:repl_config = { 'cmd': 'dash' }
    autocmd FileType python     let b:repl_config = { 'cmd': 'python' }
    autocmd FileType scheme     let b:repl_config = { 'cmd': 'racket' }
    autocmd FileType racket     let b:repl_config = { 'cmd': 'racket' }
    autocmd FileType fennel     let b:repl_config = { 'cmd': 'fennel' }
    autocmd FileType math       let b:repl_config = { 'cmd': 'qalc' }
    autocmd FileType javascript let b:repl_config = { 'cmd': 'node' }
augroup END
" 2}}} "zepl
" tpipeline {{{ "2
" 	tpipeline comes bundled with its own custom minimal statusline seen above
" 	set laststatus=0 "show statusbar
" 	let g:tpipeline_cursormoved = 1
" 	let g:tpipeline_statusline = '%!Statusline_expr()'
" 	hi StatusLine ctermbg=NONE ctermfg=232 guibg=NONE guifg=#B3B8C4
" 2}}} "tpipeline
" Surround {{{2
imap <C-SPACE> <Plug>Isurround
" 2}}} "Surround
" dirvish {{{2
set noautochdir
augroup auto_ch_dir
	autocmd!
	autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! RootMe() | endif
augroup END
nmap gx :silent !$PLUMBER -s neovim -- "<c-r><c-f>"<cr>
vmap gx y:!$PLUMBER -c -- &<CR>
" }}} dirvish "2
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
" dict {{{2
function! Dict(word)
	"code
	exec 'new|read !dict '.a:word
	exec 'read !dict -dmoby-thesaurus '.a:word
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	setfiletype text
endfunction
command! -nargs=1 Dict call Dict(<q-args>)
" 2}}} "dict
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

set listchars=tab:→\ ,trail:·,nbsp:·                " Show white space
set list
set clipboard^=unnamed,unnamedplus                  "xclip support
set tags=.tags                                      "make tagefiles hidden
set tagcase=match                                   "match case when searching for tags
set title                                           "Update window title
set hidden                                          "Allow to leave buffer without saving
set showcmd                                         "Show keys pressed in normal
set tabstop=4                                       "Shorter hard tabs
set softtabstop=0                                   "no spaces
set smarttab
set conceallevel=2
set shiftwidth=4                                    "Shorter shiftwidth
set autoindent                                      "Auto indent newline
set scrolljump=-15                                  "Jump 15 when moving cursor bellow screen
set lazyredraw                                      "redraw only when needed faster macros
set shortmess=aAtcT                                 "get rid of annoying messagesc
set incsearch smartcase ignorecase hlsearch         "better search
set backspace=2                                     "backspace through anything
set foldmethod=syntax                               "Enable folding
set foldlevel=99                                    "start with all folds open
set wildmenu                                        "Autocompletion of commands
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.git/*,*.tags,tags,*.o,*.class,*.ccls-cache
set path+=**10
set splitbelow
set splitright

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

if has('nvim')
	set viminfo+=n$XDG_CACHE_HOME/vim/nviminfo
else
	set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
endif

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

augroup WRIGHTING
	autocmd!
	autocmd FileType markdown,pandoc nnoremap <buffer> <leader>i :<C-U>call dotvim#ImportScreenShot(function('dotvim#MarkdownScreenShot'),'.eps')
	autocmd FileType dotoo,org nnoremap <buffer> <leader>i       :<C-U>call dotvim#ImportScreenShot(function('dotvim#OrgScreenShot'),'.eps')
	autocmd FileType groff,troff,nroff nnoremap <buffer> <leader>i     :<C-U>call dotvim#ImportScreenShot(function('dotvim#GroffScreenShot'),'.eps')
	" autocmd FileType groff,troff,nroff nnoremap <buffer> <leader>i     :<C-U>call dotvim#ImportScreenShot(function('dotvim#NeatroffScreenShot'),'.eps')
	autocmd BufRead,BufNewFile *.md,*.tex,*.wiki call dotvim#WordProcessor()
	autocmd FileType markdown,pandoc,dotoo,org execute "setlocal dictionary+=". &runtimepath . '/extra/dict/latex_comp.txt'
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
call SetupCommandAlias('ss','s//g\<Left>\<Left>')
" 2}}} Command Alias

" spelling
iab pyhton python
iab hte the
iab cuz because
iab tf,  Therefore,
iab sin, Sincerely ,<CR>Gavin<SPACE>Jaeger-Freeborn
iab elect electron

" lorem ipsum
iab <expr> lorem system('curl -s http://metaphorpsum.com/paragraphs/1')
" 1}}} "Abbreviations

" Etc {{{1 "
" Diffs: {{{2 "
if has('patch-8.1.0283')
	set diffopt=vertical,filler,context:3,
				\indent-heuristic,algorithm:patience,internal
endif
" 2}}} "Diffs
" Local Settings {{{ "2
if filereadable(expand('~/.config/vimlocal'))
	source ~/.config/vimlocal
endif
" 2}}} "Local Settings
"}}} Etc "
" vim:foldmethod=marker:foldlevel=0
