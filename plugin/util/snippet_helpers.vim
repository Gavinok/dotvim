function! Argmaker(prearg)
	"code
                                                      
	let placeholder = a:prearg . g:minisnip_startdelim . g:minisnip_enddelim
	let g:count =search('%\l', 'bp', getcurpos()[1])
	if g:count != 0
		return placeholder
	else
		return ''
	endif
endfunction
