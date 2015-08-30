filetype off

if !isdirectory(expand("~/.vim/bundle/"))
  call system("mkdir -p ~/.vim/bundle")
  call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" plugins
runtime! conf.d/plugins/ag.vim.vim
runtime! conf.d/plugins/colorswatch.vim
runtime! conf.d/plugins/dash.vim.vim
runtime! conf.d/plugins/jQuery.vim
runtime! conf.d/plugins/lightline.vim
runtime! conf.d/plugins/neocomplcache.vim
runtime! conf.d/plugins/nerdtree.vim
runtime! conf.d/plugins/ruby-matchit.vim
runtime! conf.d/plugins/switch.vim
runtime! conf.d/plugins/tcomment_vim.vim
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
runtime! conf.d/plugins/vim-tags.vim
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

" colorscheme
runtime! conf.d/plugins/vim-colors-solarized.vim

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" colorscheme
runtime! conf.d/plugins/vim-colors-solarized2.vim
