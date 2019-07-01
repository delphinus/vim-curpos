if exists('g:loaded_curpos')
  finish
endif
let g:loaded_curpos = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

augroup curpos
  autocmd!
  autocmd CursorMoved,CursorMovedI * call curpos#cursor_moved()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
