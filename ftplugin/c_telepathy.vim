let s:path = expand('%:p')
if stridx(s:path, 'tp') > -1
    setl et cino=>2s,{1s,n-s,^-s sw=2 sts=2
    if stridx(s:path, '/dbus-python') > -1
        setl cino< sw=4 sts=4 et
    endif
    if stridx(s:path, '/idle') > -1
        setl cino< sw=2 sts=2 ts=2 noet
    endif
endif
