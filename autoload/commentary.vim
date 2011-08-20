" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim


" must return: { 'mode': MODE, 'comment_strings': CS }
" MODE: one of 'auto|comment|uncomment'
" CS: [start,end], end may be ""
fun! commentary#DefaultOptions()
  let o = { 'comment_strings':split(&commentstring,"%s",1) }
  for c in split(&comments,',')
    if c[0] == ':'
      " if item starts by : we've probably found a line comment. Prefer this
      let o.comment_strings = [c[1:], '']
    endif
  endfor
  return o
endfun


" fun: fun returning comments to be used
fun! commentary#CommentLineRange(lnum1, lnum2, action, ...)
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
      let ec = '/\"'
      " comment: drop before and after. if before is followed by space drop
      " that as well
      let line = substitute(getline(lnum),'^\(\s*\)'.escape(before, ec).' \?\(.*\)'.escape(after,ec).'\s*$','\1\2','')
    else
      let line = before.' '.getline(lnum).after
    endif
    call setline(lnum,line)
  endfor

endfun

fun! commentary#GoMove(dummy)
    call commentary#CommentLineRange(line("'["), line("']"), 'auto')
endfun
