set backupdir=$TMP
set directory=$TMP

set visualbell
set laststatus=2

set incsearch
set ignorecase
set smartcase
set hlsearch
set showcmd

syntax enable

" C-L でハイライトを消す
nnoremap <silent><C-L> :noh<CR>:redraw<CR>:echo ""<CR>

" Use CTRL-Q to do what CTRL-V used to do
nnoremap <C-Q> <C-V>

"Prefix-key
nnoremap [prefix] <nop>
nmap ; [prefix]

nnoremap <silent>[prefix]w :<C-u>up<CR>
nnoremap <silent>[prefix]q :<C-u>q<CR>

"mswin.vimを読み込む
source $VIMRUNTIME/mswin.vim
behave mswin

" mswin.vim を一部元に戻す
"noremap <C-A> <C-A>
""inoremap <C-A> <C-A>
"cnoremap <C-A> <C-A>
"onoremap <C-A> <C-A>
"snoremap <C-A> <C-A>
"xnoremap <C-A> <C-A>


" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j

inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>

inoremap <C-e> <C-o>$
function! ToggleBol()
    let col = virtcol('.')
    let cmd = (col == 1) ? '^' : '0'
    execute "normal! " . cmd
endfunction
inoremap <C-a> <C-o>:call ToggleBol()<CR>
        
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=white
highlight StatusLineNC term=bold cterm=bold ctermfg=black ctermbg=white
highlight TabLineSel term=bold cterm=bold ctermfg=black ctermbg=white
highlight TabLineFill term=bold cterm=bold ctermfg=black ctermbg=white

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
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

" gitを使ったプラグインマネージャ
NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-surround'
NeoBundle 'docteurklein/php-getter-setter.vim'
NeoBundle 'bthemad/php-doc.vim'
"リポジトリを持たないプラグイン
"NeoBundle 'im_control', {'type' : 'nosync', 'base' : '~/.vim/bundle'}

filetype plugin indent on

" unite.vim の設定
" バッファ一覧
nnoremap <silent> [prefix]ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [prefix]uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [prefix]ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [prefix]um :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> [prefix]ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

"history/yankの有効化
let g:unite_source_history_yank_enable=1  
nnoremap <silent> [prefix]uy :<C-u>Unite history/yank<CR>

"ctrlp の設定
set wildignore+=*/cache/*,
let g:ctrlp_map = ';p'
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

let g:pdv_cfg_Author = "yosugi <your@email.address.com>"
let g:pdv_cfg_Copyright = ""
let g:pdv_cfg_License = "MIT Lisence"

"inoremap <C-k> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-k> :call PhpDocSingle()<CR>
vnoremap <C-k> :call PhpDocRange()<CR>

