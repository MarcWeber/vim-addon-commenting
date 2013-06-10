" Maintainer:   Marc Weber <marco-oweberNOSPAM@gmx.de>
" original auhtor: Tim Pope

" vam#DefineAndBind('s:c', 'g:commentary','{}')
if !exists('g:commentary') | let g:commentary = {} | endif | let s:c = g:commentary

let s:c['default_options'] = function('commentary#DefaultOptions')

let s:c.lhs_commenting = get(s:c, 'lhs_commenting', '\\')
let s:c.lhs_commenting_x = get(s:c, 'lhs_commenting_x', s:c.lhs_commenting)
let s:c.lhs_commenting_n = get(s:c, 'lhs_commenting_n', s:c.lhs_commenting)

let s:c.lhs_range = get(s:c, 'lhs_range', '\\\')

" visual/selection mode commenting/uncommenting
exec "xnoremap <silent> ". s:c.lhs_commenting_x ."  <c-v>:<C-U>call commentary#CommentLineRange(line(\"'<\"), line(\"'>\"), 'auto')<CR>"

                    " ^ <c-v> makes vim return col('.') correctly. Then comments are inserted at col
                    " of cursor (or first non whitespace char)

" movement \\
exec 'nnoremap <silent> '. s:c.lhs_commenting_n .'  :<C-U>set opfunc=commentary#GoMove<CR>g@'
" n\\\ will comment n lines. Having repeat#set will allow you repeating this
" \\\ action with . Not having it will show an error which doesn't hurt much
exec 'nnoremap <silent> '. s:c.lhs_range ." \\\ :<C-U>call commentary#CommentLineRange(line(\".\"), line(\".\") + v:count1 - 1, 'auto')"
	\ "<bar>call repeat#set('\\\',v:count1)<CR>"

" if you want to force commenting/ uncommenting create your own mappings
" replacing 'auto' by 'comment' or 'uncomment'

" if this plugin is is no feature complete try tcomment or NerdCommenter or
" any of the various other existing completion scripts

" vim:set sw=2 sts=2:
