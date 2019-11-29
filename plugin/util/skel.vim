" File: v.vim
" Author: Gavin Jaeger-Freeborn
" Description: Simple Template functionality
  
function! s:load_skeleton(type, name)
	" do nothing if no filetype
	if empty(a:type) | return | endif
	if !(line('$') == 1 && getline('$') == '') || filereadable(expand('%:p'))
		return
	endif
	" glob every directory of rtp to search for skeleton/filetype
	let skeletons = globpath(&rtp, 'snip/skeleton/' . a:name , 0, 1)
	" let skeletons = globpath(&rtp, 'skeleton/' . a:type , 0, 1)
	" echoerr 'skeletons is ' . skeletons
	if empty(skeletons) 
		let skeletons = globpath(&rtp, 'snip/skeleton/' . a:type , 0, 1)
		if empty(skeletons)
			return 
		endif
	endif
	" read last skeleton into 1st line.
	exe '0read ' . skeletons[-1]
	exec 'normal! i'
endfunction

augroup aug_skeleton
	au!
	" BufNewFile event is trigged when you edit a new file.
	autocmd BufNewFile * call s:load_skeleton(&filetype, expand('%'))
augroup end
