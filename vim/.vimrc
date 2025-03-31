map <F7> :w ++enc=cp1252<CR>:e ++enc=cp1251<CR>:w ++enc=utf8<CR>:q<CR>
map <F5> :wq<CR>
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
nnoremap <Leader>fj :%!python -m json.tool<Enter>
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
