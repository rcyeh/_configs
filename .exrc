set nu
set ts=4
set autoindent
set cindent
set sw=4
set hlsearch
au FileType c,cpp,h setlocal comments-=:// comments+=f://
au FileType python setlocal expandtab smarttab formatoptions=croql comments-=:# comments+=f:#
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags
