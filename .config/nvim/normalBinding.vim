let mapleader=" "
nnoremap <LEADER><CR> :noh<CR>

noremap j h
noremap k j
noremap i k
noremap h i
noremap H I
noremap I H
nnoremap S :w<CR>
nnoremap Q :q<CR>

cmap w!! w !sudo tee %

nnoremap <LEADER>o o<ESC>
nnoremap <LEADER>O O<ESC>

"==========================="
"=========Teminal==========="
"==========================="

tnoremap <esc><esc> <c-\><c-n>

if(has("win32") || has("win64") || has("win95") || has("win16"))
  nnoremap <leader>vt :vs term://powershell<CR>
  nnoremap <leader>st :split term://powershell<CR>
  nnoremap <leader>tt :tabe term://powershell<CR>
else
  nnoremap <leader>vt :vs term://$SHELL<CR>
  nnoremap <leader>st :split term://$SHELL<CR>
  nnoremap <leader>tt :tabe term://$SHELL<CR>
endif


map <leader>j <C-w>h
map <leader>k <C-w>j
map <leader>l <C-w>l
map <leader>i <C-w>k

map <leader>J <C-w>H
map <leader>K <C-w>J
map <leader>L <C-w>L
map <leader>I <C-w>K

"==========================="
"========Tab relative======="
"==========================="

nnoremap <leader>1 :BufferGoto 1<CR>
nnoremap <leader>2 :BufferGoto 2<CR>
nnoremap <leader>3 :BufferGoto 3<CR>
nnoremap <leader>4 :BufferGoto 4<CR>
nnoremap <leader>5 :BufferGoto 5<CR>
nnoremap <leader>6 :BufferGoto 6<CR>
nnoremap <leader>7 :BufferGoto 7<CR>
nnoremap <leader>8 :BufferGoto 8<CR>
nnoremap <leader>9 :BufferGoto 9<CR>
nnoremap <leader>0 :BufferLast<CR>
nnoremap <leader>w :BufferClose<CR>





nnoremap <leader><up> :res +3<CR>
nnoremap <leader><down> :res -3<CR>
nnoremap <leader><left> :vertical res -3<CR>
nnoremap <leader><right> :vertical res +3<CR>
