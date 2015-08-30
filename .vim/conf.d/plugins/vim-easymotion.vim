" 移動先をハイライト
NeoBundle 'Lokaltog/vim-easymotion'

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
map ;j <Plug>(easymotion-j)
map ;k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「;」 + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
