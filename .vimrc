set backupdir=$TMP
set directory=$TMP

set visualbell
set laststatus=2

set incsearch
set ignorecase
set smartcase
set smarttab
set hlsearch
set showcmd

syntax enable

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set foldmethod=marker
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

" C-L でハイライトを消す
nnoremap <silent><C-L> :noh<CR>:redraw<CR>:echo ""<CR>

" Use CTRL-Q to do what CTRL-V used to do
nnoremap <C-Q> <C-V>

"Prefix-key
nnoremap [prefix] <nop>
nmap <Space> [prefix]

nnoremap <silent>[prefix]w :<C-u>up<CR>
nnoremap <silent>[prefix]q :<C-u>q<CR>

" タグジャンプする時に新しいタブで開く
" see. http://kannokanno.hatenablog.com/entry/20121127/1354019826
nnoremap <silent>[prefix]<C-]> :<C-u>tab stj <C-R>=expand('<cword>')<CR><CR>

" タブの切り替え
if v:version >= 700
  nnoremap } gt
  nnoremap { gT
  nnoremap [prefix]} }
  nnoremap [prefix]{ {
endif
" 最後に編集した行にジャンプ
nnoremap gb `.

"mswin.vimを読み込む
source $VIMRUNTIME/mswin.vim
behave mswin

" mswin.vim を一部元に戻す
nnoremap <C-A> <C-A>
inoremap <C-A> <C-A>
cnoremap <C-A> <C-A>
onoremap <C-A> <C-A>
snoremap <C-A> <C-A>
xnoremap <C-A> <C-A>
nnoremap <C-Y> <C-Y>
inoremap <C-Y> <C-Y>
nnoremap <C-Z> <C-Z>
inoremap <C-Z> <C-Z>

" insertモードから抜ける
inoremap <silent> jj <ESC>:<C-u>up<CR>
inoremap <silent> <C-j> j

inoremap <C-f> <C-o>l
inoremap <C-b> <C-o>h
inoremap <C-e> <C-o>$
function! ToggleBol()
    let col = virtcol('.')
    let cmd = (col == 1) ? '^' : '0'
    execute "normal! " . cmd
endfunction
inoremap <C-a> <C-o>:call ToggleBol()<CR>

" paste モード
"autocmd InsertLeave * setlocal nopaste
nnoremap [prefix]pi :setlocal paste<CR>i
nnoremap [prefix]po :setlocal paste<CR>o
nnoremap [prefix]pt :setlocal paste! paste?<CR>
augroup PasteInsert
    autocmd!
    autocmd InsertLeave * setlocal nopaste
augroup END
 
command! -nargs=0 PasteInsertOff autocmd PasteInsert InsertLeave * setlocal nopaste
command! -nargs=0 PasteInsertOn autocmd! PasteInsert
        
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=white
highlight StatusLineNC term=bold cterm=bold ctermfg=black ctermbg=white
highlight TabLineSel term=bold cterm=bold ctermfg=black ctermbg=white
highlight TabLineFill term=bold cterm=bold ctermfg=black ctermbg=white

"全角スペースを　で表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

"タブを見えるように設定
set list
set listchars=tab:>-,trail:-,nbsp:-,extends:>,precedes:<,

"NeoBundle
" https://github.com/Shougo/neobundle.vim
" Install
" $ mkdir -p ~/.vim/bundle
" $ export GIT_SSL_NO_VERIFY=true
" $ git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
" :NeoBundleInstall でプラグインインストール :NeoBundleInstall! で更新
filetype plugin indent off " required!
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" gitを使ったプラグインマネージャ
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundleFetch 'Shougo/unite.vim'
NeoBundleFetch 'Shougo/neomru.vim'
"NeoBundleFetch 'tpope/vim-fugitive'
"NeoBundleFetch 'gregsexton/gitv'
NeoBundleFetch 'kien/ctrlp.vim'
NeoBundleFetch 'thinca/vim-quickrun'
"NeoBundleFetch 'scrooloose/nerdtree'
"NeoBundleFetch 'tpope/vim-surround'
"NeoBundleFetch 'kana/vim-smartchr'
NeoBundleFetch 'docteurklein/php-getter-setter.vim'
NeoBundleFetch 'bthemad/php-doc.vim'
"リポジトリを持たないプラグイン
"NeoBundleFetch 'im_control', {'type' : 'nosync', 'base' : '~/.vim/bundle'}
call neobundle#end()

filetype plugin indent on

" unite.vim の設定
nnoremap [unite]    <Nop>
nmap     [prefix]u [unite]

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

"history/yankの有効化
let g:unite_source_history_yank_enable=1  
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>

"ctrlp の設定
set wildignore+=*/cache/*,
let g:ctrlp_map = ' cp'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("t")': ['<c-a>'],
        \ }

"" 引数なしで実行したとき、NERDTreeを実行する
"let file_name = expand("%:p")
"if has('vim_starting') &&  file_name == ""
""    autocmd VimEnter * call NERDTree()
"    autocmd VimEnter * execute 'NERDTree ./'
"endif

" smartchr の設定
"inoremap <expr> = smartchr#one_of(' = ', ' == ', '=')
"inoremap <expr> ; smartchr#one_of(';', ';<ESC>')
"inoremap <expr> . smartchr#loop('.', '->', '...')
"inoremap <expr> , smartchr#loop(',', '=>')
"inoremap <expr> ; smartchr#loop(';', ';<ESC>:up<CR>')
"inoremap <expr> j smartchr#loop('j', '<ESC>:up<CR>')
"
"inoremap <expr> { smartchr#loop('{', '{}<Left>')
"inoremap <expr> [ smartchr#loop('[', '[]<Left>')
"inoremap <expr> ( smartchr#loop('(', '()<Left>')
"inoremap <expr> " smartchr#loop('"', '""<Left>')
"inoremap <expr> ' smartchr#loop('''', '''''<Left>')

" カレントディレクトリを開いてるファイルにする
" ref. http://vim-users.jp/2009/09/hack69/
command! -nargs=? -complete=dir -bang CdCurrent call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang != ''
        pwd
    endif
endfunction

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
\ 'cmdopt' : '-f',
\ 'args' : '',
\ 'exec' : '%c %o %a %s',
\ }

let g:pdv_cfg_Author = "yosugi <your@email.address.com>"
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = "MIT Lisence"

"inoremap <C-k> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-k> :call PhpDocSingle()<CR>
vnoremap <C-k> :call PhpDocRange()<CR>

autocmd FileType php set makeprg=php\ -l\ %
