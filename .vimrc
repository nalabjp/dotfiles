""""""""""""""""""""""""""""""""""""
" Required:
""""""""""""""""""""""""""""""""""""
filetype off

if !isdirectory(expand("~/.vim/bundle/"))
  call system("mkdir -p ~/.vim/bundle")
  call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
endif

runtime macros/matchit.vim

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  """"""""""""""""""""""""""""""""""""
  " Required:
  """"""""""""""""""""""""""""""""""""
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

""""""""""""""""""""""""""""""""""""
" Required:
""""""""""""""""""""""""""""""""""""
call neobundle#begin(expand('~/.vim/bundle/'))

""""""""""""""""""""""""""""""""""""
" Required:
""""""""""""""""""""""""""""""""""""
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

""""""""""""""""""""""""""""""""""""
" ag.vim
""""""""""""""""""""""""""""""""""""
NeoBundle 'rking/ag.vim'

""""""""""""""""""""""""""""""""""""
" colorswatch.vim: 色見本
""""""""""""""""""""""""""""""""""""
NeoBundle 'cocopon/colorswatch.vim'

""""""""""""""""""""""""""""""""""""
" dash.vim
""""""""""""""""""""""""""""""""""""
NeoBundle 'rizzatti/funcoo.vim'
NeoBundle 'rizzatti/dash.vim'

""""""""""""""""""""""""""""""""""""
" lightline.vim: StatusLineの装飾
""""""""""""""""""""""""""""""""""""
NeoBundle 'itchyny/lightline.vim'

let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night_Bright',
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

""""""""""""""""""""""""""""""""""""
" neocomplecache: 補完
""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/neocomplcache'

".vim/bundle/neocomplcache/doc/neocomplcache.txt
"から、必須設定と書かれている部分をコピペ
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \  'default' : '',
      \  'vimshell' : $HOME.'/.vimshell_hist',
      \  'scheme' : $HOME.'/.gosh_completions'
      \}

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

""""""""""""""""""""""""""""""""""""
" nerdtree : ツリー型エクスプローラ
""""""""""""""""""""""""""""""""""""
NeoBundle 'scrooloose/nerdtree'

nnoremap <silent> <Leader>nt :<C-u>NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""
" ruby-matchit: endに%で移動
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'ruby-matchit', {
  \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml', 'slim'] } }


""""""""""""""""""""""""""""""""""""
" switch.vim: キーワード切り替え
""""""""""""""""""""""""""""""""""""
NeoBundle 'AndrewRadev/switch.vim'

nnoremap - :Switch<CR>
let s:switch_definition = {
  \ '*': [
  \   ['is', 'are']
  \ ],
  \ 'ruby,eruby,haml,slim' : [
  \   ['if', 'unless'],
  \   ['while', 'until'],
  \   ['.blank?', '.present?'],
  \   ['include', 'extend'],
  \   ['class', 'module'],
  \   ['.inject', '.delete_if'],
  \   ['.map', '.map!'],
  \   ['attr_accessor', 'attr_reader', 'attr_writer'],
  \ ],
  \ 'Gemfile,Berksfile' : [
  \   ['=', '<', '<=', '>', '>=', '~>'],
  \ ],
  \ 'ruby.application_template' : [
  \   ['yes?', 'no?'],
  \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
  \   ['controller', 'model', 'view', 'migration', 'scaffold'],
  \ ],
  \ 'erb,html,php' : [
  \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
  \ ],
  \ 'rails' : [
  \   [100, ':continue', ':information'],
  \   [101, ':switching_protocols'],
  \   [102, ':processing'],
  \   [200, ':ok', ':success'],
  \   [201, ':created'],
  \   [202, ':accepted'],
  \   [203, ':non_authoritative_information'],
  \   [204, ':no_content'],
  \   [205, ':reset_content'],
  \   [206, ':partial_content'],
  \   [207, ':multi_status'],
  \   [208, ':already_reported'],
  \   [226, ':im_used'],
  \   [300, ':multiple_choices'],
  \   [301, ':moved_permanently'],
  \   [302, ':found'],
  \   [303, ':see_other'],
  \   [304, ':not_modified'],
  \   [305, ':use_proxy'],
  \   [306, ':reserved'],
  \   [307, ':temporary_redirect'],
  \   [308, ':permanent_redirect'],
  \   [400, ':bad_request'],
  \   [401, ':unauthorized'],
  \   [402, ':payment_required'],
  \   [403, ':forbidden'],
  \   [404, ':not_found'],
  \   [405, ':method_not_allowed'],
  \   [406, ':not_acceptable'],
  \   [407, ':proxy_authentication_required'],
  \   [408, ':request_timeout'],
  \   [409, ':conflict'],
  \   [410, ':gone'],
  \   [411, ':length_required'],
  \   [412, ':precondition_failed'],
  \   [413, ':request_entity_too_large'],
  \   [414, ':request_uri_too_long'],
  \   [415, ':unsupported_media_type'],
  \   [416, ':requested_range_not_satisfiable'],
  \   [417, ':expectation_failed'],
  \   [422, ':unprocessable_entity'],
  \   [423, ':precondition_required'],
  \   [424, ':too_many_requests'],
  \   [426, ':request_header_fields_too_large'],
  \   [500, ':internal_server_error'],
  \   [501, ':not_implemented'],
  \   [502, ':bad_gateway'],
  \   [503, ':service_unavailable'],
  \   [504, ':gateway_timeout'],
  \   [505, ':http_version_not_supported'],
  \   [506, ':variant_also_negotiates'],
  \   [507, ':insufficient_storage'],
  \   [508, ':loop_detected'],
  \   [510, ':not_extended'],
  \   [511, ':network_authentication_required'],
  \ ],
  \ 'rspec': [
  \   ['describe', 'context', 'specific', 'example'],
  \   ['before', 'after'],
  \   ['be_true', 'be_false'],
  \   ['get', 'post', 'put', 'delete'],
  \   ['==', 'eql', 'equal'],
  \   { '\.should_not': '\.should' },
  \   ['\.to_not', '\.to'],
  \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
  \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
  \ ],
  \ 'markdown' : [
  \   ['[ ]', '[x]']
  \ ]
  \ }


""""""""""""""""""""""""""""""""""""
" tcomment_vim: コメントトグル
""""""""""""""""""""""""""""""""""""
NeoBundle 'tomtom/tcomment_vim'

""""""""""""""""""""""""""""""""""""
" unite.vim: ファイラ
""""""""""""""""""""""""""""""""""""
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

" codic
NeoBundleLazy 'rhysd/unite-codic.vim', {
  \ 'depends' : ['Shougo/unite.vim', 'koron/codic-vim'] }

""""""""""""""""""""""""""""""""""""
" vim-coffee-script
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'kchmck/vim-coffee-script', {
   \     'autoload': {
   \         'filename_patterns': ['.*\.coffee'],
   \         'filetype': ['coffee'],
   \     }
   \ }

""""""""""""""""""""""""""""""""""""
" vim-dispatch:
""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-dispatch'

""""""""""""""""""""""""""""""""""""
" vim-easymotion: 移動先をハイライト
""""""""""""""""""""""""""""""""""""
NeoBundle 'Lokaltog/vim-easymotion'

let g:EasyMotion_smartcase = 1
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

""""""""""""""""""""""""""""""""""""
" lexima: '' () を良しなにするのとif do def やらのブロック閉じる
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'cohama/lexima.vim', {
  \ 'autoload' : {
  \   'insert' : 1,
  \ } }

""""""""""""""""""""""""""""""""""""
" vim-fugitive: Git操作
""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-fugitive'

""""""""""""""""""""""""""""""""""""
" vim-indent-guides
""""""""""""""""""""""""""""""""""""
NeoBundle 'nathanaelkane/vim-indent-guides'

let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=1
let g:indent_guides_guide_size = 1

""""""""""""""""""""""""""""""""""""
" vim-markdown
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'rcmdnk/vim-markdown', {
   \     'autoload': {
   \         'filetypes': ['markdown']
   \     }
   \ }
NeoBundleLazy 'kannokanno/previm', {
   \     'depends': [
   \         'open-browser.vim'
   \     ],
   \     'autoload': {
   \         'filetypes': ['markdown']
   \     }
   \ }

au BufRead,BufNewFile *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1

""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors: 複数のテキストを同時編集
""""""""""""""""""""""""""""""""""""
NeoBundle 'terryma/vim-multiple-cursors'

""""""""""""""""""""""""""""""""""""
" vim-quickrun
""""""""""""""""""""""""""""""""""""
NeoBundle 'thinca/vim-quickrun'

""""""""""""""""""""""""""""""""""""
" vim-rails
""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-rails'

let g:rails_some_option = 1
let g:rails_level = 4
let g:rails_syntax = 1
let g:rails_statusline = 1

""""""""""""""""""""""""""""""""""""
" vim-ref-ri: リファレンス
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'taka84u9/vim-ref-ri', {
  \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
  \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml', 'slim'] } }

""""""""""""""""""""""""""""""""""""
" vim-ruby
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml', 'slim'] } }

""""""""""""""""""""""""""""""""""""
" vim-slim
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'slim-template/vim-slim', {
   \     'autoload': {
   \         'filetypes': ['slim'],
   \     }
   \ }

""""""""""""""""""""""""""""""""""""
" vim-surround: 文字列の囲み等
""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""
" vim-tags: ctags
""""""""""""""""""""""""""""""""""""
NeoBundle 'szw/vim-tags'
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"

""""""""""""""""""""""""""""""""""""
" vimproc: 非同期実行
""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

""""""""""""""""""""""""""""""""""""
" yankround.vim: コピペ拡張
""""""""""""""""""""""""""""""""""""
NeoBundle 'LeafCage/yankround.vim'

" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>

""""""""""""""""""""""""""""""""""""
" vim-easy-align: 文章整形
""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""
" vim-tmux-navigator: vimとtmuxをsmartに切り替え
""""""""""""""""""""""""""""""""""""
NeoBundle 'christoomey/vim-tmux-navigator'

""""""""""""""""""""""""""""""""""""
" vim-auto-save: auto save
""""""""""""""""""""""""""""""""""""
NeoBundle 'vim-scripts/vim-auto-save'
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_postsave_hook = 'TagsGenerate'

""""""""""""""""""""""""""""""""""""
" Required:
""""""""""""""""""""""""""""""""""""
call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

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

""""""""""""""""""""""""""""""""""""
" basic
""""""""""""""""""""""""""""""""""""
" vi互換off↲
set nocompatible

" リーダー↲
nmap <Space> <Leader>
let mapleader = "\<Space>"

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

highlight Search cterm=NONE ctermfg=gray ctermbg=red

""""""""""""""""""""""""""""""""""""
" edit
""""""""""""""""""""""""""""""""""""
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

" カーソルから行頭まで削除
inoremap <silent> <C-d>0 <Esc>lc0
" カーソルから行末まで削除
inoremap <silent> <C-d>$ <Esc>lc$
inoremap <silent> <C-d>9 <Esc>lc$
" カーソルから行頭までヤンク
inoremap <silent> <C-y>0 <Esc>ly0<Insert>
" カーソルから行末までヤンク
inoremap <silent> <C-y>$ <Esc>ly$<Insert>
inoremap <silent> <C-y>9 <Esc>ly$<Insert>

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
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee

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
if has('autocmd')
  "filetype plugin on
  "filetype indent on

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
endif

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

""""""""""""""""""""""""""""""""""""
" move
""""""""""""""""""""""""""""""""""""
" 表示行単位で移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" 画面送り
noremap <Space>j <C-f>
noremap <Space>k <C-b>

" 行頭、行末
nmap 1 0
nmap 0 ^
nmap 9 $

" インサートモードでjkbfで移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" 対応する括弧に移動
nnoremap [ %
nnoremap ] %

" 画面端でスクロースする際の余裕
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
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Ctrl-iでヘルプ
nnoremap <C-i>  :<C-u>help<Space>
" カーソル下のキーワードをヘルプでひく
nnoremap <C-i><C-i> :<C-u>help<Space><C-r><C-w><Enter>

""""""""""""""""""""""""""""""""""""
" Required:
""""""""""""""""""""""""""""""""""""
filetype plugin indent on

""""""""""""""""""""""""""""""""""""
" colorscheme
""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
let base16colorspace=256
colorscheme base16-solarized
