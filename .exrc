set autoindent
set cindent
set expandtab
set hlsearch
set number
set shiftwidth=4
set smarttab
set tabstop=4
au FileType c,cpp,h setlocal comments-=:// comments+=f://
au FileType python setlocal expandtab smarttab formatoptions=croql comments-=:# comments+=f:#
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags
