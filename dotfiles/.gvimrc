set transparency=0   " 透明度
set guioptions-=T    " ツールバー非表示
set antialias        " アンチエイリアス
"set tabstop=4        " タブサイズ
set number           " 行番号表示
set nobackup         " バックアップなし
set visualbell t_vb= " ビープ音なし

"カラースキーマ
let g:molokai_original = 0
set t_Co=256
colorscheme molokai
"colorscheme badwolf   " カラースキーマ

set columns=100      " 横幅
set lines=35         " 行数

set nowrapscan       " 検索をファイルの先頭へループしない

" フォント設定
set guifont=Osaka-Mono:h18

" 自動的に日本語入力(IM)をオンにする機能を
set imdisable
