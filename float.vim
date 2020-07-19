"-------------------------------------------------------"
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


function! Openrc()
	let l:buf = CreateCenteredFloatingWindow()
	call nvim_set_current_buf(l:buf)
	execute 'e $MYVIMRC'		
endfunction

function! Open_popup() abort
  " let [row, col, anchor] = s:floatwin_pos(a:width, a:height, a:pos)

  let height = min([&lines - 4, max([20, &lines - 10])])
  let height -= 2

  let width = min([&columns - 4, max([80, &columns - 20])])
  let width -= 4

  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2

  let row = top
  let row += 1


  let col = left
  let col += 2

  let opts = {
    \ 'line': row,
    \ 'col': col,
    \ 'maxwidth': width,
    \ 'minwidth': width,
    \ 'maxheight': height,
    \ 'minheight': height,
    \ 'border': [1, 1, 1, 1],
    \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    \ 'borderhighlight': ['FloatermBorder'],
    \ 'padding': [0,1,0,1],
    \ 'highlight': 'Floaterm'
    \ }
  let winid = popup_create(a:bufnr, opts)
  call setbufvar(a:bufnr, '&filetype', 'floaterm')
  return winid
endfunction
