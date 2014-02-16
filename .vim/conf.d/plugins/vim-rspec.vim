" rspec
NeoBundle 'thoughtbot/vim-rspec'

let g:rspec_command = "Dispatch bundle exec spring rspec -cfs {spec}"
nmap <silent><leader>c :call RunCurrentSpecFile()<CR>
nmap <silent><leader>n :call RunNearestSpec()<CR>
nmap <silent><leader>l :call RunLastSpec()<CR>
nmap <silent><leader>a :call RunAllSpecs()<CR>
