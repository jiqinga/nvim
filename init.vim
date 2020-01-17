"关闭文件类型检测,vundle必须关闭 <https://blog.easwy.com/archives/advanced-vim-skills-filetype-on/>
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
let &t_ut=''
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Plugin 'fatih/vim-go'
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'
Plugin 'davidhalter/jedi-vim'
"彩虹括号
Plugin 'luochen1990/rainbow'
 let g:rainbow_active = 1

Plugin 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']

"html使用 CTRL + e
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"ansible插件
Plugin 'pearofducks/ansible-vim'
"与stephpy/vim-yaml提供兼容性
let g:ansible_yamlKeyName = 'yamlKey'
let g:ansible_attribute_highlight = "ab"
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
"au BufRead,BufNewFile emano.yml set filetype=yaml.ansible
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile /etc/ansible/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile /etc/ansible/*.yaml set filetype=yaml.ansible
"定义文件类型,使用coc-docker补全
au BufRead,BufNewFile *.dockerfile set filetype=dockerfile
au BufRead,BufNewFile *-dockerfile set filetype=dockerfile

""缩进
Plugin 'yggdroot/indentline'
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"vim状态栏
Plugin 'vim-airline/vim-airline'
"这个是安装字体后 必须设置此项" 
if has('gui_running')
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
endif
"buffers栏
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
"设置切换Buffer快捷键"
"nnoremap <LEADER>a  :bn<CR>
"nnoremap <LEADER>b :bp<CR>
"主题 let g:airline_theme='molokai' 

"vim主题,美化
Plugin 'vim-airline/vim-airline-themes'

"vim文件导航
Plugin 'scrooloose/nerdtree'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"当NERDTree为剩下的唯一窗口时自动关闭"
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"修改树的显示图标
"let g:NERDTreeDirArrowExpandable = '►'
"let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1
"显示行号
 let NERDTreeShowLineNumbers=1
" 设置宽度
 let NERDTreeWinSize=25
"窗口位置
let g:NERDTreeWinPos='left' 
"是否显示隐藏文件
 let NERDTreeShowHidden=1"
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
map <C-]> :NERDTreeToggle<CR>
map <silent> <F5> :NERDTreeToggle<CR>
"autocmd vimenter * NERDTree
Plugin 'xuyuanp/nerdtree-git-plugin'
"显示树符号
let g:NERDTreeShowIgnoredStatus = 1

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<F6>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'find %s -type f' 
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
"忽略项
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
"帮助:help ctrlp-mappings
"vim标签栏
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Plugin 'prabirshrestha/vim-lsp'

Plugin 'neoclide/coc.nvim'
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=1000
set shortmess+=c
set signcolumn=yes
set timeoutlen=100
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Plugin 'valloric/youcompleteme'

"显示单词下划线
Plugin 'itchyny/vim-cursorword'

"css,html颜色预览
Plugin 'gko/vim-coloresque'

"python语法高亮
Plugin 'vim-python/python-syntax'
let g:python_highlight_all = 1

"成对插入括号
Plugin 'jiangmiao/auto-pairs'

"成对删除替换括号
Plugin 'tpope/vim-surround'
"ds' 删除此行单引号 可以用可视模式
"cs'" 把此行单引号替换为双引号,可以加入空格
"ysiw]  把这个单词用[]括起来
"yss[    把整行用[]括起来

"文本对齐
Plugin 'godlygeek/tabular'
":Tab /=/r1c1   空格对齐,空格左边右对齐
"依赖
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'kana/vim-textobj-user'
Plugin 'fadein/vim-figlet'
call vundle#end()            " required
filetype plugin indent on    " required

"如果不存在家目录下的test.txt,就cp/tmp/test.txt到~/test.txt,并soure文件
"let test_file = 1
"if empty(glob('~/test.txt'))
"    let test_file = 0
"      exec "!cp /tmp/test.txt ~/test.txt"
"    endif
"source ~/.vim/_machine_specific.vim
"如果执行了上面的cp,就打开这个文件
"if has_machine_specific_file == 0
"  exec "e ~/test.txt"
"  endif""

"python补全
filetype plugin on
"let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
"设置编码
set fileencodings=UTF-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=UTF-8
set encoding=UTF-8

"设置中文帮助文档,需下载中文手册
set helplang=cn

"共享剪切板
set clipboard=unnamed

"显示行号,显示相对行号
"set number
"set relativenumber

"突出显示当行
"set cursorline

"显示输入命令
set showcmd

"总是显示状态栏
set laststatus=2
"使用xshell连接vim显示Vim-airline色彩
set t_Co=256
set formatoptions-=tc

"vim中:补全设置
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

"显示搜索高亮
set hlsearch
" 因为上次搜索的内容在关闭vim后，重新打开，此句执行后将取消之前搜索的高亮。
exec "nohlsearch"
"搜索结果
noremap n nzz
noremap N Nzz

"历史指令记录
set history=500

"把dd映射为q
"nnoremap  q  dd

"括号自动补全
"inoremap ( ()<Esc>i
"inoremap [ []<Esc>i
"inoremap { {}<Esc>i
"inoremap " ""<Esc>i
nmap vv <C-v>
nmap rr <C-r>
"启用鼠标
"set mouse=a
set selection=exclusive
set selectmode=mouse,key

"显示括号匹配
set showmatch

"设置tab长度为4
set expandtab
set tabstop=2

"设置自动缩进长度为2
set shiftwidth=2
set softtabstop=2

"背景主题切换
map <LEADER>c1 :set background=dark<CR>:colorscheme snazzy<CR>:AirlineTheme dracula<CR>
map <LEADER>c2 :set background=light<CR>:colorscheme ayu<CR>:AirlineTheme ayu_light<CR>

"把tab显示为括号
set list
set listchars=tab:▸\ ,trail:▫

"光标移动到顶部和底部时保持5行距离
set scrolloff=5

"长行自动显示折行
set wrap
set tw=0

"继承前一行的缩进方式
"set autoindent

"使回车键能正常处理indent,eol,start
set backspace=indent,eol,start

"设置vim补全字典
"set dictionary=/usr/share/dict/keywords.txt

"分屏窗口设置
set splitright
set splitbelow
"语法高亮
syntax enable
syntax on

"显示行号和列号(默认打开)
set ruler

set complete-=k complete+=k
"搜索时忽略大小写
set ignorecase

" 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果。
set incsearch
"记住上一次光标退出位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif""""")""")""")
"把mapleader映射为空格键
let mapleader=" "
"把:映射为;
 map ; :
"把q:映射为\q
 map \q q:
"输入空格/就等于:!  如空格/ls,就是在vim中执行ls
 map <LEADER>/ :!
"输入空格r就等于:r !  如空格rls,就是把ls的输出读取进来
 map <LEADER>r :r !
map <LEADER>sr :%s///g
"把:q映射为Q,<CR>是回车的意思,Q直接退出vim
 map Q :q<CR>
map R :call VIM_reload()<CR>
func! VIM_reload()
  exec "w"
  if &filetype == 'vim'
    exec "source ~/.vimrc"
  elseif &filetype == 'markdown'
    exec "echo"
  endif
endfunc
":e file 关闭当前编辑的文件,编辑file文件
" map <LEADER>rc :e ~/.vim/vimrc<CR>"

":map j gg   // gg被映射微j键
":map Q j  // j又被递归映射微Q键，也就是 gg被映射为Q键
":noremap w j  //j被映射为w键，但是gg没有被映射为w键  因为前面又nore 也就是no-recursively非递归
"inoremap就只在插入(insert)模式下生效
"vnoremap只在visual模式下生效)
"noremap只在普通模式下生效
"禁用默认s键
noremap s <nop>
"将屏幕上下分屏,su默认操作上方,se默认操作下方
"map su :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map se :set splitbelow<CR>:split<CR>
"将屏幕左右分屏,sn默认操作左方,si默认操作右方
"map sn :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map si :set splitright<CR>:vsplit<CR>
" 如果同时开启set ignorecase，那么对只有一个大写字母的搜索词，将大小写敏感，其他情况都是大小写不敏感。如搜Test时，将不匹配test;搜test时，将匹配Test.
set smartcase

autocmd BufNewFile *.py,*.sh exec ":call SetTitle()"
func SetTitle()
    if &filetype == 'sh'
        call setline(1, "#!/bin/bash")
        call setline(2, "#Author:liuml")
        call setline(3, "#Blog:https://jiqinga.github.io")
        call setline(4, "#Time:".strftime("%F %T"))
        call setline(5, "#Name:".expand("%"))
    endif
    if &filetype == 'python'
        call setline(1, "#!/usr/bin/python")
		    call setline(2, "# encoding: utf-8")
        call setline(3, "#Author:liuml")
        call setline(4, "#Time:".strftime("%F %T"))
        call setline(5, "#Name:".expand("%"))
    endif
	normal G
	normal o
endfunc
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'go'
    :GoRun %
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    silent! exec "!clear"
    exec "!time python3 %"
  endif
endfunc
"书呆子树颜色
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yaml', 'green', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('sh', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('tar', 'Red', 'none', 'red', '#151515')
"设置文件为当前路径
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
set autochdir
"彩虹括号
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}
"自定义补全
"autocmd FileType dockerfile set dictionary+=~/.vim/dict/dockerfile.dict
"function! InserTabWrapper()
"        let col=col('.')-1
"        if !col || getline('.')[col-1] !~ '\k'
"                return "\<TAB>"
"        else
"                return "\<C-N>"
"        endif
"endfunction
"inoremap <TAB> <C-R>=InserTabWrapper()<CR>
autocmd FileType json syntax match Comment +\/\/.\+$+
