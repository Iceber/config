colorscheme ron " 修改配色
set number " 显示行号
set tabstop=4 " 要计算的空格数
set expandtab " 将Tab展开为空格
" set softtabstop=4 " 将四个space理解为Tab,可以被BS一起删除
set autoindent " 新行自动缩进
set smartindent " 只能缩进

" 行号的宽度
" set numberwidth=6 
" 关闭行号
" set nonumber

" 显示状态栏
set laststatus=2

set shiftwidth=4 "自动缩进的空格数
set wildmenu " 增强 tab

set ruler
set ignorecase smartcase " 查找时忽略大小写的
set hlsearch
set incsearch " 未输入完整搜索字符时，就开始匹配

" 命令行的高度
" set cmdheight=2

" 显示匹配的扩号
" set showmatch

set backspace=2 " 修正退格键Backspace行为
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1

syntax enable
syntax on " 支持语法高亮
filetype indent plugin on " 启用根据文件类型自动缩进


" set mouse=a

" vinegar 配置这些可以不使用vinegar
let g:netrw_winsize = 25
" 隐藏横幅
let g:netrw_banner = 0
" 列表样式，可以再netrw中 i 修改
let g:netrw_liststyle = 3
nnoremap _ :Ve<CR>
nnoremap - :E<CR>
nnoremap <C-q> :bd<CR>

" 从寄存器中复制系统粘贴板
nnoremap P <ESC>"*p


au FileType yaml setlocal ai ts=2 sw=2 et

set foldmethod=indent
set foldlevel=99
nnoremap <space> za
set encoding=utf-8

imap <C-n> <C-x><C-o>

execute pathogen#infect()

" black
" let g:black_linelength = 79
autocmd BufWritePost *.py execute ':Black'

" ale
let g:ale_echo_msg_error_str = 'ERROR'
let g:ale_echo_msg_warning_str = 'WARN'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
nmap <C-j> <Plug>(ale_next_wrap)
nmap <C-k> <Plug>(ale_previous_wrap)
let g:ale_linters = {
\   'python': ['mypy', 'flake8'],
\}
let g:ale_python_mypy_options='--ignore-missing-imports'

" ctrlp.vim auto open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | CtrlPCurFile | endif
" ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" let g:ctrlp_working_path_mode = 'ra'


" Tagbar
au FileType go nmap <C-t> :TagbarToggle<CR>

let g:go_def_reuse_buffer = 0
let g:go_def_mapping_enabled = 0
" let g:go_highlight_fields = 1
" let g:go_highlight_types = 1
" let g:go_highlight_function_calls = 1
" let g:go_fmt_command = "goimports"
" 自动高亮变量
" let g:go_auto_sameids = 1
" let g:go_auto_type_info = 1


au FileType go nmap <C-i> <Plug>(go-imports)
au FileType go nmap <C-]> <Plug>(go-def-vertical)
au FileType go nmap <C-d> <Plug>(go-doc-split)
" au FileType go nmap <C-[> <Plug>(go-def-pop)
" au FileType go nmap <C-c> <Plug>(go-callers)

if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
            \ 'name': 'go-langserver',
            \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
            \ 'whitelist': ['go'],
            \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

function! JsonFormat()
    let @a = system("python -m json.tool " . bufname("%"))
    if v:shell_error
        echom @a
    else
        %delete
        normal! "ap
        1delete
    endif
endfunction

function! DecodeBase64()
    let @a = system("base64 -D -i " . bufname("%"))
    if v:shell_error
        echom @a
    else
        %delete
        normal! "ap
        1delete
    endif
endfunction

command! Db64 call DecodeBase64()

autocmd BufWritePost *.json call JsonFormat()
