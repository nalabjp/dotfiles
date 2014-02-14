" rsense
NeoBundleLazy 'Shougo/neocomplcache-rsense', {
  \ 'depends': 'Shougo/neocomplcache',
  \ 'autoload': { 'filetypes': 'ruby' }}
NeoBundleLazy 'taichouchou2/rsense-0.3', {
  \ 'build' : {
  \    'mac': 'ruby ~/.vim/bundle/rsense-0.3/etc/config.rb > ~/.rsense',
  \    'unix': 'ruby ~/.vim/bundle/rsense-0.3/etc/config.rb > ~/.rsense',
  \ } }

