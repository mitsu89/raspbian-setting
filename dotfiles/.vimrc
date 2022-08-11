" 読み込み時の文字コード設定
set encoding=utf-8
" Vim Script内でマルチバイトを扱うための設定
scriptencoding utf-8
syntax on
"------------------------------------------------------------------------------
" dein
"------------------------------------------------------------------------------
let s:dein_dir=expand('$HOME/.cache/dein')
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimがない場合githubからDL
if &runtimepath !~# 'dein.vim'
    if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    " 設定開始
    call dein#begin(s:dein_dir)

    " プラグインリスト(toml)
    let g:rc_dir=expand('~/.vim/rc')
    if !isdirectory(g:rc_dir)
        call mkdir(g:rc_dir, 'p')
    endif
    " 起動時に読み込むプラグイン群
    let s:toml=g:rc_dir . '/plugins.toml'
    call dein#load_toml(s:toml, {'lazy':0})
    " 遅延読み込みしたいプラグイン群
    let s:lazy_toml=g:rc_dir . '/lazy_plugins.toml'
    call dein#load_toml(s:lazy_toml, {'lazy':1})

    " 設定終了
    call dein#end()
    call dein#save_state()
endif
" Required:
filetype plugin indent on
" 未インストールがあればインストール
if dein#check_install()
    call dein#install()
endif
" tomlファイルからプラグインが削除されていればプラグイン本体も削除
let s:removed_plugins=dein#check_clean()
if len(s:removed_plugins) > 0
    call map(s:removed_plugins, 'delete(v:val, "rf")')
    call dein#recache_runtimepath()
endif


"------------------------------------------------------------------------------
" カラースキーム
"------------------------------------------------------------------------------
" iTerm2など既に256色環境なら無くても良い
set t_Co=256
" 構文に色を付ける
syntax enable


"------------------------------------------------------------------------------
" ファイル文字
"------------------------------------------------------------------------------
" 保存時の文字コード
set fileencoding=utf-8
" 読み込み時の文字コードの自動判別(左側が優先)
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 改行コードの自動判別(左側が優先)
set fileformats=unix,dos,mac
" □や○文字が崩れる問題を解決
set ambiwidth=double


"------------------------------------------------------------------------------
" ステータスライン
"------------------------------------------------------------------------------
" ステータスラインを常に表示
set laststatus=2
" 現在のモードを表示
set showmode
" 打ったコマンドをステータスラインの下に表示
set showcmd
" ステータスラインの右側にカーソルの位置を表示
set ruler


"------------------------------------------------------------------------------
" コマンドモード
"------------------------------------------------------------------------------
" コマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数
set history=5000


"------------------------------------------------------------------------------
" タブ・インデント
"------------------------------------------------------------------------------
let s:tab_width=4

" タブ入力を複数の空白入力に置き換える
set expandtab
" 画面上でタブ文字が占める幅
let &tabstop=s:tab_width
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
let &softtabstop=s:tab_width
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" smartindentで増減する幅
let &shiftwidth=s:tab_width


"------------------------------------------------------------------------------
" 文字列検索
"------------------------------------------------------------------------------
" インクリメンタルサーチ(1文字入力毎に検索を行う)
set incsearch
" 検索パターンに大文字小文字を区別しない
set ignorecase
" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
" 検索結果をハイライト
set hlsearch

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


"------------------------------------------------------------------------------
" カーソル
"------------------------------------------------------------------------------
" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~
" 行番号を表示
set number
" カーソルラインをハイライト
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
highlight CursorLine gui=underline guifg=NONE guibg=NONE

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start

" カーソルの位置記憶
augroup vimrcEx
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line('$') |
        \   exe "normal! g`\"" |
        \ endif
augroup END


"------------------------------------------------------------------------------
" カッコ・タグの対応
"------------------------------------------------------------------------------
" 括弧の対応関係を一瞬表示する
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim


"------------------------------------------------------------------------------
" マウスでカーソル移動とスクロール
"------------------------------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif


"------------------------------------------------------------------------------
" クリップボードからのペースト
"------------------------------------------------------------------------------
set clipboard=unnamedplus
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないように
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"------------------------------------------------------------------------------
" ファイル管理
"------------------------------------------------------------------------------
" バックアップファイルやスワップファイルを作成しない
set nowritebackup
set nobackup
set noswapfile


"------------------------------------------------------------------------------
" 表示関係
"------------------------------------------------------------------------------
" 不可視文字の可視化
set list
" 長いテキストの折り返し
set wrap
"80文字目にラインを入れる
"set colorcolumn=80
" スクリーンベルの無効化
set t_vb=
set novisualbell
" 不可視文字をUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲


"------------------------------------------------------------------------------
" マクロおよびキー設定
"------------------------------------------------------------------------------
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
" 検索語にジャンプした検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" vを二回で行末まで選択
vnoremap v $h
" TABで対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %


"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1

" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']
" Python用. 構文エラーチェックにFlake8を使用
let g:syntastic_python_checkers = ['flake8']
" Javascript以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript', 'python'],
                           \ 'passive_filetypes': [] }

" *******************************************************
" jedi↲
" *******************************************************
"let g:jedi#popup_on_dot = 1
"let g:jedi#popup_select_first = 0
"let g:jedi#completions_command = "<S-Tab>"
"autocmd FileType python setlocal completeopt-=preview
"autocmd FileType python omnifunc=jedi#completions

"----------------------------------------------------------
" syntastic
"----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"----------------------------------------------------------
" flake8
"----------------------------------------------------------
let g:syntastic_python_checkers = ["flake8"]

" *******************************************************↲
" NERDTree↲
" *******************************************************↲
"不可視ファイルの表示↲
let g:NERDTreeShowHidden=1
" ブックマーク初期表示↲
"let g:NERDTreeShowBookmarks=1↲
"let g:NERDTreeChDirMode=2
" windowサイズ設定↲
let g:NERDTreeWinSize=30
" 表示したくないファイル、ディレクトリ↲
"let g:NERDTreeIgnore=['\.DS_Store$']
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" vim起動時に常に表示↲
"autocmd vimenter * NERDTree↲
" NERDTreeだけが残る場合はvim終了↲
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif↲
 "MacVimで使っていた最初の設定↲
"map <C-e> :NERDTreeToggle<CR>
"autocmd VimEnter * execute 'NERDTree'↲

"------------------------------------------------------------------------------
" カラースキーム編集用
"------------------------------------------------------------------------------
" ハイライトグループを知るコマンド:SyntaxInfoを実装
function! s:get_syn_id(transparent)
    let synid = synID(line("."), col("."), 1)
    if a:transparent
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction
function! s:get_syn_attr(synid)
    let name = synIDattr(a:synid, "name")
    let ctermfg = synIDattr(a:synid, "fg", "cterm")
    let ctermbg = synIDattr(a:synid, "bg", "cterm")
    let guifg = synIDattr(a:synid, "fg", "gui")
    let guibg = synIDattr(a:synid, "bg", "gui")
    return {"name": name,
          \ "ctermfg": ctermfg,
          \ "ctermbg": ctermbg,
          \ "guifg": guifg,
          \ "guibg": guibg}
endfunction
function! s:get_syn_info()
    let baseSyn = s:get_syn_attr(s:get_syn_id(0))
    echo "name: " . baseSyn.name .
       \ " ctermfg: " . baseSyn.ctermfg .
       \ " ctermbg: " . baseSyn.ctermbg .
       \ " guifg: " . baseSyn.guifg .
       \ " guibg: " . baseSyn.guibg
    let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
    echo "link to"
    echo "name: " . linkedSyn.name .
       \ " ctermfg: " . linkedSyn.ctermfg .
       \ " ctermbg: " . linkedSyn.ctermbg .
       \ " guifg: " . linkedSyn.guifg .
       \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"----------------------------------------------
"emmet-vim
"----------------------------------------------
let g:user_emmet_leader_key='<c-a>'
let g:user_emmet_settings = {
    \   'variables': {
    \       'lang': "ja"
    \    },
    \   'indentation': ' '
    \}

"----------------------------------------------
"ddc.vim 設定
"----------------------------------------------
"call ddc#custom#patch_global('completionMenu', 'pum.vim')
"call ddc#custom#patch_global('sources', [
" \ 'around',
" \ 'vim-lsp',
" \ 'file'
" \ ])
"call ddc#custom#patch_global('sourceOptions', {
" \ '_': {
" \   'matchers': ['matcher_head'],
" \   'sorters': ['sorter_rank'],
" \   'converters': ['converter_remove_overlap'],
" \ },
" \ 'around': {'mark': 'Around'},
" \ 'vim-lsp': {
" \   'mark': 'LSP',
" \   'matchers': ['matcher_head'],
" \   'forceCompletionPattern': '\.|:|->|"\w+/*'
" \ },
" \ 'file': {
" \   'mark': 'file',
" \   'isVolatile': v:true,
" \   'forceCompletionPattern': '\S/\S*'
" \ }})
"call ddc#enable()
"inoremap <Tab> <Cmd>call pum#map#insert_relative(+1)<CR>
"inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
