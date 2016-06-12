if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Vim Plugin Manager
Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}

" 色見本
Plug 'cocopon/colorswatch.vim', { 'on': ['ColorSwatchGenerate'] }

" StatusLineの装飾
Plug 'itchyny/lightline.vim'
Plug 'nalabjp/lightline-solarized'

" theme
Plug 'chriskempson/base16-vim'

" endに%で移動
Plug 'ruby-matchit', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }

" コメントトグル
Plug 'tomtom/tcomment_vim'

" 移動先をハイライト
Plug 'Lokaltog/vim-easymotion'

" '' () を良しなにするのとif do def やらのブロック閉じる
Plug 'cohama/lexima.vim'

" 複数のテキストを同時編集
Plug 'terryma/vim-multiple-cursors'

" operator
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'

" text object
Plug 'kana/vim-textobj-user'
Plug 'osyo-manga/vim-textobj-multiblock'

" コピペ拡張
Plug 'LeafCage/yankround.vim'

" 文章整形
Plug 'junegunn/vim-easy-align'

" auto save
Plug 'vim-scripts/vim-auto-save'

" git
Plug 'tpope/vim-fugitive'
Plug 'kmnk/vim-unite-giti'

" ruby
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
Plug 'rhysd/vim-textobj-ruby', { 'for': ['ruby'] }
Plug 'rhysd/unite-ruby-require.vim'

" rails
Plug 'tpope/vim-rails', { 'for': ['ruby'] }

" slim
Plug 'slim-template/vim-slim', { 'for': ['slim'] }

" coffee script
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }

" codic
Plug 'koron/codic-vim', { 'on': ['Codic'] }

" markdown
Plug 'rcmdnk/vim-markdown', { 'for': ['markdown'] }
Plug 'tyru/open-browser.vim', { 'for': ['markdown'] }
Plug 'kannokanno/previm', { 'for': ['markdown'] }

" ctags
Plug 'szw/vim-tags'

" 非同期実行
Plug 'tpope/vim-dispatch', { 'on': ['Dispatch'] }
Plug 'thinca/vim-quickrun'
Plug 'Shougo/vimproc', { 'do': 'make' }

" ツリー型エクスプローラ
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }

" vimとtmuxをsmartに切り替え
Plug 'christoomey/vim-tmux-navigator'

" ag
Plug 'rking/ag.vim', { 'on': ['Ag'] }

" dash
Plug 'rizzatti/dash.vim', { 'on': ['Dash'] }

" ANSIカラーを反映
Plug 'vim-scripts/AnsiEsc.vim'

" 補完
Plug 'Shougo/neocomplete'

" auto cd to project root
Plug 'airblade/vim-rooter'

" unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ujihisa/unite-rake', { 'for': ['ruby'] }
Plug 'basyura/unite-rails', { 'for': ['ruby'] }
Plug 'rhysd/unite-codic.vim'

call plug#end()

""""""""""""""""""""""""""""""""""""
" Functions for vim-plug
""""""""""""""""""""""""""""""""""""
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

function! s:plug.check_installation()
  if empty(self.plugs)
    return
  endif

  let list = []
  for [name, spec] in items(self.plugs)
    if !isdirectory(spec.dir)
      call add(list, spec.uri)
    endif
  endfor

  if len(list) > 0
    let unplugged = map(list, 'substitute(v:val, "^.*github\.com/\\(.*/.*\\)\.git$", "\\1", "g")')

    " Ask whether installing plugs like NeoBundle
    echomsg 'Not installed plugs: ' . string(unplugged)
    if confirm('Install plugs now?', "yes\nNo", 2) == 1
      PlugInstall
      " Close window for vim-plug
      silent! close
      " Restart vim
      silent! !vim
      quit!
    endif

  endif
endfunction

" Check installation
augroup check-plug
  autocmd!
  autocmd VimEnter * if !argc() | call s:plug.check_installation() | endif
augroup END

""""""""""""""""""""""""""""""""""""
" Plugin's configurations
""""""""""""""""""""""""""""""""""""

if s:plug.is_installed('lightline.vim')
  let g:lightline = {
    \ 'colorscheme': 'lightline_solarized',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component': {
    \   'readonly': '%{&filetype=="help"?"":&readonly?"x":""}',
    \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }
endif


if s:plug.is_installed('base16-vim')
  set background=dark
  colorscheme base16-solarized
  highlight Search cterm=NONE ctermfg=gray ctermbg=darkgray
endif

if s:plug.is_installed('vim-easymotion')
  let g:EasyMotion_smartcase = 1
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
  " ホームポジションに近いキーを使う
  let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
  " 1 ストローク選択を優先する
  let g:EasyMotion_grouping=1
endif

if s:plug.is_installed('vim-markdown')
  let g:vim_markdown_folding_disabled=1
endif

if s:plug.is_installed('vim-quickrun')
  let g:quickrun_no_default_key_mappings = 1
endif

if s:plug.is_installed('vim-operator-surround')
  " 括弧を追加する
  map <silent> <Space>sa <Plug>(operator-surround-append)
  " 括弧を削除する
  map <silent> <Space>sd <Plug>(operator-surround-delete)
  " 括弧を入れ替える
  map <silent> <Space>sr <Plug>(operator-surround-replace)
  " カーソル位置から一番近い括弧を削除する
  nmap <silent> <Space>sdd <Plug>(operator-surround-delete)<Plug>(textobj-multiblock-a)
  " カーソル位置から一番近い括弧を変更する
  nmap <silent> <Space>srr <Plug>(operator-surround-replace)<Plug>(textobj-multiblock-a)
endif

if s:plug.is_installed('yankround')
  " yankround.vim {{{
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100
  nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
endif

if s:plug.is_installed('vim-easy-align')
  " vim-easy-align {{{
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif


if s:plug.is_installed('vim-auto-save')
  let g:auto_save = 1
  let g:auto_save_no_updatetime = 1
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_postsave_hook = 'TagsGenerate'
endif

if s:plug.is_installed('vim-unite-giti')
  nnoremap <silent> <Space>g :<C-u>Unite giti<CR>
  nnoremap <silent> <Space>gb :<C-u>Unite giti/branch<CR>
  nnoremap <silent> <Space>gc :<C-u>Unite giti/config<CR>
  nnoremap <silent> <Space>gg :<C-u>Unite giti/grep<CR>
  nnoremap <silent> <Space>gl :<C-u>Unite giti/log<CR>
  nnoremap <silent> <Space>gr :<C-u>Unite giti/remote<CR>
  nnoremap <silent> <Space>gs :<C-u>Unite giti/status<CR>
endif

if s:plug.is_installed('vim-ruby')
  let g:rubycomplete_rails = 1
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_include_object = 1
  let g:rubycomplete_include_object_space = 1
endif


if s:plug.is_installed('unite-ruby-require.vim')
  let g:unite_source_ruby_require_cmd = '\$HOME/.rbenv/shims/ruby'
endif

if s:plug.is_installed('vim-rails')
  let g:rails_some_option = 1
  let g:rails_level = 4
  let g:rails_syntax = 1
  let g:rails_statusline = 1
endif

if s:plug.is_installed('vim-tags')
  let g:vim_tags_ctags_binary = '/usr/local/bin/ctags'
  let g:vim_tags_use_vim_dispatch = 1
endif

if s:plug.is_installed('nerdtree')
  nnoremap <silent> <Space>nt :<C-u>NERDTreeToggle<CR>
endif

if s:plug.is_installed('unite.vim')
  let g:unite_enable_start_insert=1
  let g:unite_split_rule='botright'

  " バッファ一覧
  nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
  " ファイル一覧
  nnoremap <silent> <Space>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  " 最近使用したファイル一覧
  nnoremap <silent> <Space>um :<C-u>Unite file_mru<CR>
  " ジャンプリスト一覧
  nnoremap <silent> <Space>uj :<C-u>Unite jump<CR>
  " 常用セット
  nnoremap <silent> <Space>uu :<C-u>Unite buffer file_mru<CR>
  " 全部乗せ
  nnoremap <silent> <Space>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
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
endif

if s:plug.is_installed('neocomplete')
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Use camel case completion.
  let g:neocomplete#enable_camel_case = 1
  " buffer file name pattern that locks neocomplete. e.g. ku.vim or fuzzyfinder
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  let g:neocomplete#auto_completion_start_length = 4
  let g:neocomplete#manual_completion_start_length = 0
  let g:neocomplete#sources#syntax#min_keyword_length = 4
  let g:neocomplete#min_keyword_length = 4

  " <CR>: close popup and save indent.
  inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"


  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  if !exists('g:neocomplete#sources#omni_input_patterns')
    let g:neocomplete#sources#omni_input_patterns = {}
  endif
  let g:neocomplete#sources#omni_input_patterns.ruby = '[^. *\t]\.h\w*\|\h\w*::'
endif

if s:plug.is_installed('unite-rails')
  noremap <silent> <Space>rc  :<C-u>Unite rails/controller<CR>
  noremap <silent> <Space>rm  :<C-u>Unite rails/model<CR>
  noremap <silent> <Space>rv  :<C-u>Unite rails/view<CR>
  noremap <silent> <Space>rh  :<C-u>Unite rails/helper<CR>
  noremap <silent> <Space>ra  :<C-u>Unite rails/mailer<CR>
  noremap <silent> <Space>rl  :<C-u>Unite rails/lib<CR>
  noremap <silent> <Space>rs  :<C-u>Unite rails/stylesheet<CR>
  noremap <silent> <Space>rj  :<C-u>Unite rails/javascript<CR>
  noremap <silent> <Space>rr  :<C-u>Unite rails/route<CR>
  noremap <silent> <Space>rd  :<C-u>Unite rails/db<CR>
  noremap <silent> <Space>ro  :<C-u>Unite rails/config<CR>
  noremap <silent> <Space>rg  :<C-u>Unite rails/gemfile<CR>
  noremap <silent> <Space>rt  :<C-u>Unite rails/spec<CR>
endif

""""""""""""""""""""""""""""""""""""
" appearance
""""""""""""""""""""""""""""""""""""
" 行番号
set number

" 不可視文字
set list
set listchars=eol:↲,tab:>.,trail:-,extends:»,precedes:«

" 印字不可能文字
set display=uhex

" 常にタブを表示
set showtabline=2

" 常にステータスラインを表示
set laststatus=2

" カーソルの位置を表示
set ruler

" 括弧の対応をハイライト
set showmatch

" コマンド実行中は再描画しない
set lazyredraw

" 高速ターミナル接続を行う
set ttyfast

" 現在行の表示
set cursorline

""""""""""""""""""""""""""""""""""""
" basic
""""""""""""""""""""""""""""""""""""
" vi互換off↲
set nocompatible

" タイトル↲
set notitle

" 編集中に他のファイルを開く
set hidden

" 他の場所で編集された場合の自動読み込み
set autoread

" コマンドを表示↲
set showcmd

" モードを表示
set showmode

" 折り返し無し
set textwidth=0

" バックスペースで削除
set backspace=indent,eol,start

" カーソルを行頭、行末で止まらないように
set whichwrap=b,s,h,l,<,>,[,]

" OSのクリップボードを使用
set clipboard=unnamed,autoselect

" swapファイル
silent execute '!mkdir -p $HOME/.vimswap'
set swapfile
set directory=~/.vimswap

" backupファイル
silent execute '!mkdir -p $HOME/.vimbackup'
set backup
set backupdir=~/.vimbackup

""""""""""""""""""""""""""""""""""""
" color
""""""""""""""""""""""""""""""""""""
" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

""""""""""""""""""""""""""""""""""""
" edit
""""""""""""""""""""""""""""""""""""
" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>;set iminsert=0<CR>

" Tabキーを空白に変換
set expandtab

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデント
set smarttab

" 0と^を入れ替え
nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0

" y-で行末までヤンク
nmap y- y$
" y0で行頭までヤンク
nmap y0 y^

" d-で行末まで切り取り
nmap d- d$
" d0で行頭まで切り取り
nmap d0 d^

""""""""""""""""""""""""""""""""""""
" encoding
""""""""""""""""""""""""""""""""""""
" 改行文字
set ffs=unix,dos,mac

" デフォルトエンコーディング
set encoding=utf-8

" 指定文字コードで強制的にファイルを開く
command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932

""""""""""""""""""""""""""""""""""""
" filetype
""""""""""""""""""""""""""""""""""""
" coffeescript
au BufRead,BufNewFile,BufReadPre *.coffee* set filetype=coffee
" markdown
au BufRead,BufNewFile *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""
" indent
""""""""""""""""""""""""""""""""""""
" 自動インデント
set autoindent

" 新しい行のインデントを現在行と同じに
set smartindent

" Tabキーの設定
set tabstop=2 shiftwidth=2 softtabstop=0

" ファイルタイプ毎のインデント設定
autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
autocmd FileType sh         setlocal sw=4 sts=4 ts=4 et
autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType slim       setlocal sw=2 sts=2 ts=2 et
autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
autocmd FileType markdown   setlocal sw=4 sts=4 ts=4 et

""""""""""""""""""""""""""""""""""""
" misc
""""""""""""""""""""""""""""""""""""
" カーソル位置の単語をyank
nnoremap vy vawy

" バッファ選択時にリストを開く
nnoremap B :ls<CR>:b

" jj or kk でインサートモードを抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

" コロンとセミコロンの入れ替え
nnoremap : ;
nnoremap ; :
vnoremap : ;
vnoremap ; :

" ?を区切り文字として認識させない
autocmd FileType ruby setl iskeyword+=?

""""""""""""""""""""""""""""""""""""
" move
""""""""""""""""""""""""""""""""""""
" matchitを有効にする
runtime macros/matchit.vim

" 表示行単位で移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" 行頭、行末
nnoremap - $

" インサートモードでjkbfで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" バッファ移動
nnoremap <Space>bp :bp<CR>
nnoremap <Space>bn :bn<CR>
nnoremap <Space>bb :b#<CR>

" ジャンプ先が複数ある場合は候補一覧を表示
nnoremap <C-]> g<C-]>

" 画面端でスクロールする際の余裕
set scrolloff=5

""""""""""""""""""""""""""""""""""""
" search
""""""""""""""""""""""""""""""""""""
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
nmap <Esc><Esc> ;nohlsearch<CR><Esc>
