if has("win32")
  set guifont=Consolas:h10:cANSI
else
  set guifont=Monospace\ 9
endif

"set background=dark
let Tlist_Show_Menu = 1

set mousemodel=popup

set guioptions-=T
set guioptions-=m

let &guicursor = &guicursor . ",a:blinkon0"

"vim: sw=2 sts=2 et
