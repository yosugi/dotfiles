" vim:set ts=8 sts=2 sw=2 tw=0: (���̍s�Ɋւ��Ă�:help modeline���Q��)
"
" An example for a Japanese version vimrc file.
" ���{��ł̃f�t�H���g�ݒ�t�@�C��(vimrc)
"
" Last Change: 09-Sep-2003.
" Maintainer:  MURAOKA Taro <koron@tka.att.ne.jp>
"
" ���:
" ���̃t�@�C���ɂ�Vim�̋N�����ɕK���ݒ肳���A�ҏW���̋����Ɋւ���ݒ肪��
" ����Ă��܂��BGUI�Ɋւ���ݒ��gvimrc�ɏ�������Ă��܂��B
"
" �l�p�ݒ��_vimrc�Ƃ����t�@�C�����쐬�������ōs�Ȃ��܂��B_vimrc�͂��̃t�@
" �C���̌�ɓǍ��܂�邽�߁A�����ɏ����ꂽ���e���㏑�����Đݒ肷�邱�Ƃ��o��
" �܂��B_vimrc��$HOME�܂���$VIM�ɒu���Ă����K�v������܂��B$HOME��$VIM����
" �D�悳��A$HOME�ł݂������ꍇ$VIM�͓Ǎ��܂�܂���B
"
" �Ǘ��Ҍ����ɖ{�ݒ�t�@�C���𒼐ڏ����������ɍς܂��邱�Ƃ�ړI�Ƃ��āA�T�C
" �g���[�J���Ȑݒ��ʃt�@�C���ōs�Ȃ���悤�ɔz�����Ă���܂��BVim�N������
" �T�C�g���[�J���Ȑݒ�t�@�C��($VIM/vimrc_local.vim)�����݂���Ȃ�΁A�{�ݒ�
" �t�@�C���̎�v�������ǂݍ��܂��O�Ɏ����I�ɓǂݍ��݂܂��B
"
" �ǂݍ��݌�A�ϐ�g:vimrc_local_finish����0�̒l�ɐݒ肳��Ă����ꍇ�ɂ͖{��
" ��t�@�C���ɏ����ꂽ���e�͈�؎��s����܂���B�f�t�H���g�����S�č����ւ�
" �����ꍇ�ɗ��p���ĉ������B
"
" �Q�l:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" �T�C�g���[�J���Ȑݒ�($VIM/vimrc_local.vim)������Γǂݍ��ށB�ǂݍ��񂾌��
" �ϐ�g:vimrc_local_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐ݒ�
" �t�@�C���̓Ǎ��𒆎~����B
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ���[�U�D��ݒ�($HOME/.vimrc_first.vim)������Γǂݍ��ށB�ǂݍ��񂾌�ɕϐ�
" g:vimrc_first_finish�ɔ�0�Ȓl���ݒ肳��Ă����ꍇ�ɂ́A����ȏ�̐ݒ�t�@
" �C���̓Ǎ��𒆎~����B
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" (������)
" Vim�����[�h���X�ȕ��ʂ̃G�f�B�^�ɕϐg�����Ă��܂�Cream����y�ɗ��p���邽��
" �̐ݒ�B$VIM�ɉ��LURL������肵��cream/�f�B���N�g����u���΁A�N�����Ɏ���
" �I�ɓǂݍ��܂��B
if 1 && filereadable($VIM.'/cream/cream.vim')
  let g:cream_enabled = 1
  if filereadable($VIM.'/cream/_vimrc')
    source $VIM/cream/_vimrc
  endif
  finish
endif

"---------------------------------------------------------------------------
" ���{��Ή��̂��߂̐ݒ�:
"
" �t�@�C����Ǎ��ގ��Ƀg���C����G���R�[�f�B���O�̏������w�肷��B�����R�[�h
" �������ʋ@�\�𗘗p����ꍇ�ɂ͕ʓriconv.dll���K�v�Biconv.dll�ɂ��Ă�
" README_j.txt���Q�ƁB�I�v�V����'encoding'��Windows����擾�ł��������
" �ɁA�����I��cp932(Windows)�ɐݒ肳���BUNIX�ł͐ݒ肳��Ȃ����Ƃ�����炵
" ���B
"
" ���{����������߂ɕK�v
set encoding=japan
" �t�@�C���̊����R�[�h�������ʂ̂��߂ɕK�v�B(�viconv)
if has('iconv')
  set fileencodings&
  set fileencodings+=ucs-2le,ucs-2
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodings���\�z
  let &fileencodings = &fileencodings.','.s:enc_jis.',utf-8'
  if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    set fileencodings+=cp932
    let &encoding = s:enc_euc
  else
    let &fileencodings = &fileencodings.','.s:enc_euc
  endif
  " �萔������
  unlet s:enc_euc
  unlet s:enc_jis
endif
" ���b�Z�[�W����{��ɂ��� (Windows�ł͎����I�ɔ��f�E�ݒ肳��Ă���)
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
" MacOS X���j���[�̓��{�ꉻ (���j���[�\���O�ɍs�Ȃ��K�v������)
if has('mac')
  set langmenu=japanese
endif
" ���{����͗p��keymap�̐ݒ�� (�R�����g�A�E�g)
if has('keymap')
  " ���[�}��������keymap
  "silent! set keymap=japanese
  "set iminsert=0 imsearch=0
endif

"---------------------------------------------------------------------------
" ���j���[�t�@�C�������݂��Ȃ��ꍇ�͗\��'guioptions'�𒲐����Ă���
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram���̒񋟂���ݒ����C���N���[�h (�ʃt�@�C��:vimrc_example.vim)�B����
" �ȑO��g:no_vimrc_example�ɔ�0�Ȓl��ݒ肵�Ă����΃C���N���[�h�͂��Ȃ��B
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  source $VIMRUNTIME/vimrc_example.vim
endif

"---------------------------------------------------------------------------
" �����̋����Ɋւ���ݒ�:
"
" �������ɑ啶���������𖳎� (noignorecase:�������Ȃ�)
set ignorecase
" �啶���������̗������܂܂�Ă���ꍇ�͑啶�������������
set smartcase

"---------------------------------------------------------------------------
" �ҏW�Ɋւ���ݒ�:
"
" �^�u�̉�ʏ�ł̕�
set tabstop=8
" �^�u���X�y�[�X�ɓW�J���Ȃ� (expandtab:�W�J����)
set noexpandtab
" �����I�ɃC���f���g���� (noautoindent:�C���f���g���Ȃ�)
set autoindent
" �o�b�N�X�y�[�X�ŃC���f���g����s���폜�ł���悤�ɂ���
set backspace=2
" �������Ƀt�@�C���̍Ō�܂ōs������ŏ��ɖ߂� (nowrapscan:�߂�Ȃ�)
set wrapscan
" ���ʓ��͎��ɑΉ����銇�ʂ�\�� (noshowmatch:�\�����Ȃ�)
set showmatch
" �R�}���h���C���⊮����Ƃ��ɋ������ꂽ���̂��g��(�Q�� :help wildmenu)
set wildmenu
" �e�L�X�g�}�����̎����܂�Ԃ�����{��ɑΉ�������
set formatoptions+=mM
" ���{�ꐮ�`�X�N���v�g(by. ������m����)�p�̐ݒ�
let format_allow_over_tw = 1	" �Ԃ牺��\��

"---------------------------------------------------------------------------
" GUI�ŗL�ł͂Ȃ���ʕ\���̐ݒ�:
"
" �s�ԍ����\�� (number:�\��)
set nonumber
" ���[���[��\�� (noruler:��\��)
set ruler
" �^�u����s��\�� (list:�\��)
set nolist
" �ǂ̕����Ń^�u����s��\�����邩��ݒ�
"set listchars=tab:>-,extends:<,trail:-,eol:<
" �����s��܂�Ԃ��ĕ\�� (nowrap:�܂�Ԃ��Ȃ�)
set wrap
" ��ɃX�e�[�^�X�s��\�� (�ڍׂ�:he laststatus)
set laststatus=2
" �R�}���h���C���̍��� (Windows�pgvim�g�p����gvimrc��ҏW���邱��)
set cmdheight=2
" �R�}���h���X�e�[�^�X�s�ɕ\��
set showcmd
" �^�C�g����\��
set title
" ��ʂ����n�ɔ��ɂ��� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"colorscheme evening " (Windows�pgvim�g�p����gvimrc��ҏW���邱��)

"---------------------------------------------------------------------------
" �t�@�C������Ɋւ���ݒ�:
"
" �o�b�N�A�b�v�t�@�C�����쐬���Ȃ� (���s�̐擪�� " ���폜����ΗL���ɂȂ�)
"set nobackup


"---------------------------------------------------------------------------
" �t�@�C�����ɑ啶���������̋�ʂ��Ȃ��V�X�e���p�̐ݒ�:
"   (��: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tags�t�@�C���̏d���h�~
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" �R���\�[���ł̃J���[�\���̂��߂̐ݒ�(�b��I��UNIX��p)
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
" �R���\�[���łŊ��ϐ�$DISPLAY���ݒ肳��Ă���ƋN�����x���Ȃ錏�֑Ή�
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" �v���b�g�z�[���ˑ��̓��ʂȐݒ�

" Win�ł�PATH��$VIM���܂܂�Ă��Ȃ��Ƃ���exe�������o���Ȃ��̂ŏC��
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Mac�ł̓f�t�H���g��'iskeyword'��cp932�ɑΉ�������Ă��Ȃ��̂ŏC��
  set iskeyword=@,48-57,_,128-167,224-235
endif

" Copyright (C) 2003 KaoriYa/MURAOKA Taro

""""" my config start """"
set clipboard=unnamed 
" �L�[�o�C���h�ύX

" ������ emacs ��������
"map <C-s> /
" �r�W���A�����[�h�̂Ƃ���
"vnoremap <C-S> y:%s/<C-R>"//g<Left><Left>

" �C���T�[�g���[�h�� emacs ���ۂ�
" ��
inoremap <C-B> <left>
" ��
inoremap <C-F> <right>
" ��
inoremap <C-P> <up>
" ��
inoremap <C-N> <down>
" �s��
inoremap <C-A> <Home>
" �s��
inoremap <C-E> <End>
" �ꕶ���폜
inoremap <C-D> <DEL>

" �J�[�\���s�𒆉��ɕ\��
inoremap <C-L> <C-O>zz

" ���������[�h�⊮
inoremap <C-J> <C-N>
" �t�������[�h�⊮
inoremap <C-K> <C-P>

" �J�[�\���̉��̍s�̓����ʒu�̕�����}��
inoremap <C-U> <C-E>

" �J�[�\���̉��̍s�̓����ʒu�̕�����}��
inoremap <Down> <C-e>
" �J�[�\���̏�̍s�̓����ʒu�̕�����}��
inoremap <UP> <C-y>

" ���������[�h�⊮(Tab)
"inoremap <C-I> <C-N>
" �t�������[�h�⊮
"inoremap <S-Tab> <C-P>
" �s���܂ō폜
"inoremap <C-K> <C-O>D
" �y�[�X�g
"inoremap <C-Y> <C-O>p

" �R�}���h���[�h�� emacs ���ۂ�
" �s���ֈړ�
cnoremap <C-a> <Home>
" �ꕶ���߂�
cnoremap <C-b> <Left>
" �J�[�\���̉��̕������폜
cnoremap <C-d> <Del>
" �s���ֈړ�
cnoremap <C-e> <End>
" �ꕶ���i��
cnoremap <C-f> <Right>
" �R�}���h���C����������i��
cnoremap <C-n> <Down>
" �R�}���h���C����������߂�
cnoremap <C-p> <Up>
" �O�̒P��ֈړ�
cnoremap <Esc><C-b> <S-Left>
" ���̒P��ֈړ�
cnoremap <Esc><C-f> <S-Right>
"" ���O�̃����N�����ꕗ�Ƀy�[�X�g
"cnoremap <C-y> <C-r>"
" �R�}���h���C��������\�� 
cnoremap <C-y>	<C-f>
" �R�}���h�⊮
"cnoremap <Tab>	      <C-L>
" �t�@�C���p�X�̃y�[�X�g(KoRoN����̌f�����q��)
cnoremap <C-x> <C-r>=expand('%:p:h')<CR>/
"" �J�[�\���̏�̒P����y�[�X�g
"cnoremap <C-@> <C-r><C-w>
"" �t�@�C�������y�[�X�g(���܂����Ȃ�����)
"cnoremap <C-o> <C-r>%
" ^K �ƕ\�������̂��ז��Ȃ̂� Del �ɕύX
cnoremap <C-k> <Del>
" ^G �ƕ\�������̂��ז��Ȃ̂� ESC �ɕύX
cnoremap <C-g> <ESC>
"" �Ȃ��� <C-h> �� Del �ɂȂ��Ă���̂� BS �ɕύX
"cnoremap <C-h> <BS>

" �܂�Ԃ��\���s����ʂ̍s�P�ʂňړ�
"nnoremap j gj
"nnoremap k gk

" C-L �Ńn�C���C�g������
nnoremap <C-L>	:noh<CR>:redraw<CR>

nnoremap Y	y$

" ��������ݒ� config

" �o�b�N�A�b�v�t�@�C������ӏ��ɍ쐬
"set backupdir=>c:\home\sugi\tmp
set     backupdir=>$TMP
" �X���b�v�t�@�C������ӏ��ɍ쐬
"set directory=>c:\home\sugi\tmp
set     directory=>$TMP

" Chalice �̐ݒ�
set runtimepath+=$VIM/chalice

" �N���b�v�{�[�h�Ɩ��O�Ȃ����W�X�^�𓯊�
"set clipboard=unnamed 


" �C���N�������^���T�[�`���g��
set incsearch

set listchars=tab:\ \ 
set list

" �m�F�_�C�A���O���o��
set confirm

" auto date �̃t�H�[�}�b�g
"let autodate_format = '%d %3m. %Y %H:%M'
let autodate_format = '%d %3m. %Y'

"���������āA��ʃt���b�V��
set visualbell

" �f�t�H���g�^�u���̐ݒ�
set tabstop=4
set sw=4

" �B���o�b�t�@���g��
"set hidden

" fold ���[�h�ݒ�
set foldmethod=marker

" ~(�`���_)�� operator ����
"set tildeop

" HTML �Ń^�O��啶���ɂ���R�}���h
command! -nargs=? -range=% ToUpperHtml :<line1>,<line2>substitute/<\l\+\|\/\l\+>/\U&/g<args>

command! -nargs=? Tab :set listchars=tab:>-,extends:<,trail:-,eol:<
command! -nargs=? NoTab :set listchars=tab:

set keymap=tutcodes
