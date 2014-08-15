filetype off

" mkdir -p ~/.vim/bundle
" git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'

" plugins
runtime! conf.d/plugins/ag.vim.vim
runtime! conf.d/plugins/colorswatch.vim
runtime! conf.d/plugins/dash.vim.vim
runtime! conf.d/plugins/jQuery.vim
runtime! conf.d/plugins/lightline.vim
runtime! conf.d/plugins/neocomplcache.vim
runtime! conf.d/plugins/nerdtree.vim
runtime! conf.d/plugins/rsense-0.3.vim
runtime! conf.d/plugins/ruby-matchit.vim
runtime! conf.d/plugins/switch.vim
runtime! conf.d/plugins/unite.vim
runtime! conf.d/plugins/vim-coffee-script.vim
runtime! conf.d/plugins/vim-dispatch.vim
runtime! conf.d/plugins/vim-easymotion.vim
runtime! conf.d/plugins/vim-endwise.vim
runtime! conf.d/plugins/vim-fugitive.vim
runtime! conf.d/plugins/vim-markdown.vim
runtime! conf.d/plugins/vim-multiple-cursors.vim
runtime! conf.d/plugins/vim-quickrun.vim
runtime! conf.d/plugins/vim-rails.vim
runtime! conf.d/plugins/vim-ref-ri.vim
runtime! conf.d/plugins/vim-ref.vim
runtime! conf.d/plugins/vim-rspec.vim
runtime! conf.d/plugins/vim-ruby.vim
runtime! conf.d/plugins/vim-slim.vim
runtime! conf.d/plugins/vim-surround.vim
runtime! conf.d/plugins/vimproc.vim

" basic
runtime! conf.d/appearance.vim
runtime! conf.d/basic.vim
runtime! conf.d/color.vim
runtime! conf.d/edit.vim
runtime! conf.d/encoding.vim
runtime! conf.d/filetype.vim
runtime! conf.d/indent.vim
runtime! conf.d/misc.vim
runtime! conf.d/move.vim
runtime! conf.d/search.vim

" colorschema
runtime! conf.d/plugins/vim-colors-solarized.vim

filetype plugin indent on

" Installation check.
NeoBundleCheck
