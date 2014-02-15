" unite.vim
NeoBundle 'Shougo/unite.vim'

" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" rails
NeoBundleLazy 'ujihisa/unite-rake', {
  \ 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'basyura/unite-rails', {
  \ 'depends' : 'Shjkougo/unite.vim' }
NeoBundleLazy 'taichouchou2/unite-rails_best_practices', {
  \ 'depends' : 'Shougo/unite.vim',
  \ 'build' : {
  \    'mac': 'gem install rails_best_practices',
  \    'unix': 'gem install rails_best_practices',
  \   }
  \ }
NeoBundleLazy 'taichouchou2/unite-reek', {
  \ 'build' : {
  \    'mac': 'gem install reek',
  \    'unix': 'gem install reek',
  \ },
  \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] },
  \ 'depends' : 'Shougo/unite.vim' }