" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc)
"
" Last Change: 09-Sep-2003.
" Maintainer:  MURAOKA Taro <koron@tka.att.ne.jp>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" (試験中)
" Vimをモードレスな普通のエディタに変身させてしまうCreamを手軽に利用するため
" の設定。$VIMに下記URLから入手したcream/ディレクトリを置けば、起動時に自動
" 的に読み込まれる。
if 1 && filereadable($VIM.'/cream/cream.vim')
  let g:cream_enabled = 1
  if filereadable($VIM.'/cream/_vimrc')
    source $VIM/cream/_vimrc
  endif
  finish
endif

"---------------------------------------------------------------------------
" 日本語対応のための設定:
"
" ファイルを読込む時にトライするエンコーディングの順序を指定する。漢字コード
" 自動判別機能を利用する場合には別途iconv.dllが必要。iconv.dllについては
" README_j.txtを参照。オプション'encoding'はWindowsから取得できる情報を基
" に、自動的にcp932(Windows)に設定される。UNIXでは設定されないこともあるらし
" い。
"
" 日本語を扱うために必要
set encoding=japan
" ファイルの漢字コード自動判別のために必要。(要iconv)
if has('iconv')
  set fileencodings&
  set fileencodings+=ucs-2le,ucs-2
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがJISX0213に対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  let &fileencodings = &fileencodings.','.s:enc_jis.',utf-8'
  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    set fileencodings+=cp932
    let &encoding = s:enc_euc
  else
    let &fileencodings = &fileencodings.','.s:enc_euc
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif
" MacOS Xメニューの日本語化 (メニュー表示前に行なう必要がある)
if has('mac')
  set langmenu=japanese
endif
" 日本語入力用のkeymapの設定例 (コメントアウト)
if has('keymap')
  " ローマ字仮名のkeymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  source $VIMRUNTIME/vimrc_example.vim
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=8
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

" Copyright (C) 2003 KaoriYa/MURAOKA Taro

""""" my config start """"
set clipboard=unnamed 
" キーバインド変更

" 検索を emacs ちっくに
"map <C-s> /
" ビジュアルモードのときも
"vnoremap <C-S> y:%s/<C-R>"//g<Left><Left>

" インサートモードを emacs っぽく
" ←
inoremap <C-B> <left>
" →
inoremap <C-F> <right>
" ↑
inoremap <C-P> <up>
" ↓
inoremap <C-N> <down>
" 行頭
inoremap <C-A> <Home>
" 行末
inoremap <C-E> <End>
" 一文字削除
inoremap <C-D> <DEL>

" カーソル行を中央に表示
inoremap <C-L> <C-O>zz

" 順方向ワード補完
inoremap <C-J> <C-N>
" 逆方向ワード補完
inoremap <C-K> <C-P>

" カーソルの下の行の同じ位置の文字を挿入
inoremap <C-U> <C-E>

" カーソルの下の行の同じ位置の文字を挿入
inoremap <Down> <C-e>
" カーソルの上の行の同じ位置の文字を挿入
inoremap <UP> <C-y>

" 順方向ワード補完(Tab)
"inoremap <C-I> <C-N>
" 逆方向ワード補完
"inoremap <S-Tab> <C-P>
" 行末まで削除
"inoremap <C-K> <C-O>D
" ペースト
"inoremap <C-Y> <C-O>p

" コマンドモードを emacs っぽく
" 行頭へ移動
cnoremap <C-a> <Home>
" 一文字戻る
cnoremap <C-b> <Left>
" カーソルの下の文字を削除
cnoremap <C-d> <Del>
" 行末へ移動
cnoremap <C-e> <End>
" 一文字進む
cnoremap <C-f> <Right>
" コマンドライン履歴を一つ進む
cnoremap <C-n> <Down>
" コマンドライン履歴を一つ戻る
cnoremap <C-p> <Up>
" 前の単語へ移動
cnoremap <Esc><C-b> <S-Left>
" 次の単語へ移動
cnoremap <Esc><C-f> <S-Right>
"" 直前のヤンクをあれ風にペースト
"cnoremap <C-y> <C-r>"
" コマンドライン履歴を表示 
cnoremap <C-y>	<C-f>
" コマンド補完
"cnoremap <Tab>	      <C-L>
" ファイルパスのペースト(KoRoNさんの掲示板より拝借)
cnoremap <C-x> <C-r>=expand('%:p:h')<CR>/
"" カーソルの上の単語をペースト
"cnoremap <C-@> <C-r><C-w>
"" ファイル名をペースト(あまりつかわないけど)
"cnoremap <C-o> <C-r>%
" ^K と表示されるのが邪魔なので Del に変更
cnoremap <C-k> <Del>
" ^G と表示されるのが邪魔なので ESC に変更
cnoremap <C-g> <ESC>
"" なぜか <C-h> が Del になっているので BS に変更
"cnoremap <C-h> <BS>

" 折り返し表示行を画面の行単位で移動
"nnoremap j gj
"nnoremap k gk

" C-L でハイライトを消す
nnoremap <C-L>	:noh<CR>:redraw<CR>

nnoremap Y	y$

" ここから設定 config

" バックアップファイルを一箇所に作成
"set backupdir=>c:\home\sugi\tmp
set     backupdir=>$TMP
" スワップファイルを一箇所に作成
"set directory=>c:\home\sugi\tmp
set     directory=>$TMP

" Chalice の設定
set runtimepath+=$VIM/chalice

" クリップボードと名前なしレジスタを同期
"set clipboard=unnamed 


" インクリメンタルサーチを使う
set incsearch

set listchars=tab:\ \ 
set list

" 確認ダイアログを出す
set confirm

" auto date のフォーマット
"let autodate_format = '%d %3m. %Y %H:%M'
let autodate_format = '%d %3m. %Y'

"音を消して、画面フラッシュ
set visualbell

" デフォルトタブ幅の設定
set tabstop=4
set sw=4

" 隠しバッファを使う
"set hidden

" fold モード設定
set foldmethod=marker

" ~(チルダ)を operator 風に
"set tildeop

" HTML でタグを大文字にするコマンド
command! -nargs=? -range=% ToUpperHtml :<line1>,<line2>substitute/<\l\+\|\/\l\+>/\U&/g<args>

command! -nargs=? Tab :set listchars=tab:>-,extends:<,trail:-,eol:<
command! -nargs=? NoTab :set listchars=tab:

set keymap=tutcodes
