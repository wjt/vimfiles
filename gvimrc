if has("win32")
  set guifont=Consolas:h10:cANSI
else
  "set guifont=Monospace\ 9
  "set guifont=Fantasque\ Sans\ Mono\ 10
  set guifont=Fira\ Code\ 9
endif

"set background=dark
let Tlist_Show_Menu = 1

set mousemodel=popup

set guioptions-=T
set guioptions-=m

let &guicursor = &guicursor . ",a:blinkon0"

if match($GTK_THEME, '.*:dark') >= 0
  set background=dark
endif
"vim: sw=2 sts=2 et
