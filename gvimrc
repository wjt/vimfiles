if has("win32")
  set guifont=Consolas:h10:cANSI
else
  set guifont=Monospace\ 10
endif

set background=dark
let Tlist_Show_Menu = 1

set mousemodel=popup

set guioptions-=T
set guioptions-=m

let &guicursor = &guicursor . ",a:blinkon0"

" let g:devhelpSearch=1
" let g:devhelpWordLength=7
" source ~/.vim/devhelp.vim
" 
" map <silent> <F6> :call ToggleAssistant()<cr>
" function ToggleAssistant ()
"     if exists('g:devhelpAssistant') && g:devhelpAssistant
"         let g:devhelpAssistant=0
"     else
"         set updatetime=500
"         let g:devhelpAssistant=1
"         " Resource the file to make the assistant work
"         source ~/.vim/devhelp.vim
"     endif
" endfunction

"vim: sw=2 sts=2 et
