call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'Yggdroot/indentLine'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
call plug#end()

let g:vimtex_view_method = 'zathura'  
let g:vimtex_quickfix_mode = 0
let g:vimtex_compiler_method = 'latexrun'
let g:livepreview_previewer = 'okular'
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <Tab> for trigger completion and navigate
" Use :CocConfig to configure more options later
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Accept completion with Enter
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Coc Extensions for LaTeX (install via :CocInstall)
let g:coc_global_extensions = ['coc-snippets', 'coc-pyright', 'coc-texlab']
let g:coc_disable_startup_warning = 1

" Enable syntax highlighting
syntax enable
filetype plugin indent on

" VimTeX specific keybindings
nmap <leader>ll :VimtexCompile<CR>
nmap <leader>lv :VimtexView<CR>
nmap <leader>lk :VimtexStop<CR>

" Enable line numbering
set number
