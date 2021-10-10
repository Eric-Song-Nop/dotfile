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

if !exists('g:vscode')
"==========================="
"==========Plugins=========="
"==========================="
call plug#begin('~/.vim/plugged')
"==========================="
"======Color relative======="
"==========================="
Plug 'ryanoasis/vim-devicons'

" Plug 'flazz/vim-colorschemes'
" Plug 'morhetz/gruvbox'
" Plug 'whatyouhide/vim-gotham'
Plug 'ntk148v/vim-horizon'
Plug 'arcticicestudio/nord-vim'

Plug 'tpope/vim-surround'
" Plug 'rstacruz/vim-closer'
" Plug 'machakann/vim-sandwich'

Plug 'justinmk/vim-sneak'

Plug 'liuchengxu/vim-which-key'

Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}

Plug 'mhinz/vim-startify'

Plug 'Yggdroot/indentLine'

Plug 'easymotion/vim-easymotion'

Plug 'xuhdev/vim-latex-live-preview'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'voldikss/vim-floaterm'

Plug 'tyru/caw.vim' " So can use gci to comment a line
Plug 'gcmt/wildfire.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'mzlogin/vim-markdown-toc', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', {'for': 'markdown'}

Plug 'tpope/vim-fugitive'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-project.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'liuchengxu/vista.vim'

Plug 'glepnir/zephyr-nvim'
Plug 'sainnhe/gruvbox-material'

Plug 'tikhomirov/vim-glsl'
Plug 'Eric-Song-Nop/vim-glslx'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'kyazdani42/nvim-tree.lua'

" Install nvim-cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" Install snippet engine (This example installs [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip))
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" Install the buffer completion source
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'wakatime/vim-wakatime'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-emoji'
Plug 'f3fora/cmp-spell'
Plug 'ray-x/cmp-treesitter'

Plug 'jbyuki/nabla.nvim', { 'for': 'markdown' }
Plug 'folke/trouble.nvim'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
call plug#end()

else

call plug#begin('~/.vim/plugged')
  Plug 'easymotion/vim-easymotion'
call plug#end()

endif
" 打开文件自动定位到最后编辑的位置
"==========================="
"=======Not in VSCode======="
"==========================="
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

"==========================="
"======Color relative======="
"==========================="
" set guifont=
set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h11
set termguicolors
let $COLORTERM="truecolor"

if !exists('g:vscode')
colorscheme gruvbox-material
set background=dark
let g:gruvbox_material_background = 'hard'
"make background tranparent
" hi Normal guibg=NONE ctermbg=NONE

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

if(has("win32") || has("win64") || has("win95") || has("win16"))
  let g:floaterm_shell = 'powershell'
else
  let g:floaterm_shell = 'zsh'
endif
let g:floaterm_autoinsert = v:false

let g:vista_default_executive = 'nvim_lsp'
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

lua require('init')

if(has("win32") || has("win64") || has("win95") || has("win16"))
  source $HOME/AppData/Local/nvim/plugBinding.vim
else
  source $HOME/.config/nvim/plugBinding.vim
endif

else

if(has("win32") || has("win64") || has("win95") || has("win16"))
  source $HOME/AppData/Local/nvim/codePluginBinding.vim
else
  source $HOME/.config/nvim/codePluginBinding.vim
endif

endif
