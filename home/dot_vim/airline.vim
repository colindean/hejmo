" From https://github.com/binarycleric/dot-vim/blob/master/.vimrc

" So airline doesn't sit and wait for other things to happen. So annoying.
set ttimeoutlen=50

let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0

"let g:airline_left_sep = ""
"let g:airline_left_alt_sep = ""
"let g:airline_right_sep = ""
"let g:airline_right_alt_sep = ""
let g:airline_branch_prefix = ""
let g:airline_readonly_symbol = ""
let g:airline_theme = 'bubblegum'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#whitespace#checks = ['indent']
let airline#extensions#hunks#non_zero_only = 1

if exists('aairline#section#create') " if airline is installed
  let g:airline_section_b = ""
  let g:airline_section_y = ""
  let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr'])
" let g:airline_section_z = ""
endif
