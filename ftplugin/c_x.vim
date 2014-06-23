let s:path = expand('%:p')
if stridx(s:path, 'xorg') > -1
    " :0
    "     place case labels at the same level as the switch's brace.
    " t0
    "     return types should live on the margin
    " (0
    "     line up nested parens with the first char inside the previous paren
    setl noet sw=8 sts=8 cino=:0,t0,(0
endif
