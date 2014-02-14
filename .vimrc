filetype off

" mkdir -p ~/.vim/bundle
" git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'

filetype plugin indent on

if isdirectory(expand('~/.vim/conf.d'))
  runtime! conf.d/*.vim
endif

" Installation check.
NeoBundleCheck
