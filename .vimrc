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

runtime! conf.d/autoload/*.vim
runtime! conf.d/autoload/plugins/*.vim

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" colorscheme
runtime! conf.d/colorscheme.vim
