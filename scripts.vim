if did_filetype()
    finish
endif

" Read first line
let s:line = getline(1)

" If it's not a shebang, we're done
if s:line !~# '^#!'
  finish

" Python
elseif s:line =~# '\<python\d*\>'
  setfiletype python

" Bash
elseif s:line =~# '\<bash\d*\>'
  let b:is_bash = 1
  setfiletype sh

" treat all other shells ash posix shell 
" cuz its best shell.
elseif s:line =~# '\<sh\>'
  let b:is_posix = 1
  setfiletype sh
