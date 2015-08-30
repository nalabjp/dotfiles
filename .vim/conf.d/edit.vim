" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Tabキーを空白に変換
set expandtab

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデント
set smarttab

" y9で行末までヤンク
nmap y9 y$
" y0で行頭までヤンク
nmap y0 y^

" d9で行末まで切り取り
nmap d9 d$
" d0で行頭まで切り取り
nmap d0 d^

" カーソル前の文字削除
inoremap <silent> <C-h> <C-g>u<C-h>
" カーソル後の文字削除
inoremap <silent> <C-d> <Del>
" カーソルから行末まで削除
inoremap <silent> <C-d>$ <Esc>lc$
inoremap <silent> <C-d>9 <Esc>lc$
" カーソルから行頭までヤンク
inoremap <silent> <C-y>0 <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>$ <Esc>ly$<Insert>
inoremap <silent> <C-y>9 <Esc>ly$<Insert>

" 引用符, 括弧の設定
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap <> <><Left>
