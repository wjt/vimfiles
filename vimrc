" debian.vim
" Debian system-wide default configuration Vim

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

" Now we set some defaults for the editor
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" modelines have historically been a source of security/resource
" vulnerabilities -- disable by default, even when 'nocompatible' is set
set nomodeline

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Some Debian-specific things
if has("autocmd")
  " set mail filetype for reportbug's temp files
  augroup debian
    au BufRead reportbug-*		set ft=mail
  augroup END
endif

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" Vundle: hub clone VundleVim/Vundle.vim $VIM/bundle/Vundle.vim
filetype off
if has("win32")
  set rtp+=~/vimfiles/bundle/Vundle.vim
  :let $PATH = $PATH . ';C:/MinGW/msys/1.0/bin'
else
  set rtp+=~/.vim/bundle/Vundle.vim
end
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" :sort i
Plugin 'altercation/vim-colors-solarized'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'honza/vim-snippets'
Plugin 'igankevich/mesonic'
Plugin 'isRuslan/vim-es6'
Plugin 'jamessan/vim-gnupg'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nvie/vim-flake8'
Plugin 'SirVer/ultisnips'
Plugin 'sophacles/vim-bundle-mako'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/a.vim'

call vundle#end()
filetype plugin indent on

set ignorecase
set smartcase
set autoindent
" set smartindent
set shiftwidth=2
set softtabstop=2
set expandtab
set preserveindent
set showmode
set showmatch
set showcmd
set modeline
set hidden
set autoread

syntax enable
set showmatch
set incsearch
set hlsearch

map! ^O {^M}^[O^T

nmap <C-Tab> :A<CR>

set wildmenu
set wildignore=*.o
set wildmode=list:longest

set tags=tags;/

set grepprg=grep\ -nH\ $*

:nnoremap Q gq

set foldenable
set foldlevel=100
set foldopen-=search
set foldopen-=undo
set foldmethod=syntax

" KEY MAPPINGS

map <F0> :set textwidth=80<CR>
set pastetoggle=<F9>
map <F7> :make<CR>
"set background=light

set spelllang=en_gb

" without this, my beautiful lcs is sad
set encoding=utf-8

set lcs=tab:↦\ ,trail:·,nbsp:˽,extends:↷,precedes:↶
set list

au Bufenter *.hs compiler ghc
au BufRead,BufNewFile *.hsc setfiletype haskell
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

" sigh
au BufRead,BufNewFile *.mak     set filetype=mako

set completeopt=menu,menuone,longest

function! DevHelpCurrentWord()
        let word = expand("<cword>")
        exe "!devhelp -s " . word . " 2>/dev/null &"
endfunction

let g:git_diff_spawn_mode = 1
let g:alternateRelativeFiles = 1

set encoding=utf-8
set showtabline=2

let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+,.pyc$'

packadd! matchit

if !has('gui_running')
  let g:solarized_termcolors=256
end
:colorscheme solarized

augroup markdown
    au!
    au! BufNewFile,BufRead *.md,*.markdown,*.mkd,*.mdwn setlocal filetype=ghmarkdown
augroup END

augroup scala
    au!
    au! BufNewFile,BufRead *.scala setlocal filetype=scala
augroup END

augroup coffee
    au!
    au! BufNewFile,BufRead *.coffee setlocal filetype=coffee
augroup END

autocmd BufWritePost *.py call Flake8()

au BufNewFile,BufRead *.jsonc        setf javascript
au BufNewFile,BufRead *.es6          setf javascript

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:GPGExecutable="gpg2"

if filereadable('/.flatpak-info')
  let g:meson_command = 'flatpak-spawn --host meson'
  let g:meson_ninja_command = 'flatpak-spawn --host ninja'
  " Doesn't work because vim-flake8 uses executable() to check whether this is
  " a path to an executable binary (it's not) rather than just trying to run
  " it.
  " let g:flake8_cmd = 'flatpak-spawn --host flake8'
  if executable('/home/wjt/.local/bin/flake8')
    let g:flake8_cmd = '/home/wjt/.local/bin/flake8'
  endif
  let g:fugitive_git_executable = 'flatpak-spawn --host git'
  set makeprg=flatpak-spawn\ --host\ make\ -C\ build
endif
