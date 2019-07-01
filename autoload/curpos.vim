let s:buf = v:null
let s:winid = v:null

function! curpos#cursor_moved() abort
  call curpos#show()
endfunction

function! curpos#show() abort
  if curpos#is_disabled()
    return
  endif

  let [bufnum, lnum, col, off, curswant] = getcurpos()
  if col is curswant
    let pos = printf('%3d/%-2d', lnum, col)
  else
    let pos = printf('%3d/%d-%d', lnum, col, curswant)
  endif

  if !s:buf
    let s:buf = nvim_create_buf(v:false, v:true)
  endif

  call setbufline(s:buf, 1, pos)

  if s:winid && nvim_win_is_valid(s:winid)
    call nvim_win_set_config(s:winid, {
          \ 'relative': 'cursor',
          \ 'width': len(pos), 'height':1,
          \ 'col': 1, 'row': 1,
          \ })
  else
    let s:winid = nvim_open_win(s:buf, v:false, {
          \ 'relative': 'cursor',
          \ 'width': len(pos), 'height': 1,
          \ 'col': 1, 'row': 1,
          \ })
    call nvim_win_set_option(s:winid, 'number', v:false)
    call nvim_win_set_option(s:winid, 'relativenumber', v:false)
    call nvim_win_set_option(s:winid, 'list', v:false)
  endif
endfunction

function! curpos#is_disabled() abort
  let m = mode(1)
  return m isnot? 'v' && m isnot "\<C-v>"
endfunction
