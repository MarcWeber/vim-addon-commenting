" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || &cp || v:version < 700
  finish
endif
let g:loaded_commentary = 1

" visual/selection mode:
xnoremap <silent> \\  :<C-U>call commentary#CommentLineRange(line("'<"), line("'>"))<CR>
" movement \\
nnoremap <silent> \\  :<C-U>set opfunc=commentary#GoMove<CR>g@
" n\\\ will comment n lines. Having repeat#set will allow you repeating this
" \\\ action with . Not having it will show an error which doesn't hurt much
nnoremap <silent> \\\ :<C-U>call commentary#CommentLineRange(line("."), line(".") + v:count1 - 1)
                      \ <bar>call repeat#set('\\\',v:count1)<CR>

" vim:set sw=2 sts=2:
