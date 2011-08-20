" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim


" must return: { 'mode': MODE, 'comment_strings': CS }
" MODE: one of 'auto|comment|uncomment'
" CS: [start,end], end may be ""
function! commentary#DefaultOptions()
  let o = { 'comment_strings':split(&commentstring,"%s",1) }
  for c in split(&comments,',')
    if c[0] == ':'
      " if item starts by : we've probably found a line comment. Prefer this
      let o.comment_strings = [c[1:], '']
    endif
  endfor
  return o
endfunction


" fun: function returning comments to be used
function! commentary#CommentLineRange(lnum1, lnum2, action, ...)
  let opts = a:0 > 0 ? a:1 : commentary#DefaultOptions()

  let lnum1 = a:lnum1
  let lnum2 = a:lnum2
  let action = a:action

  let [before, after] = opts.comment_strings
  if action == "auto"
    let action = "uncomment"
    for lnum in range(lnum1,lnum2)
      let line = matchstr(getline(lnum),'\S.*\s\@<!')
      if line != '' && (stridx(line,before) || line[strlen(line)-strlen(after) : -1] != after)
        let action = "comment"
      endif
    endfor
  endif

  for lnum in range(lnum1,lnum2)
    if action == "uncomment"
      let line = substitute(getline(lnum),'\S.*\s\@<!','\=submatch(0)[strlen(before):-strlen(after)-1]','')
    else
      let line = substitute(getline(lnum),'\S.*\s\@<!','\=printf(before."%s".after,submatch(0))','')
    endif
    call setline(lnum,line)
  endfor

endfunction

function commentary#GoMove(dummy)
    call commentary#CommentLineRange(line("'["), line("']"), 'auto')
endfunction
