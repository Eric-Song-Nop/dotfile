nnoremap <leader>tr :NvimTreeToggle<CR>
nnoremap <leader>tf :NvimTreeRefresh<CR>
" nnoremap <leader>tf :NvimTreeFindFile<CR>

"=== VIM-SPECTOR ==="
let g:vimspector_enable_mappings = 'HUMAN'

" leader d prefix for debug, except for leader doc

" BreakPoint
nmap <leader>dp <Plug>VimspectorToggleBreakpoint
" Start
nmap <leader>ds  <Plug>VimspectorContinue
nmap <leader>dr  <Plug>VimspectorRestart
nmap <leader>dp  <Plug>VimspectorPause
nmap <leader>dt  <Plug>VimspectorStop

nmap <leader>dd  <Plug>VimspectorStepOver
nmap <leader>di  <Plug>VimspectorStepInto
nmap <leader>du  <Plug>VimspectorStepOut

nmap <leader>df  <Plug>VimspectorAddFunctionBreakpoint

nnoremap <leader>dx :VimspectorReset<CR>

"=== VISTA ==="
nnoremap <leader>vi :Vista<CR>
nnoremap <leader>vf :Vista finder<CR>


"=== TABLE_MODE ==="
let g:table_mode_tableize_map='<leader>tablize'

" === TELESCOPE ==="
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"=== STARTIFY ==="
autocmd User Startified for key in ['i'] |
      \ execute 'nunmap <buffer>' key | endfor

"=== WHICH KEY ==="

" vim which key config
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>

"=== EASY MOTION ==="

let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>j <Plug>(easymotion-linebackward)
map <Leader><Leader>k <Plug>(easymotion-j)
map <Leader><Leader>i <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

"=== COC ==="

"== Translation =="
" popup
nmap <Leader>ct <Plug>(coc-translator-p)
vmap <Leader>ct <Plug>(coc-translator-pv)