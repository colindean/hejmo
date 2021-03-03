" vim-plug itself, to get help
Plug 'junegunn/vim-plug'

" set sensible defaults
Plug 'tpope/vim-sensible'

" zenburn colorscheme
Plug 'jnurmine/Zenburn'
" distraction-free writing with :Goyo
Plug 'junegunn/goyo.vim',  { 'for': 'markdown' }
" Markdown rendering with :MarkdownPreview and :MarkdownPreviewStop
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" airline for nice stats
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" git integration for the gutter
Plug 'airblade/vim-gitgutter'
" git integration everywhere
Plug 'tpope/vim-fugitive'

" file navigation
Plug 'scrooloose/nerdtree'
" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" .editorconfig support
Plug 'editorconfig/editorconfig-vim'
" better commenting
Plug 'scrooloose/nerdcommenter'
" whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'
" floating terminal
Plug 'voldikss/vim-floaterm'

" improves slash searching
Plug 'junegunn/vim-slash'
" hit zz to center a search hit
noremap <plug>(slash-after) zz

" surround control - type cs'" to turn single quotes to double!
Plug 'tpope/vim-surround'

" syntax checking
"Plug 'vim-syntastic/syntastic'
" linting
Plug 'w0rp/ale'

" startup screen with most recently used files
Plug 'mhinz/vim-startify'

"""""""" language support
" polyglot handles most of them now
Plug 'sheerun/vim-polyglot'
" hocon for scala
Plug 'GEverding/vim-hocon'
" ledger
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'rcaputo/vim-ledger_x', { 'for': 'ledger' }
" folding for yaml
Plug 'pedrohdz/vim-yaml-folds', { 'for': 'yaml' }
" :Rubocop -a
Plug 'ngmy/vim-rubocop', { 'for': 'ruby' }
" Java properties files
Plug 'kamichidu/vim-edit-properties'

" automatic formatting - I may regret this
Plug 'Chiel92/vim-autoformat'

" zettelkasten
Plug 'fiatjaf/neuron.vim'
" jq interactivity - https://github.com/bfrg/vim-jqplay
Plug 'bfrg/vim-jqplay'
" jq language support
Plug 'bfrg/vim-jq'
