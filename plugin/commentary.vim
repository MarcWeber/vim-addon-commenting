" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || &cp || v:version < 700
  finish
endif
let g:loaded_commentary = 1

xnoremap <silent> \\  :<C-U>call commentary#Go(visualmode())<CR>
nnoremap <silent> \\  :<C-U>set opfunc=commentary#Go<CR>g@
nnoremap <silent> \\\ :<C-U>call commentary#Go(v:count1)<CR>

" vim:set sw=2 sts=2:
