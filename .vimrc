set backupdir=$TMP
set directory=$TMP

set visualbell
set laststatus=2

set incsearch
set hlsearch

" C-L でハイライトを消す
nnoremap <C-L>	:noh<CR>:redraw<CR>

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"mswin.vimを読み込む
source $VIMRUNTIME/mswin.vim
behave mswin

" mswin.vim を一部元に戻す
noremap <C-A> <C-A>
inoremap <C-A> <C-A>
cnoremap <C-A> <C-A>
onoremap <C-A> <C-A>
snoremap <C-A> <C-A>
xnoremap <C-A> <C-A>

set foldmethod=marker

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" タブの切り替えを
" CTRL+Tab SHIFT+Tabで行うように
"
if v:version >= 700
  nnoremap <C-Tab>   gt
  nnoremap <C-S-Tab> gT
endif

" qfixappにruntimepathを通す(パスは環境に合わせてください)
set runtimepath+=c:/home/yosugi/softs/gvim/qfixapp

" キーマップリーダー
let QFixHowm_Key = 'g'
let QFixHowm_FileType = 'markdown'
let QFixHowm_FileExt = 'md'
" タイトル記号
let QFixHowm_Title = '#'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = 'c:/home/yosugi/Dropbox/howm/'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'

" 横分割をするようにする
let g:quickrun_config={'*': {'split': ''}}
"let g:quickrun_config.markdown = {
"\ 'outputter' : 'null',
"\ 'command' : 'open',
"\ 'cmdopt' : '-a',
"\ 'args' : 'Marked',
"\ 'exec' : '%c %o %a %s',
"\ }

let g:quickrun_config.php = {
\ 'command' : 'c:/home/xampp/php/php.exe',
\ 'cmdopt' : '-f',
\ 'args' : '',
\ 'exec' : '%c %o %a %s',
\ }

source ~/.vim/php-doc.vim

let g:pdv_cfg_Author = "yosugi <your@email.address.com>"
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = "MIT Lisence"

inoremap <C-@> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-@> :call PhpDocSingle()<CR>
vnoremap <C-@> :call PhpDocRange()<CR>

