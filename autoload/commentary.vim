" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim


function! commentary#CommentLineRange(lnum1, lnum2, action)
  let lnum1 = a:lnum1
  let lnum2 = a:lnum2
  let action = a:action


  if action == "auto"
    let [before, after] = split(&commentstring,"%s",1)
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
      let line = substitute(getline(lnum),'\S.*\s\@<!','\=printf(&commentstring,submatch(0))','')
    endif
    call setline(lnum,line)
  endfor

endfunction

function commentary#GoMove(dummy)
    call commentary#CommentLineRange(line("'["), line("']"))
endfunction
