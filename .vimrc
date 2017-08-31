set encoding=utf-8
scriptencoding utf-8
if &compatible
  set nocompatible
endif

let mapleader = "\<Space>"

if exists('g:nyaovim_version')
  let s:dein_dir = expand('~/.cache/nyaovim/dein')
elseif has('nvim')
  let s:dein_dir = expand('~/.cache/neovim/dein')
else
  let s:dein_dir = expand('~/.cache/vim/dein')
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state( s:dein_dir )
  call dein#begin( s:dein_dir )
  let s:toml = '~/.dein.toml'
  let s:toml_lazy = '~/.dein_lazy.toml'
  call dein#load_toml( s:toml, { 'lazy' : 0 })
  call dein#load_toml( s:toml_lazy, { 'lazy' : 1})
  call dein#end()
  call dein#save_state()
endif


if dein#check_install()
  call dein#install()
endif

set laststatus=2
set t_Co=256
set number
set cursorline
hi clear CursorLine
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set conceallevel=0
let g:tex_conceal=''
set mouse=nvc
set backspace=indent,eol,start
set wildmode=list,full
set background=dark 
highlight turn gui=standout cterm=standout
call matchadd("turn", ".\%>81v")
" colorscheme hybrid_material
" colorscheme molokai
" colorscheme iceberg
colorscheme gruvbox
if executable('rg')
  set grepprg=rg\ --follow\ --vimgrep
endif
filetype plugin on
filetype indent on
syntax on
set showbreak=>
set breakindent
set breakindentopt=
if has('nvim')
  set termguicolors
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
else
  let &t_SI = "\033[6 q"
  let &t_EI = "\033[2 q"
endif

" augroup indent_styles
"   autocmd!
"   autocmd Filetype c setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1 
"   autocmd Filetype c setlocal fo-=ro fo+=cql cindent 
"   autocmd Filetype cpp setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1 
"   autocmd Filetype cpp setlocal fo-=ro fo+=cql cindent 
" augroup END

inoremap jj <ESC>

nnoremap [caw] <Nop>
vnoremap [caw] <Nop>
nmap <Leader>c [caw]
vmap <Leader>c [caw]
nmap <silent>[caw] <Plug>(caw:hatpos:toggle)
vmap <silent>[caw] <Plug>(caw:hatpos:toggle)

nnoremap [denite] <Nop>
nmap <Leader>d [denite]
nmap <silent>[denite]p :<C-u>Denite file_rec file_mru<CR>
nmap <silent>[denite]f :<C-u>DeniteProjectDir file_rec<CR>
nmap <silent>[denite]m :<C-u>Denite file_mru<CR>
nmap <silent>[denite]b :<C-u>Denite buffer<CR>
nmap <silent>[denite]g :<C-u>Denite grep<CR>
nmap <silent>[denite]c :<C-u>Denite grep:::`expand('<cword>')`<CR>
nmap <silent>[denite]r :<C-u>Denite -resume<CR>

nnoremap [thumbnail] <Nop>
nmap <Leader>b :<C-u>Thumbnail<CR>

if has('nvim')
  nnoremap [neoterm] <Nop>
  nmap <Leader>t [neoterm]
  tnoremap <silent> <ESC> <C-\><C-n>
  nnoremap <silent>[neoterm]  :<C-u>Ttoggle<CR>
endif
