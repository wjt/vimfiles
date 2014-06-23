" Plugin File for E2 Writeups
" Move to ~/.vim/ftplugin/e2.vim
" Version: 0.2
" Author: Ian McCowan
" Updated: 07/30/2004

if !exists("no_plugin_maps") && !exists("no_e2_maps")
    " Maps for HTML entities
    inoremap <buffer>\\ \
    inoremap <buffer>\& &amp;
    inoremap <buffer>\<Space> &nbsp;
    inoremap <buffer>\[ &#91;
    inoremap <buffer>\] &#93;
    inoremap <buffer>\< &lt;
    inoremap <buffer>\> &gt;
    inoremap <buffer>\'a &aacute;
    inoremap <buffer>\`a &agrave;
    inoremap <buffer>\"a &auml;
    inoremap <buffer>\'e &eacute;
    inoremap <buffer>\`e &egrave;
    inoremap <buffer>\"e &euml;
    inoremap <buffer>\^e &ecirc;
    inoremap <buffer>\'i &iacute;
    inoremap <buffer>\`i &igrave;
    inoremap <buffer>\"i &iuml;
    inoremap <buffer>\^i &icirc;
    inoremap <buffer>\~n &ntilde;
    inoremap <buffer>\'o &oacute;
    inoremap <buffer>\`o &ograve;
    inoremap <buffer>\"o &ouml;
    inoremap <buffer>\/o &oslash;
    inoremap <buffer>\'u &uacute;
    inoremap <buffer>\`u &ugrave;
    inoremap <buffer>\"u &uuml;
    inoremap <buffer>\'y &yacute;
    inoremap <buffer>\"y &yuml;
endif

" When not done yet
if exists("b:did_ftplugin") || exists("e2_loaded")
    finish
endif
let b:did_ftplugin = 1

function MakeLink(...)
    " For creating links. Takes any number of arguments.
    " First argument (optional) is the number of words to be linked, default 1
    " Other arguments (optional) is the pipelink contents. If omitted,
    "   this will be a normal hardlink.
    let nwords = 1
    let linktext = ''
    " If there's an argument, see if it's a number.
    if (a:0 >= 1)
        if (a:1 =~ '\d\+')
            " If so, it's the number of words to link.
            let nwords = a:1
        else
            " Otherwise it's the first word of the pipelink.
            let linktext = a:1
        endif
    endif
    let index = 2
    while (index <= a:0)
        " Get the rest of the words in the pipelink.
        if (linktext != '')
            let linktext = linktext . " " . a:{index}
        else
            let linktext = a:{index}
        endif
        let index = index + 1
    endwhile
    " If it's a pipelink, it needs a pipe.
    if linktext != ""
        let linktext = linktext . "|"
    endif
    " Actually create the link.
    execute "normal l?\\A\<CR>a[" . l:linktext . "\<Esc>l" . l:nwords . "/\\A\<CR>i]\<Esc>"
endfunction

com -nargs=* Link call MakeLink(<f-args>)

com -nargs=? Click call LinkSearch(<f-args>)

function! Nr2Hex(nr)
    " The function Nr2Hex() returns the Hex string of a number.
    " Ganked from Michael Prokop
    " http://config.michael-prokop.at
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc

function CleanLink(LinkToClean)
    " Replace illegal characters in URIs with their %(hex) equivalents.
    let CharNr = 0x0
    let CleanedLink = a:LinkToClean
    let MessChar = matchstr(CleanedLink, "[^-a-zA-Z0-9%._~]")
    while char2nr(MessChar) != 0 
        let CharNr = Nr2Hex(char2nr(MessChar))
        let CleanedLink = substitute(CleanedLink, MessChar, "\%" . CharNr, "g")
        echo CleanedLink
        let MessChar = matchstr(CleanedLink, "[^-a-zA-Z0-9%._~]")
    endwhile
    return CleanedLink
endfunction

function PickWindow(windowtype)
    " Interpret argument of LinkSearch method.
    if (a:windowtype == "sp") || (a:windowtype == "")
        " Split the window and go to the new section.
        execute 'vsplit +1 ' . tempname() . '.e2'
    elseif (a:windowtype == "r")
        " Delete contents of this window.
        normal ggdG
    endif
endfunction

function LinkSearch(...)
    " Search e2 for the link or word under the cursor
    " and supply a list of the results.
    " Takes one optional argument, either 'sp' or 'r'
    "   'sp' will put the list in a new window, as will supplying no argument.
    "   'r' will put the list in the current window, REPLACING THE CONTENTS

    " Find out if the cursor is on a link.
    let s:LinkType = synIDattr(synID(line("."), col("."), 1), "name") 
    if (s:LinkType == "e2Link") || (s:LinkType == "e2Pipe")
        " If so, put the contents of the link in s:LinkText.
        call search("[", "b")
        let s:LinkBegin = col(".")
        call search("|\\|]")
        let s:LinkLength = col(".") - s:LinkBegin - 1
        let s:LinkText = strpart(getline("."), s:LinkBegin, s:LinkLength)
        " Characters such as spaces need special treatment in URIs.
        let s:LinkText = CleanLink(s:LinkText)
        unlet s:LinkBegin
        unlet s:LinkLength
    else
        " Otherwise, s:LinkPart contains the word beneath the cursor.
        call search("\\<", "b")
        let s:WordBegin = col(".") - 1
        call search("\\>")
        let s:WordLength = col(".") - s:WordBegin - 1
        let s:LinkText = strpart(getline("."), s:WordBegin, s:WordLength)
        unlet s:WordBegin
        unlet s:WordLength
    endif
    " Look at the argument and decide which window to use.
    let windowtype = ""
    if (a:0 == 1)
        let windowtype = a:1
    endif
    call PickWindow(windowtype)
    " Do the actual search.
    call append(0, system("curl -s -m30 'http://everything2.com/index.pl?node=E2%20XML%20Search%20Interface&keywords=" . s:LinkText . "'"))
    if (!v:shell_error)
        " Fix linebreaks.
        execute '%s/' . nr2char(10) . '/\r/g'
        execute '%s/' . nr2char(13) . '//g'
        " Parse XML, very very very crudely.
        %s/\%^\_.*<searchresults>\(\_.*\)<\/searchresults>\_.*\%$/\1/g
        %s/<e2link node_id="\d*">\(\p\{-}\)<\/e2link>/[\1]/g
        " Back to the top of the list.
        normal gg
    else
        echo "Error in the curl command; possible timeout."
    endif
endfunction

let e2_loaded = 1
