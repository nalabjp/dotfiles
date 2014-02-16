" 画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" 行頭、行末
nmap 1 0
nmap 0 ^
nmap 9 $

" インサートモードでhjklで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %