let s:path = expand('%:p')
if stridx(s:path, 'pidgin') > -1
    setl noet sts=8 sw=8
    "cino=>2s,{1s,n-s,^-s sw=2 sts=2
endif
