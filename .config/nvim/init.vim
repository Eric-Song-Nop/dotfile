"==========================="
"=======Basic setting======="
"==========================="
set norelativenumber
set relativenumber
set clipboard=unnamedplus
set cursorline
set wrap
set showcmd
set wildmenu
let &t_ut=''
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
filetype indent on       " 自适应不同语言的智能缩进
set smarttab             " 在行和段开始处使用制表符
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存
set confirm             " 在处理未保存或只读文件的时候，弹出确认
set mouse=a
let netrw_i='T'

set viminfo='1000
set pastetoggle=<F2>
set nu
set hls
set ignorecase
set smartcase


filetype on
filetype indent on
set autoindent
filetype plugin on
filetype plugin indent on
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

if(has("win32") || has("win64") || has("win95") || has("win16"))
source $HOME/AppData/Local/nvim/normalBinding.vim
else
  source $HOME/.config/nvim/normalBinding.vim
endif

"==========================="
"==========Plugins=========="
"==========================="
call plug#begin('~/.vim/plugged')
"==========================="
"======Color relative======="
"==========================="
Plug 'ryanoasis/vim-devicons'

" Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
" Plug 'whatyouhide/vim-gotham'
Plug 'Eric-Song-Nop/vim-gotham'
Plug 'ntk148v/vim-horizon'
Plug 'arcticicestudio/nord-vim'
"==========================="
"============COC============"
"==========================="
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-surround'
" Plug 'rstacruz/vim-closer'
" Plug 'machakann/vim-sandwich'

Plug 'justinmk/vim-sneak'

Plug 'liuchengxu/vim-which-key'

" Plug 'hardcoreplayers/spaceline.vim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

Plug 'mhinz/vim-startify'

Plug 'Yggdroot/indentLine'

Plug 'easymotion/vim-easymotion'

" Plug 'airblade/vim-gitgutter'
 
" Plug 'kevinhwang91/rnvimr'

Plug 'xuhdev/vim-latex-live-preview'

" if has('nvim')
"   Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/denite.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/lib.kom' -- removed! You can remove it from your vimrc
Plug 'romgrk/barbar.nvim'
" Plug 'bagrat/vim-buffet'

" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'voldikss/vim-floaterm'

Plug 'tyru/caw.vim' " So can use gci to comment a line
Plug 'gcmt/wildfire.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Plug 'rafcamlet/coc-nvim-lua'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'mzlogin/vim-markdown-toc'
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}

Plug 'tpope/vim-fugitive'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'liuchengxu/vista.vim'

Plug 'glepnir/zephyr-nvim'

Plug 'tikhomirov/vim-glsl'

Plug 'OmniSharp/omnisharp-vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'kyazdani42/nvim-tree.lua'

Plug 'puremourning/vimspector'
call plug#end()

" 打开文件自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

"==========================="
"======Color relative======="
"==========================="
set termguicolors
let $COLORTERM="truecolor"

"==========================="
"=======Not in VSCode======="
"==========================="
if !exists('g:vscode')
" colorscheme zephyr
" colorscheme gruvbox
" colorscheme horizon
" colorscheme gotham
colorscheme nord
set background=dark
"make background tranparent
" hi Normal guibg=NONE ctermbg=NONE

"==========================="
"========COC relative======="
"==========================="

" CocPulggins
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-texlab',
            \ 'coc-clangd',
            \ 'coc-vimlsp', 
            \ 'coc-python',
            \ 'coc-actions',
            \ 'coc-sh',
            \ 'coc-xml',
            \ 'coc-yank',
            \ 'coc-emoji',
            \ 'coc-translator',
            \ 'coc-git',
            \ 'coc-snippets',
            \ 'coc-marketplace',
            \ 'coc-cmake',
            \ 'coc-pairs',
            \ 'coc-leetcode',
            \ 'coc-lists',
            \ 'coc-floaterm'
            \]

" TextEdit might fail if hidden is not set.
set hidden
set updatetime=100
set shortmess+=c
set signcolumn=yes

" indent config
let g:indentLine_color_term = 239
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let g:sneak#label = 1

" latex
let g:livepreview_engine = 'pdflatex'
let g:indentLine_conceallevel = 0

"  Define mappings for denite
"let g:webdevicons_enable_denite = 0
"autocmd FileType denite call s:denite_my_settings()
"function! s:denite_my_settings() abort
"  nnoremap <silent><buffer><expr> <CR>
"  \ denite#do_map('do_action')
"  nnoremap <silent><buffer><expr> d
"  \ denite#do_map('do_action', 'delete')
"  nnoremap <silent><buffer><expr> p
"  \ denite#do_map('do_action', 'preview')
"  nnoremap <silent><buffer><expr> q
"  \ denite#do_map('quit')
"  nnoremap <silent><buffer><expr> i
"  \ denite#do_map('open_filter_buffer')
"  nnoremap <silent><buffer><expr> <Space>
"  \ denite#do_map('toggle_select').'j'
"endfunction
"nmap <C-P> :Denite buffer -split=floating -winrow=1<CR>
"nmap <C-p> :Denite file/rec -split=floating -winrow=1<CR>
"if exists("g:loaded_webdevicons")
"  call webdevicons#refresh()
"endif

if(has("win32") || has("win64") || has("win95") || has("win16"))
  let g:floaterm_shell = 'powershell'
else
  let g:floaterm_shell = 'zsh'
endif
let g:floaterm_autoinsert = v:false

let g:vista_default_executive = 'coc'

let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1

"=== FZF-PREVIEW-SETTING===
let g:fzf_preview_dev_icons_limit = 5000
let g:fzf_preview_lines_command = 'bat --color=always --plain --number --theme=gruvbox'
let g:fzf_preview_command = 'bat --color=always --plain {-1} --theme=gruvbox'

lua require('init')

if(has("win32") || has("win64") || has("win95") || has("win16"))
source $HOME/AppData/Local/nvim/plugBinding.vim
else
  source $HOME/.config/nvim/plugBinding.vim
endif
set runtimepath^=/home/ericoolen/dev/GLSL
endif
