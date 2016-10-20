if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
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


if dein#check_install( ['vimproc'] )
  call dein#install( ['vimproc'] )
endif
if dein#check_install()
  call dein#install()
endif

set laststatus=2
set t_Co=256
set number
set cursorline
hi clear CursorLine
set clipboard&
set clipboard^=unnamedplus
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
colorscheme hybrid
" colorscheme molokai
set background=dark 
filetype plugin on
filetype indent on
syntax on
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
let g:tex_conceal=''
let g:deoplete#enable_at_startup = 1
let mapleader = "\<Space>"
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
nnoremap <silent>[unite]c :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent>[unite]b :<C-u>Unite buffer<CR>

nnoremap <silent><Leader>n :NERDTreeToggle<CR>
