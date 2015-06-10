" Vundle setup. Don't change.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" let mapleader=","

"
" =========
" * Prose *
" =========
"
" http://contsys.tumblr.com/post/491802835/vim-soft-word-wrap
"
" Wrap prose the way I want it.
noremap <leader>w vasgq

function Prose ()
  set formatoptions=1
  set linebreak
  set wrap
  set nolist
  set display=lastline
  " set breakat="\ |@-+;:,./?^I"
  nnoremap j gj
  nnoremap k gk
  vnoremap j gj
  vnoremap k gk
endfunction

" error message when over 80
function! RemoveWidthLimitWarnigns()
    silent! call matchdelete(4)
endfunction
function! InsertWidthLimitWarnings()
    call RemoveWidthLimitWarnigns()
    call matchadd("ErrorMsg", "\\%>79v.\\+", 10, 4)
endfunction

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

au BufRead,BufNewFile *.tex set wrap textwidth=78
au BufRead,BufNewFile *.tex set noai
au BufRead,BufNewFile *.tex call Prose()

" Packages.
" Bundle 'davidhalter/jedi-vim'
" Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'

" End vundle setup.
filetype plugin indent on

" enable 256 colors in GNOME terminal (for my Ubuntu VM)
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" set your color scheme (replace wombat with whatever yours is called)
" if you're using a gvim or macvim, then your color scheme may have a version
" that uses more than 256 colors
if has("gui_running")
    colorscheme solarize
endif

" turn on language specific syntax highlighting
syntax on

set number
set numberwidth=3
highlight LineNr ctermbg=darkgrey

" Clean up whitespace at the ends of lines before writing
autocmd BufWritePre * :%s/\s\+$//e

map :. :w
map :, :q
map :., :wq
map ] $
map [ 0
inoremap zx <esc>
inoremap jk <esc>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Train my muscles to forget arrow keys!
noremap <Left>  <nop>
noremap <Right> <nop>
noremap <Up>    <nop>
noremap <Down>  <nop>

vmap <leader>c ! pbcopy<CR>u
nmap <leader>v :set paste<CR>! pbpaste<CR>:set nopaste<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> cv :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

"Menu items for Commenting and Un-Commenting code
amenu 20.435 &Edit.-SEP4- :
amenu Edit.Comment <Esc>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call Comment(fl, ll)<CR>
amenu Edit.UnComment <Esc>`<:let fl=line(".")<CR>`>:let ll=line(".")<CR>:call UnComment(fl, ll)<CR>

"Function for commenting a block of Visually selected text
function Comment(fl, ll)
  let i=a:fl
  let comment="//"
  while i<=a:ll
    let cl=getline(i)
    let cl2=comment.cl
    call setline(i, cl2)
    let i=i+1
  endwhile
endfunction

"Function for Un-Commenting a block of Visually selected text
function UnComment(fl, ll)
  let i=a:fl
  let comment="//"
  while i<=a:ll
    let cl=getline(i)
    let cl2=substitute(cl, "//", "", "")
    call setline(i, cl2)
    let i=i+1
  endwhile
endfunction

