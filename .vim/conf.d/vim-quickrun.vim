" quickrun
NeoBundle 'thinca/vim-quickrun'

"RSpec対応
let g:quickrun_config = {}
let g:quickrun_config._ = {
  \ 'runner' : 'vimproc',
  \ }
let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec -c -f d', 'cmdopt': 'bundle exec spring', 'exec': '%o %c %s' }
