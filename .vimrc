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

" StatusLineの装飾
Plug 'itchyny/lightline.vim'
Plug 'taohex/lightline-solarized' | Plug 'tpope/vim-fugitive'

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

" 文章整形
Plug 'junegunn/vim-easy-align'

" git
Plug 'jreybert/vimagit'
Plug 'cohama/agit.vim'

" ruby
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'eruby', 'haml', 'slim'] }
Plug 'rhysd/vim-textobj-ruby', { 'for': ['ruby'] }

" rails
Plug 'tpope/vim-rails', { 'for': ['ruby'] }

" slim
Plug 'slim-template/vim-slim', { 'for': ['slim'] }

" coffee script
Plug 'kchmck/vim-coffee-script', { 'for': ['coffee'] }

" golang
Plug 'fatih/vim-go'

" markdown
Plug 'rcmdnk/vim-markdown', { 'for': ['markdown'] }
Plug 'tyru/open-browser.vim', { 'for': ['markdown'] }
Plug 'kannokanno/previm', { 'for': ['markdown'] }

" 非同期実行
Plug 'Shougo/vimproc', { 'do': 'make' }

" ツリー型エクスプローラ
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle'] }

" dash
Plug 'rizzatti/dash.vim', { 'on': ['Dash'] }

" ANSIカラーを反映
Plug 'vim-scripts/AnsiEsc.vim'

" 補完
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby'

" auto cd to project root
Plug 'airblade/vim-rooter'

" バッファをタブで開く
Plug 'vim-scripts/buftabs'

" Ctrl-P
Plug 'ctrlpvim/ctrlp.vim'

" Calc
Plug 'gregsexton/VimCalc'

" for ctags
Plug 'majutsushi/tagbar', { 'for': ['ruby', 'go'] }

" neoterm
Plug 'kassio/neoterm'

" vimtest
Plug 'janko-m/vim-test'
Plug 'benmills/vimux'

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
" Functions for others
""""""""""""""""""""""""""""""""""""
" Generate ctags
function! Gentags()
  silent! execute '!ctaggen'
  redraw!
endfunction

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
  colorscheme base16-solarized-dark
  hi Search cterm=NONE ctermbg=darkgreen ctermfg=white
  hi LineNr ctermbg=NONE ctermfg=darkgray
  hi CursorLine cterm=underline ctermbg=NONE ctermfg=NONE
  hi CursorLineNr ctermbg=NONE ctermfg=yellow
  hi Pmenu ctermbg=NONE
  hi PmenuSel ctermbg=blue
  hi PmenuSbar ctermbg=green
  hi PmenuThumb ctermfg=yellow
  hi Visual ctermbg=cyan ctermfg=white
  hi WildMenu cterm=BOLD ctermbg=darkgreen ctermfg=white
  hi StatusLine ctermbg=darkgray ctermfg=white
  hi Todo cterm=BOLD ctermbg=yellow ctermfg=black
  hi VertSplit ctermbg=NONE ctermfg=darkgray
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

if s:plug.is_installed('vim-easy-align')
  " vim-easy-align {{{
  vmap <Enter> <Plug>(EasyAlign)
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)
endif

if s:plug.is_installed('vimagit')
  nnoremap <silent> <Space>m :Magit<CR>
  let g:magit_show_help = 0
  let g:magit_default_show_all_files = 2
  let g:magit_default_fold_level = 2
  let g:magit_default_sections = ['global_help', 'info', 'unstaged', 'staged', 'commit']
endif

if s:plug.is_installed('vim-ruby')
  let g:rubycomplete_rails = 1
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_include_object = 1
  let g:rubycomplete_include_object_space = 1
endif

if s:plug.is_installed('vim-rails')
  let g:rails_some_option = 1
  let g:rails_level = 4
  let g:rails_syntax = 1
  let g:rails_statusline = 1
endif

if s:plug.is_installed('vim-go')
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_types = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_fail_silently = 1
endif

if s:plug.is_installed('deoplete.nvim')
  let g:deoplete#enable_at_startup = 0
  let g:deoplete#omni#input_patterns = {}
  let g:deoplete#omni#input_patterns.ruby = ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
endif

if s:plug.is_installed('buftabs')
  let g:buftabs_only_basename=1
  noremap <silent> <Tab> :bnext<CR>
  noremap <silent> <S-Tab> :bprev<CR>
endif

if s:plug.is_installed('ctrlp.vim')
  if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
    let g:ctrlp_cmd = 'CtrlPBuffer'
  endif
endif

if s:plug.is_installed('tagbar')
  let g:tagbar_autofocus = 1
endif

if s:plug.is_installed('neoterm')
  let g:neoterm_repl_ruby = 'pry'
  let g:neoterm_focus_when_tests_fail = 1

  if &buftype!="quickfix"
    tnoremap <silent> <ESC> <C-\><C-n>
  endif

  " open new terminal
  nnoremap <silent> <Space>tt :call neoterm#tnew()<cr>
  " open existing terminal
  nnoremap <silent> <Space>to :call neoterm#open()<cr>
  " hide/close terminal
  nnoremap <silent> <Space>th :call neoterm#close()<cr>
  " clear terminal
  nnoremap <silent> <Space>tc :call neoterm#clear()<cr>
  " kills the current job (send a <c-c>)
  nnoremap <silent> <Space>tk :call neoterm#kill()<cr>
endif

if s:plug.is_installed('vim-test')
  let test#strategy = 'vimux'
  nnoremap <silent> <Space>tn :TestNearest<CR>
  nnoremap <silent> <Space>tf :TestFile<CR>
  nnoremap <silent> <Space>ts :TestSuite<CR>
  nnoremap <silent> <Space>tl :TestLast<CR>
  nnoremap <silent> <Space>tv :TestVisit<CR>
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
set clipboard=unnamed

" swapファイル
silent execute '!mkdir -p $HOME/.vimswap'
set swapfile
set directory=~/.vimswap

" backupファイル
silent execute '!mkdir -p $HOME/.vimbackup'
set backup
set backupdir=~/.vimbackup

" 自動的にファイルのディレクトリに移動
set autochdir

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

" コロンとセミコロンの入れ替え
nnoremap : ;
nnoremap ; :

" ?を区切り文字として認識させない
autocmd FileType ruby setl iskeyword+=?

" ファイルを開く際のリスト表示
set wildmenu
set wildmode=longest,list:full

" Generate tags (ctags)
nnoremap <Leader>t :call Gentags()<CR>
" tags
set tags+=.ctags.d/tags
set tags+=.ctags.d/Gemfile.lock.tags

" grep to QuickFix
autocmd QuickFixCmdPost *grep* cwindow

" python3
let g:python3_host_prog = '/usr/local/bin/python3'

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
