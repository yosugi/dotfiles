"mswin.vimを読み込む
source $VIMRUNTIME/mswin.vim
behave mswin

set backupdir=>$TMP
set directory=>$TMP

set visualbell

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

set foldmethod=marker

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

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

