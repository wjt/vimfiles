" Filetype file
" Move to ~/.vim/filetype.vim

" Don't load over other filetypes
if exists("did_load_filetypes")
    finish
endif

" Detect everything2 writeup files
augroup filetypedetect
    au! BufRead,BufNewFile *.e2     setfiletype e2
    au! BufRead,BufNewFile *.hsc    setfiletype haskell
augroup END
