"mswin.vimを読み込む
source $VIMRUNTIME/mswin.vim
behave mswin

set     backupdir=>$TMP
set     directory=>$TMP

" C-L でハイライトを消す
nnoremap <C-L>	:noh<CR>:redraw<CR>

" mswin.vim を一部元に戻す
noremap <C-A> <C-A>
inoremap <C-A> <C-A>
cnoremap <C-A> <C-A>
onoremap <C-A> <C-A>
snoremap <C-A> <C-A>
xnoremap <C-A> <C-A>

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
