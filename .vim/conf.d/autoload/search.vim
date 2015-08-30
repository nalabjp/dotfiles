" 最後まで検索したら先頭へ
set wrapscan

" インクリメンタルサーチ
set incsearch

" 大文字小文字を無視
set ignorecase

" 検索文字列に大文字が含まれている場合は区別する
set smartcase

" 検索文字列をハイライト
set hlsearch

" Escの2回押しでハイライトを消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>
