"set guifont=Inconsolata\ 11
set guifont=Consolas:h10:cANSI
map <silent> <F2> :call FontToggle()<cr>
function! FontToggle()
  if &guifont == "Inconsolata 8"
    set guifont=Inconsolata\ 10
  elseif &guifont == "Inconsolata 10"
    set guifont=Inconsolata\ 8
  endif

  if &guifont == "monofur 8"
    set guifont=monofur\ 10
  elseif &guifont == "monofur 10"
    set guifont=monofur\ 8
  endif

  if &guifont == "DejaVu Sans Mono 9"
    set guifont=DejaVu\ Sans\ Mono\ 7
  elseif &guifont == "DejaVu Sans Mono 7"
    set guifont=DejaVu\ Sans\ Mono\ 9
  endif
endfunction

set background=dark
let Tlist_Show_Menu = 1

set mousemodel=popup

set guioptions-=T
"set guioptions-=m

":colorscheme Tomorrow
":colorscheme zellner
":colorscheme torte
":colorscheme desert
"map <silent> <S-F5> :colorscheme torte<cr>:call FontToggle()<cr>
:colorscheme solarized


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
