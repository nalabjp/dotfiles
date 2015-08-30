NeoBundle 'nathanaelkane/vim-indent-guides'

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1
