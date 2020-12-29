highlight clear

" for cterm, 'black' might get overwritten by the terminal emulator, so we use
" 232 (#080808), which is close enough.

highlight! Normal       guibg=#ffffea       guifg=#000000   ctermbg=NONE    ctermfg=232
highlight! Terminal     guibg=#ffffea       guifg=#000000   ctermbg=NONE    ctermfg=232
"          highlight!   NonText             guibg=bg        guifg=#ffffea   ctermbg=NONE   ctermfg=230
highlight! StatusLine   guibg=#aeeeee       guifg=#000000   gui=NONE        ctermbg=159    ctermfg=232    cterm=NONE
highlight! StatusLineNC guibg=#eaffff       guifg=#000000   gui=NONE        ctermbg=194    ctermfg=232    cterm=NONE
highlight! WildMenu     guibg=#000000       guifg=#eaffff   gui=NONE        ctermbg=black  ctermfg=159    cterm=NONE
highlight! VertSplit    guibg=#ffffea       guifg=#000000   gui=NONE        ctermbg=159    ctermfg=232    cterm=NONE
highlight! Folded       guibg=#ffffea       guifg=fg        gui=italic      ctermbg=230    ctermfg=130    cterm=italic
highlight! FoldColumn   guibg=NONE          guifg=fg        ctermbg=NONE    ctermfg=fg
highlight! Conceal      guibg=bg            guifg=fg        gui=NONE        ctermbg=NONE   ctermfg=fg     cterm=NONE
highlight! LineNr       guibg=bg            guifg=#505050   gui=italic      ctermbg=NONE   ctermfg=239    cterm=italic
highlight! Visual       guibg=#ffffca   guifg=NONE       gui=NONE ctermbg=15	ctermfg=NONE      cterm=NONE
highlight! VisualNOS    ctermbg=15       ctermfg=NONE   guibg=NONE        guifg=NONE     cterm=bold      gui=bold
highlight! CursorLine   guibg=#ffffca       guifg=fg        ctermbg=230     ctermfg=fg

highlight! Statement guibg=bg guifg=fg gui=italic ctermbg=NONE ctermfg=fg cterm=italic
highlight! Identifier guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! Type guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! PreProc guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! Constant guibg=bg guifg=#101010 gui=bold ctermbg=NONE ctermfg=233 cterm=italic
highlight! Comment guibg=bg guifg=#303030 gui=italic ctermbg=NONE ctermfg=236 cterm=italic
highlight! Special guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! SpecialKey guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! Directory guibg=bg guifg=fg gui=bold ctermbg=NONE ctermfg=fg cterm=bold
highlight! link Title Directory
highlight! link MoreMsg Comment
highlight! link Question Comment
highlight! Pmenu         guibg=#000000 guifg=#eaffff gui=NONE ctermbg=Lightgrey ctermfg=black cterm=NONE
highlight! PmenuSel      guifg=#000000 guibg=#eaffff gui=NONE ctermfg=Lightgrey ctermbg=black cterm=NONE
" vim
highlight! SignColumn guibg=#ffffea
highlight! link vimFunction Identifier

let g:colors_name = "acme"
