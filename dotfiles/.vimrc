"----------------
"基本設定
"----------------
syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set noswapfile
set hlsearch
set incsearch
"set pythonthreedll=/Users/mitsuhiro/.pyenv/versions/anaconda3-4.3.1/lib/libpython3.6m.dylib
nnoremap <F3> :noh<CR>
nnoremap / /\v
nnoremap ? ?\v
nnoremap pdb :!python -m pdb %<CR>
"let $PYTHONHOME='/Users/mitsuhiro/.pyenv/versions/anaconda3-4.3.1'
"----------------

"--------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"

" NERETreeを設定
NeoBundle 'scrooloose/nerdtree'

" jedi-vimを設定
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Shougo/neocomplete.vim'

" flake8 文法チェックプラグイン
NeoBundle 'nvie/vim-flake8'

" pep-indent 補完するプラグイン
NeoBundle 'hynek/vim-python-pep8-indent'

" vim-autoclose クオート/括弧の対を自動入力する
NeoBundle 'Townk/vim-autoclose'

" syntastic 構文チェッカー
NeoBundle 'scrooloose/syntastic'

"html/CSS入力補助プラグイン
NeoBundle 'mattn/emmet-vim'
NeoBundle 'open-browser.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
NeoBundle 'othree/html5.vim'
NeoBundle 'bronson/vim-trailing-whitespace'

"色テーマ
NeoBundle 'sjl/badwolf'
" molokai
NeoBundle 'tomasr/molokai'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

"-----------------------
" jedi-vim Setting
"-----------------------

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"------------------------
" End jedi-vim Setting
"------------------------

"------------------------------------
" emmet-vim
"------------------------------------
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_settings = {
    \    'variables': {
    \      'lang': "ja"
    \    },
    \   'indentation': '  '
    \ }
"-------------------------------------

"-------------------------------------
"NERDTree
"-------------------------------------
autocmd VimEnter * execute 'NERDTree'
let NERDTreeShowHidden = 1
"-------------------------------------


"-------------------------------------------------------
" vim-trailing-whitespace
"--------------------------------------------------------

if neobundle#tap('vim-trailing-whitespace')
    " uniteでスペースが表示されるので、設定でOFFにします。
    let g:extra_whitespace_ignored_filetypes = ['NERDTree']
endif

"--------------------------------------------------------

"-----------------------------------
"lightlineの設定
"-----------------------------------
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }
"-----------------------------------

"-----------------------------------
" open-browser 設定
" ----------------------------------
" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)
"------------------------------------

"-----------------------------------
"vim-browsereload-macの設定
"-----------------------------------
"-----------------------------------

"----------------------
" flake8 の設定
" ---------------------
"
"----------------------
