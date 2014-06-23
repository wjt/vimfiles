" VIM extension for the Oberon programming language
" Daniel Hottinger <hodaniel@student.ethz.ch>
" Licence: GNU GPL
"
" Move this file to ~/.vim/ftplugin/
"
" $Id: oberon.vim,v 1.3 2002/08/20 14:29:01 hotti Exp $

setlocal cinw=FOR,WHILE,REPEAT,BEGIN,CASE,DO,ELSE,ELSIF,TYPE,CONST,VAR,IMPORT,IF,WITH,RECORD,LOOP
" setlocal number
" setlocal keywordprg=man

" use quickfix mode of vim
setlocal makeprg=omake.pl\ %
setlocal errorformat=%f>%l:%c:%t:%n:%m"
setlocal autowrite

" smartindent (on/off)
setlocal smartindent
map <buffer> ;s1 :setlocal si<cr>
map <buffer> ;s0 :setlocal nosi<cr>

" oberon comments
setlocal comments=sr:(*,mb:*,el:*)
map <buffer> ,c mz^i(* <ESC>$a *)<ESC>`z
map <buffer> ,C mz^3x$XXx`z
"vmap <buffer> ,c <ESC>`<i(* <ESC>`>a *)<ESC>
"vmap <buffer> ,C <ESC>`<3x`>h3x
vmap <buffer> ,c :s/^/(* /g<cr>:'<,'>s/$/ *)/g<cr>
vmap <buffer> ,C :s/^[(]\* //g<cr>:'<,'>s/ \*[)]$//g<cr>

" oberon titles
map <buffer> ,t :s/^[ \t]*//<CR>O <C-U>(<ESC>40a*<ESC>jI * <ESC>o<C-U> <ESC>40a*<ESC>A)<ESC>k0WW
vmap <buffer> ,t <ESC>:'<,'>s/^/ * /<CR>'<O<C-U>(<ESC>40a*<ESC>'>o<C-U> <ESC>40a*<ESC>A)<ESC>'<j0WW

" ;sr -> to remap 'return'
map <buffer> ;sr :iunmap <buffer> <c-v><cr><cr>

"(*
" * c-style comments
" *)
"map <buffer> ;xC :imap <buffer> *) <c-v><esc>;sr:iunmap <buffer> *)<c-v><cr>o *)<c-v><cr><c-v><esc>:setlocal ai<c-v><cr>;s1A<cr>
"map <buffer> ;xc :setlocal noai<cr>;xC:imap <buffer> <c-v><cr> <c-v><cr> * <cr>
"map! (* (* <esc>;s0;xca

" ======================================================================
" Special keywords (loops, nested blocks, ...)
" ======================================================================

" -while-
map <buffer> ;whr :imap <buffer> <c-v><cr> <c-v><esc>;sro<cr>
iab <buffer> while WHILE DO<esc>;s0oEND;<esc>;whr;s1k^ea

" -repeat-
map <buffer> ;rpr :imap <buffer> <c-v><cr> ;<c-v><esc>;srko<cr>
iab <buffer> repeat REPEAT<esc>;s0oUNTIL<esc>;s1;rprbea

" -if-
iab <buffer> if IF THEN<esc>;s0oEND;<esc>;s1;whr;se;sik^ea
map <buffer> ;si :iab <buffer> elsif ELSIF THEN<c-v><esc>;whr<<ea<cr>
map <buffer> ;se :iab <buffer> else ELSE<c-v><esc>;ue<<A<cr>
map <buffer> ;ue :iab <buffer> else Z<cr>:iunab <buffer> else<cr>:iab <buffer> elsif Z<cr>:iunab <buffer> elsif<cr>

" -for-
iab <buffer> for FOR DO<esc>;s0oEND;<esc>;s1;whrk^ea

" -with-
iab <buffer> with WITH DO<esc>;s0oEND;<esc>;s1;whrk^ea

" -case-
iab <buffer> case CASE OF<esc>;s0oEND;<esc>;s1;whr;sek^ea

" -record-
iab <buffer> record RECORD<esc>;s0oEND;<esc>;s1;whrkA

" -procedure-
iab <buffer> proc PROCEDURE<esc>;spra
map <buffer> ;spr :imap <buffer> <c-v><cr> ;<c-v><esc>;s0;sr^wyeoBEGIN<c-v><cr>END ;<c-v><esc>P;s1ko<cr>

" -module-
iab <buffer> module MODULE<esc>:0r! tmpl oberon<cr>/MODULE<cr>;smrA
map <buffer> ;smr :imap <buffer> <c-v><cr> ;<c-v><esc>;s0;sr^wywoEND .<c-v><esc>P;s1O<cr>

" -from-
"iab <buffer> from FROM IMPORT<esc>;sfr^eli
"imap <buffer> ;sfr :imap! <c-v><c-v><cr> <c-v><c-v><esc>a<c-v><c-v><esc>;sr^A <esc>

" -loop-
iab <buffer> loop LOOP<esc>:setlocal nosi<cr>A<cr>END;<esc>:setlocal si<cr>kA

" -begin-
iab <buffer> begin BEGIN<esc>:setlocal nosi<cr>A<cr>END;<esc>:setlocal si<cr>kA

" ======================================================================
" Other keywords
" ======================================================================
iab <buffer> abs ABS
iab <buffer> array ARRAY
iab <buffer> ash ASH
iab <buffer> boolean BOOLEAN
iab <buffer> by BY
iab <buffer> cap CAP
iab <buffer> char CHAR
iab <buffer> chr CHR
iab <buffer> const CONST
iab <buffer> copy COPY
iab <buffer> dec DEC
iab <buffer> div DIV
iab <buffer> do DO
iab <buffer> downto DOWNTO
iab <buffer> else ELSE
iab <buffer> elsif ELSIF
iab <buffer> end END
iab <buffer> entier ENTIER
iab <buffer> excl EXCL
iab <buffer> exit EXIT
iab <buffer> false FALSE
iab <buffer> goto GOTO
iab <buffer> halt HALT
iab <buffer> import IMPORT
iab <buffer> in IN
iab <buffer> inc INC
iab <buffer> incl INCL
iab <buffer> integer INTEGER
iab <buffer> is IS
iab <buffer> label LABEL
iab <buffer> len LEN
iab <buffer> long LONG
iab <buffer> longint LONGINT
iab <buffer> max MAX
iab <buffer> min MIN
iab <buffer> mod MOD
iab <buffer> new NEW
iab <buffer> nil NIL
iab <buffer> odd ODD
iab <buffer> of OF
iab <buffer> or OR
iab <buffer> ord ORD
iab <buffer> pointer POINTER
iab <buffer> procedure PROCEDURE
iab <buffer> real REAL
iab <buffer> return RETURN
iab <buffer> setlocal SET
iab <buffer> short SHORT
iab <buffer> shortint SHORTINT
iab <buffer> size SIZE
iab <buffer> string ARRAY OF CHAR
iab <buffer> then THEN
iab <buffer> to TO
iab <buffer> true TRUE
iab <buffer> type TYPE
iab <buffer> until UNTIL
iab <buffer> var VAR
iab <buffer> xor XOR

