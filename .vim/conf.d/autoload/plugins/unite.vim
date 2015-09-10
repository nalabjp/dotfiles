" unite.vim
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

let g:unite_enable_start_insert=1

" バッファ一覧
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 最近使用したファイル一覧
nnoremap <silent> <Leader>um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> <Leader>uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> <Leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

let g:unite_source_grep_max_candidates = 200

if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_recursive_opt = 'HRn'
  let g:unite_source_grep_default_opts =
  \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
endif

" rails
NeoBundleLazy 'ujihisa/unite-rake', {
  \ 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'basyura/unite-rails', {
  \ 'depends' : 'Shougo/unite.vim' }

noremap <silent> <Leader>urc  :<C-u>Unite rails/controller<CR>
noremap <silent> <Leader>urm  :<C-u>Unite rails/model<CR>
noremap <silent> <Leader>urv  :<C-u>Unite rails/view<CR>
noremap <silent> <Leader>urh  :<C-u>Unite rails/helper<CR>
noremap <silent> <Leader>urma :<C-u>Unite rails/mailer<CR>
noremap <silent> <Leader>url  :<C-u>Unite rails/lib<CR>
noremap <silent> <Leader>urs  :<C-u>Unite rails/stylesheet<CR>
noremap <silent> <Leader>urj  :<C-u>Unite rails/javascript<CR>
noremap <silent> <Leader>urr  :<C-u>Unite rails/route<CR>
noremap <silent> <Leader>urd  :<C-u>Unite rails/db<CR>
noremap <silent> <Leader>urco :<C-u>Unite rails/config<CR>
noremap <silent> <Leader>urg  :<C-u>Unite rails/gemfile<CR>
noremap <silent> <Leader>urt  :<C-u>Unite rails/spec<CR>
