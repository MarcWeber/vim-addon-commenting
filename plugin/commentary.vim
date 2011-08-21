" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.0
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

" vam#DefineAndBind('g:commentary','s:c','{}')
if !exists('s:c') | let s:c = {} | endif | let g:commentary = s:c
let s:c['default_options'] = function('commentary#DefaultOptions')

" visual/selection mode, use C-V to comment at cursor col (limited by
" indentation of first current line)
xnoremap <silent> \\  :<C-U>call commentary#CommentLineRange(line("'<"), line("'>"), 'auto')<CR>
" movement \\
nnoremap <silent> \\  :<C-U>set opfunc=commentary#GoMove<CR>g@
" n\\\ will comment n lines. Having repeat#set will allow you repeating this
" \\\ action with . Not having it will show an error which doesn't hurt much
nnoremap <silent> \\\ :<C-U>call commentary#CommentLineRange(line("."), line(".") + v:count1 - 1, 'auto')
                      \ <bar>call repeat#set('\\\',v:count1)<CR>

" vim:set sw=2 sts=2:
