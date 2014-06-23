" Vim syntax file for e2 writeups
" Move to ~/.vim/syntax/e2.vim
" Adapted from html.vim
" Language:	everything2 writeup
" Maintainer:	Ian McCowan <imccowan@fastmail.fm>
" Last Change:  2004 July 10

" Please check :help e2.vim for some comments and a description of the options

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'e2'
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

if has('linebreak')
    set wrap
    set linebreak
endif

syn case ignore

" mark illegal characters
syn match htmlError /[<>&[\]]/

" e2 links
syn region  e2Link      start=/\[/  end=/\]/    contains=e2Pipe,e2LinkError oneline
syn match   e2Pipe      /|/ contained 
syn match   e2LinkError /[^\]]\[/ contained

" tags
syn region  htmlString   contained start=+"+ end=+"+ contains=htmlSpecialChar
syn region  htmlString   contained start=+'+ end=+'+ contains=htmlSpecialChar
syn match   htmlValue    contained "=[\t ]*[^'" \t>][^ \t>]*"hs=s+1
syn region  htmlEndTag             start=+</+      end=+>+ contains=htmlTagN,htmlTagError
syn region  htmlTag                start=+<[^/]+   end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlCssDefinition,@htmlArgCluster
syn match   htmlTagN     contained +<\s*[-a-zA-Z0-9]\++hs=s+1 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagN     contained +</\s*[-a-zA-Z0-9]\++hs=s+2 contains=htmlTagName,htmlSpecialTagName,@htmlTagNameCluster
syn match   htmlTagError contained "[^>]<"ms=s+1


" tag names

syn keyword htmlCodeTag contained code pre

syn keyword htmlTagName contained abbr acronym
syn keyword htmlTagName contained big blockquote br
syn keyword htmlTagName contained cite dd del dl dt
syn keyword htmlTagName contained hr ins
syn keyword htmlTagName contained kbd li
syn keyword htmlTagName contained ol p q s samp
syn keyword htmlTagName contained small strike strong sub sup
syn keyword htmlTagName contained tt ul var
syn match htmlTagName contained "\<\(b\|i\|u\|h[1-6]\|em\|strong\)\>"

" legal arg names
syn keyword htmlArg contained lang title cite width type start align
syn match   htmlArg contained "\<\(http-equiv\|href\|title\)="me=e-1

" special characters
syn match htmlSpecialChar "&#\=[0-9A-Za-z]\{1,8};"

if !exists("html_no_rendering")
  " rendering
  syn cluster htmlTop contains=@Spell,htmlTag,htmlEndTag,htmlSpecialChar,htmlLink,htmlCodeTag

  syn region htmlBold start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic,e2Link
  syn region htmlBold start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlBoldUnderline,htmlBoldItalic,e2Link
  syn region htmlBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic,e2Link
  syn region htmlBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlBoldItalicUnderline,e2Link
  syn region htmlBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmlBoldItalicUnderline,e2Link
  syn region htmlBoldUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,e2Link
  syn region htmlBoldUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlBoldItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlBoldUnderlineItalic,e2Link

  syn region htmlUnderline start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlUnderlineBold,htmlUnderlineItalic,e2Link
  syn region htmlUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlUnderlineBoldItalic,e2Link
  syn region htmlUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlUnderlineBoldItalic,e2Link
  syn region htmlUnderlineItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmUnderlineItalicBold,e2Link
  syn region htmlUnderlineItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,htmUnderlineItalicBold,e2Link
  syn region htmlUnderlineItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,e2Link
  syn region htmlUnderlineItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,e2Link
  syn region htmlUnderlineBoldItalic contained start="<i\>" end="</i>"me=e-4 contains=@htmlTop,e2Link
  syn region htmlUnderlineBoldItalic contained start="<em\>" end="</em>"me=e-5 contains=@htmlTop,e2Link

  syn region htmlItalic start="<i\>" end="</i>"me=e-4 contains=@htmlTop,htmlItalicBold,htmlItalicUnderline,e2Link
  syn region htmlItalic start="<em\>" end="</em>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlItalicBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,htmlItalicBoldUnderline,e2Link
  syn region htmlItalicBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,htmlItalicBoldUnderline,e2Link
  syn region htmlItalicBoldUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,e2Link
  syn region htmlItalicUnderline contained start="<u\>" end="</u>"me=e-4 contains=@htmlTop,htmlItalicUnderlineBold,e2Link
  syn region htmlItalicUnderlineBold contained start="<b\>" end="</b>"me=e-4 contains=@htmlTop,e2Link
  syn region htmlItalicUnderlineBold contained start="<strong\>" end="</strong>"me=e-9 contains=@htmlTop,e2Link

  syn region htmlH1 start="<h1\>" end="</h1>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlH2 start="<h2\>" end="</h2>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlH3 start="<h3\>" end="</h3>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlH4 start="<h4\>" end="</h4>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlH5 start="<h5\>" end="</h5>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlH6 start="<h6\>" end="</h6>"me=e-5 contains=@htmlTop,e2Link
  syn region htmlCode start="<code\>" end="</code>"me=e-7 contains=htmlSpecialChar,htmlCodeTag,e2Link
  syn region htmlPre start="<pre\>" end="</pre>"me=e-6 contains=htmlSpecialChar,htmlCodeTag,e2Link
endif

if main_syntax == "html"
  " synchronizing (does not always work if a comment includes legal
  " html tags, but doing it right would mean to always start
  " at the first line, which is too slow)
  syn sync match htmlHighlight groupthere NONE "<[/a-zA-Z]"
  syn sync match htmlHighlightSkip "^.*['\"].*$"
  syn sync minlines=10
endif

" The default highlighting.
if version >= 508 || !exists("did_html_syn_inits")
  if version < 508
    let did_html_syn_inits = 1
  endif
  HtmlHiLink htmlTag                     Function
  HtmlHiLink htmlEndTag                  Identifier
  HtmlHiLink htmlArg                     Type
  HtmlHiLink htmlTagName                 htmlStatement
  HtmlHiLink htmlSpecialTagName          Exception
  HtmlHiLink htmlValue                   String
  HtmlHiLink htmlSpecialChar             Special
  HtmlHiLink e2Link                      PreProc
  HtmlHiLink e2LinkError                 Error

if !exists("html_no_rendering")
    HtmlHiLink htmlH1                      Title
    HtmlHiLink htmlH2                      htmlH1
    HtmlHiLink htmlH3                      htmlH2
    HtmlHiLink htmlH4                      htmlH3
    HtmlHiLink htmlH5                      htmlH4
    HtmlHiLink htmlH6                      htmlH5
    HtmlHiLink htmlTitle                   Title
    HtmlHiLink htmlBoldItalicUnderline     htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineBold           htmlBoldUnderline
    HtmlHiLink htmlUnderlineItalicBold     htmlBoldUnderlineItalic
    HtmlHiLink htmlUnderlineBoldItalic     htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicUnderline         htmlUnderlineItalic
    HtmlHiLink htmlItalicBold              htmlBoldItalic
    HtmlHiLink htmlItalicBoldUnderline     htmlBoldUnderlineItalic
    HtmlHiLink htmlItalicUnderlineBold     htmlBoldUnderlineItalic
    HtmlHiLink htmlLink			   Underlined
  if !exists("html_my_rendering")
    hi def htmlBold                term=bold cterm=bold gui=bold
    hi def htmlBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
    hi def htmlBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
    hi def htmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
    hi def htmlUnderline           term=underline cterm=underline gui=underline
    hi def htmlUnderlineItalic     term=italic,underline cterm=italic,underline gui=italic,underline
    hi def htmlItalic              term=italic cterm=italic gui=italic
  endif
endif

  HtmlHiLink htmlSpecial            Special
  HtmlHiLink htmlSpecialChar        Special
  HtmlHiLink htmlString             String
  HtmlHiLink htmlStatement          Statement
  HtmlHiLink htmlValue              String
  HtmlHiLink htmlCommentError       htmlError
  HtmlHiLink htmlTagError           htmlError
  HtmlHiLink htmlError              Error
  HtmlHiLink htmlCode               Comment
  HtmlHiLink htmlPre                Comment

  HtmlHiLink htmlCssDefinition      Special
endif

delcommand HtmlHiLink

let b:current_syntax = "html"

if main_syntax == 'html'
  unlet main_syntax
endif

" vim: ts=8
