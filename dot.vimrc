" == initialization ==
set nocompatible
language messages C

filetype off

if has('vim_starting')
  set runtimepath+=~/.neobundle/neobundle.vim
  call neobundle#rc(expand('~/.neobundle'))
endif

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/kana/vim-smartchr.git'
NeoBundle 'git://github.com/tsukkee/unite-help.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'git://github.com/tyru/open-browser.vim.git'
NeoBundle 'git://github.com/basyura/twibill.vim.git'
NeoBundle 'git://github.com/basyura/TweetVim.git'
NeoBundle 'git://github.com/h1mesuke/unite-outline.git'

filetype plugin indent on


" == utilities ==
function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction


" == encoding ==
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,euc-jp,cp932

" no Japanese word in a buffer
augroup vimrc-fenc
  autocmd!
  autocmd BufReadPost *
  \ if &modifiable && !search('[^\x00-\x7F]', 'cnw') |
  \   setlocal fileencoding=utf-8 |
  \ endif
augroup END

set ambiwidth=double

command! -bang -bar -complete=file -nargs=? Utf8
\ edit<bang> ++encoding=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Cp932
\ edit<bang> ++encoding=cp932 <args>
command! -bang -bar -complete=file -nargs=? Eucjp
\ edit<bang> ++encoding=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
\ edit<bang> ++encoding=iso-2022-jp <args>

command! Jis Iso2022jp
command! Sjis Cp932

set fileformat=unix
set fileformats=unix,dos,mac

command! -bang -bar -complete=file -nargs=? Unix
\ edit<bang> ++fileformat=unix <args>
command! -bang -bar -complete=file -nargs=? Dos
\ edit<bang> ++fileformat=dos <args>
command! -bang -bar -complete=file -nargs=? Mac
\ edit<bang> ++fileformat=mac <args>


" == appearance ==
syntax enable

highlight Statusline cterm=none ctermbg=darkgray ctermfg=lightgray
highlight StatuslineNC cterm=none ctermbg=lightgray ctermfg=darkgray

set shortmess& shortmess+=I
set visualbell t_vb=
set number ruler
set list listchars=tab:>-,trail:-
set matchpairs& matchpairs+=<:>
set laststatus=2
set statusline=%m%r%y\ %t\ [%{&fileencoding}:%{&fileformat}]%=%l/%4L,%3c
set cmdheight=1 showcmd showmode
set showtabline=2
set nowrap


" == behavior ==
"set nobackup nowritebackup noswapfile
"set updatetime=4000
"augroup vimrc-autosave
"  autocmd!
"  autocmd CursorHold *
"  \ if &modifiable && bufname("%") !=# "" | silent update | endif
"augroup END
set backup
set backupdir=~/.vimbackup
set backupcopy=yes
set swapfile
let &directory = &backupdir

set ignorecase smartcase hlsearch noincsearch nowrapscan
nohlsearch

set noequalalways splitbelow splitright

set autoread hidden nostartofline scrolloff=3
set backspace=indent,eol,start
set clipboard& clipboard+=unnamed


" == indent ==
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround
set expandtab shiftround autoindent smartindent

augroup vimrc-ftindent
  autocmd!
  autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" == commands ==
command! -nargs=1 -complete=file Rename
  \ file <args> | call delete(expand('#'))
command! -nargs=1 -complete=option Toggle setlocal <args>! <args>?
command! -bar RTP echo substitute(&runtimepath, ',', "\n", 'g')

augroup vimrc-autotrim
  autocmd!
  autocmd InsertLeave * if &modifiable | %s/\s\+$//eg | endif
augroup END


" == key mappings ==
set timeout timeoutlen=2000 ttimeoutlen=100

noremap q <Nop>
noremap ZZ <Nop>
noremap ZQ <Nop>

nnoremap Y y$
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

nnoremap <C-h> :<C-u>help<Space>
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>
augroup vimrc-helpclose
  autocmd!
  autocmd FileType help call s:help_config()
augroup END
function! s:help_config()
  nnoremap <buffer><silent> q :<C-u>close<CR>
endfunction

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

noremap <C-j> <Esc>
inoremap <C-j> <Esc>
cnoremap <C-j> <C-c>

nmap <Space> [space]
nnoremap [space] <Nop>

nnoremap <silent> [space], :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [space]. :<C-u>source $MYVIMRC<CR>

nnoremap <silent> [space]w :<C-u>write<CR>
nnoremap <silent> [space]fw :<C-u>write!<CR>
nnoremap <silent> [space]q :<C-u>quit<CR>
nnoremap <silent> [space]fq :<C-u>quit!<CR>
nnoremap <silent> [space]aq :<C-u>quitall!<CR>

nnoremap [space]t :<C-u>Toggle<Space>

noremap J <C-f>
noremap K <C-b>
noremap H ^
noremap L $
noremap f w

" select the last modified area
nnoremap gm `[v`]
vnoremap gm :<C-u>normal gm<CR>
onoremap gm :<C-u>normal gm<CR>

vnoremap pp %
onoremap pp %
vnoremap ) t)
onoremap ) t)
vnoremap ] t]
onoremap ] t]
vnoremap } t}
onoremap } t}
"vnoremap > t>
onoremap > t>
vnoremap ' t'
onoremap ' t'
vnoremap " t"
onoremap " t"

nmap w [window]
nnoremap [window] <Nop>
nnoremap [window]s :<C-u>split<Space>
nnoremap [window]n :<C-u>split<Space>
nnoremap [window]v :<C-u>vsplit<Space>
nnoremap <silent> [window]c :<C-u>close<CR>
nnoremap <silent> [window]o :<C-u>only<CR>
nnoremap <silent> [window]j <C-w><C-j>
nnoremap <silent> [window]k <C-w><C-k>
nnoremap <silent> [window]h <C-w><C-h>
nnoremap <silent> [window]l <C-w><C-l>
nnoremap <silent> [window]w <C-w><C-w>

nmap t [tabpage]
nnoremap [tabpage] <Nop>
nnoremap [tabpage]n :<C-u>tabnew<Space>
nnoremap <silent> [tabpage]c :<C-u>tabclose<CR>
nnoremap <silent> [tabpage]o :<C-u>tabonly<CR>
nnoremap <silent> [tabpage]h :<C-u>tabprevious<CR>
nnoremap <silent> [tabpage]l :<C-u>tabnext<CR>
nnoremap <silent> <C-p> :<C-u>tabprevious<CR>
nnoremap <silent> <C-n> :<C-u>tabnext<CR>

inoremap <C-f> <Right>
inoremap <C-b> <Left>

inoremap () ()<Left>
inoremap [] []<Left>
inoremap {} {}<Left>
inoremap <> <><Left>
inoremap '' ''<Left>
inoremap "" ""<Left>

inoremap <expr> <F12> strftime('%Y-%m-%d')

augroup vimrc-pythonkeymap
  autocmd!
  autocmd FileType python call s:python_config()
augroup END
function! s:python_config()
  inoremap <buffer><expr> , smartchr#one_of(', ', ',')
  inoremap <buffer><expr> = smartchr#one_of(' = ', '=', ' == ')
  inoremap <buffer><expr> < smartchr#one_of(' < ', ' <= ', '<')
  inoremap <buffer><expr> > smartchr#one_of(' > ', ' >= ', '>')
endfunction

cnoremap \\ ~/
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" == plugins ==
" unite.vim
let g:unite_enable_start_insert = 0
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
let g:unite_split_rule = 'botright'
let g:unite_enable_split_vertically = 0
let g:unite_winheight = 15
let g:unite_winwidth = 40

nmap m [unite]
nnoremap [unite] <Nop>
nnoremap <silent> [unite]h :<C-u>Unite -start-insert help<CR>
nnoremap <silent> [unite]mh :<C-u>UniteWithCursorWord help<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite -start-insert file_rec/async<CR>
nnoremap <silent> [unite]l
  \ :<C-u>Unite -winheight=10 -start-insert -no-quit line<CR>
nnoremap <silent> [unite]ml
  \ :<C-u>UniteWithCursorWord -winheight=10 -no-quit line<CR>
nnoremap <silent> [unite]g
  \ :<C-u>Unite -winheight=10 -start-insert -no-quit grep<CR>

augroup vimrc-unitekeymap
  autocmd!
  autocmd FileType unite call s:unite_config()
augroup END
function! s:unite_config()
  imap <buffer> <C-j> <Plug>(unite_insert_leave)
endfunction

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_enable_fuzzy_completion = 0

inoremap <expr> <C-k> neocomplcache#close_popup()
inoremap <expr> <C-l> neocomplcache#cancel_popup()
inoremap <expr> <C-u> neocomplcache#undo_completion()
inoremap <expr> <CR>
  \ pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
inoremap <expr> <C-h>
  \ pumvisible() ? neocomplcache#smart_close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr> <BS>
  \ pumvisible() ? neocomplcache#smart_close_popup()."\<C-h>" : "\<C-h>"
inoremap <expr> <Tab>
  \ pumvisible() ? neocomplcache#complete_common_string() : "\<Tab>"

imap <C-y> <Plug>(neocomplcache_snippets_expand)


" vimfiler
let g:vimfiler_as_default_explorer = 1

nnoremap <silent> [unite]d :<C-u>VimFiler<CR>
nnoremap <silent> [unite]e
  \ :<C-u>VimFilerSplit -buffer-name=explorer -winwidth=40
  \                     -no-quit -toggle<CR>


" vimshell
let g:vimshell_prompt = '% '
let g:vimshell_user_prompt = 'getcwd()'
let g:vimshell_enable_ignore_case = 1
let g:vimshell_enable_smart_case = 1

nmap <silent> [unite]s <Plug>(vimshell_switch)


" neobundle.vim
nnoremap <silent> <F10> :<C-u>Unite neobundle/install:!<CR>

" quickrun.vim
let g:quickrun_config = {}
let g:quickrun_config.python = {'command' : 'python3'}

nnoremap <silent> <F9> :<C-u>QuickRun<CR>


" tweetvim
nnoremap <silent> <F8> :<C-u>TweetVimHomeTimeline<CR>
augroup vimrc-tweetvim
  autocmd!
  autocmd FileType tweetvim,tweetvim_say setlocal wrap
  autocmd FileType tweetvim call s:tweetvim_config()
augroup END
function! s:tweetvim_config()
  nnoremap <buffer><silent> s :<C-u>TweetVimSay<CR>
endfunction

