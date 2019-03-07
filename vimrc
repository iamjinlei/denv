execute pathogen#infect()

filetype plugin indent on
syntax enable

set background=dark
colorscheme solarized

set nu
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

set hlsearch
set viminfo='20,<1000

noremap tl :GoDef<CR> 
noremap th <c-o>

"autocmd Filetype go set tabstop=4
"autocmd Filetype go set shiftwidth=4 
set tabstop=4
set shiftwidth=4

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
