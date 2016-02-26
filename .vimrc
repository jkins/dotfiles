
" {{{ general/startup ========================================================= 

" {{{ terminal cursor
if &term =~ 'xterm\|rxvt'
  " █ cursor in normal mode
  let &t_EI = "\<Esc>[2 q"
  " _ cursor (blinking) in replace mode
  let &t_SR = "\<Esc>[3 q"
  " | cursor (blinking) in insert mode
  let &t_SI = "\<Esc>[5 q"
endif
" }}}

" {{{ pathogen
" AnsiEsc plugin (cecutil) maps <leader>rwp and <leader>swp. Prevent that.
let g:no_cecutil_maps = 1 

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
if !exists("vimpager")
  call pathogen#infect("bundle-mode-lite/{}")
  if exists("g:devmode")
    call pathogen#infect("bundle-mode-dev/{}")
  endif
endif
" }}}

" {{{ colorscheme 
if has("gui_running")
  colorscheme gui-jkins-light
else 
  colorscheme 256-jkins-dark
endif
" }}}

syntax enable
filetype plugin indent on


lang en_US.UTF-8

" {{{ platform
if has("win32") || has("win64")
  let g:platform = 'win'
else
  let g:platform = 'nix'
endif

" }}} =========================================================================

" {{{ settings ================================================================
" * means value modified elsewhere
set noautochdir           " change working dir to current buffer
set autoread            " autorefresh buffer when file changes
"set autoindent          " copy indent from previous line
set autowrite           " autosave when leaving buffers
set backspace=indent,eol,start " backspace behavior in insert mode 
set backup              " *use backup ~ files
set backupdir^=~/tmp//,$VIMRUNTIME/temp//
set cmdheight=1         " commandbar height
set colorcolumn=
set completeopt=longest,menuone
"set copyindent          " copy previous indent style
set cursorline          " * highlight the current line
set directory^=~/tmp//,$VIMRUNTIME/temp//
set encoding=utf-8
set expandtab
set fileformats=unix
set fillchars=fold:-,vert:║
set foldlevelstart=0    " *dont open folds
set foldtext=MyFoldText()
set formatoptions=qrn1  " see :help fo-table
set gdefault            " substitute whole line by default
set hidden              " change buffer without saving
set history=1000
set hlsearch            " highlight search terms
set ignorecase          " lowercase search => case insensitive search
set incsearch           " search as you type
set laststatus=2        " statusline is always second-to-last line
set lazyredraw          " don't redraw when executing macros
set listchars=tab:»\ ,trail:·,eol:¬,precedes:‹,extends:›
set magic              " leave magic at default settings
set modelines=5
set mouse=nvi
set mousehide           " hide mouse when typing
set mousemodel=popup    " popup menu on right-click
set number                 "* line numbers
set printoptions=paper:letter
set ruler               " show line/column in status bar
set scrolloff=2         " keep current line n lines away from edge
set sessionoptions=buffers,curdir,folds,help,options,tabpages,winsize
set shiftround
set shiftwidth=2
set shortmess=atI       " short messages
set showmatch           " highlight matching search items
set showmode            " show the mode in the status bar
set showtabline=1       " show tabline when there's more than one tab
set sidescrolloff=5    " keep cursor n columns away from edge
set smartcase           " different cases make search case-sensitive
"set smartindent
" looks like: /path/to/file    branch|JAVA|Tue 01/23/00 12:22 PM|114,65|30% 
"set statusline=%F%m%r%h%w%=\ %{g:MyGitHead(6)}\|%Y\|%{strftime(\"%a\ %m/%d/%y\ %I:%M\ %p\",\ getftime(expand('%')))}\|%l,%v\|%p%%\  
"set statusline=%F%m
set smarttab
if exists("+spelllang")
    set spelllang=en_US
endif
set suffixes+=.class    " don't autocomplete these extensions
set noswapfile
set tabstop=4           " a tab is 4 characters wide
set tabline=%!MyTabLine()
set tags=./tags;/,~/tags
set textwidth=0         " auto-newline after n chars (0 disabled)
set tildeop             " ~ behaves like an operator
set title               " vim can change window title
set ttyfast             " fast terminal connection
set ttymouse=xterm2
set undodir=$VIMRUNTIME\\undo\\undofile            " persistent undo
set virtualedit=block
set visualbell          " flash editor instead of beeping on error
set wildmenu
" wildignore {{{
set wildignore+=.git,.svn,.hg                   " version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg  " binary
set wildignore+=classes,*.class                 " java bytecode
set wildignore+=*.sw?                           " vim swap files
set wildignore+=target/                         " java build
" }}}
set wildmode=list:longest,full,full
set nowrap              " don't wrap text
" }}} =========================================================================

" {{{ windows =================================================================
if g:platform == 'win'
  "source $VIMRUNTIME/mswin.vim
  "behave mswin
  "let g:no_cygwin_shell=1
  if $PATH =~? 'cygwin' && !exists("g:no_cygwin_shell")
    set shell=bash
    "set shellquote="\""
    set shellpipe=2>&1\|tee
    set shellslash
  endif

  " mintty mode-dependent cursor 
  let &t_ti.="\e[1 q"
  let &t_SI.="\e[5 q"
  let &t_EI.="\e[1 q"
  let &t_te.="\e[0 q"
 
  " gvim
  if has("gui_running")
    set guifont=Consolas:h12:cANSI
    " zoom levels
    nnoremap <f1> :set guifont=Consolas:h3:cANSI<CR>
    nnoremap <f2> :set guifont=Consolas:h10:cANSI<CR>
    nnoremap <f3> :set guifont=Consolas:h12:cANSI<CR>
    nnoremap <f4> :set guifont=Consolas:h18:cANSI<CR>
    vnoremap <f1> :set guifont=Consolas:h3:cANSI<CR>
    vnoremap <f2> :set guifont=Consolas:h10:cANSI<CR>
    vnoremap <f3> :set guifont=Consolas:h12:cANSI<CR>
    vnoremap <f4> :set guifont=Consolas:h18:cANSI<CR>
  endif
endif
" }}} =========================================================================

" {{{ gvim ====================================================================
if has("gui_running")
  " start at 45x90
  autocmd GUIEnter * set columns=90 | set lines=45 
  autocmd GUIEnter * if &diff | simalt ~x | endif
  autocmd BufEnter pentadactyl.txt call g:QuickEdit()

  set guifont=Inconsolata\ 14
  set guioptions=crLbhTm
endif
" }}} =========================================================================

" {{{ events/autocmd ==========================================================
augroup vimrc
au!

" Event handlers
au WinEnter * call g:HandleWinEnter()
au WinLeave * call g:HandleWinLeave()

" leave insert mode after 15sec of no input
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore

" Resize splits when the window is resized for diffs
au VimResized * if &diff | :wincmd = | endif

" When vimrc is edited, reload it
au! bufwritepost .vimrc source $MYVIMRC
au! bufwritepost _vimrc source $MYVIMRC    " windows

" Normal line numbers in diff
au FilterWritePost * if &diff | setlocal number | endif

" When loading a file, if it reads in as Unix, but has a DOS line ending,
" and is not in binary mode, reload it in DOS format. Do this AFTER loading
" last known position to prevent always opening on last line.
" Time out the search after 1/10 second. Timeouts only available in 7.1.211
" and up, so just risk long loads in earlier versions.
"if (v:version > 701 || v:version == 701 && has("patch211"))
  "autocmd BufReadPost * nested
        "\ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc', 0, 100)) |
        "\   let b:reload_dos = 1 |
        "\   redir => s:num_dos_ends |
        "\   silent %s#\r$##n |
        "\   redir END |
        "\   e ++ff=dos |
        "\   echomsg "File has ".
        "\     substitute(s:num_dos_ends, '^.\{-}\(\d\+\).*', '\1', '').
        "\     " DOS-style line endings out of ".line('$')." lines." |
        "\ endif
"else
  "autocmd BufReadPost * nested
        "\ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
        "\   let b:reload_dos = 1 |
        "\   e ++ff=dos |
        "\ endif
"endif
"autocmd BufReadPost * if exists('b:reload_dos') | unlet b:reload_dos | endif

augroup END
" }}} =========================================================================

" {{{ plugin settings =========================================================
" airline {{{
let g:airline_left_sep='▒'
let g:airline_right_sep='▒'
let g:airline_theme="tomorrow"
let g:airline_inactive_collapse=1
let g:airline#extensions#tabline#enabled = 1
" }}}

" rainbow {{{
let g:rainbow_active = 0
" }}}

" neocomplete {{{
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType coffee setlocal foldmethod=indent
" }}}

" neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" }}}

" NERDTree {{{
let g:NERDTreeDirArrows=0
let g:NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$', '\.class$', '\.jpg$']
let g:NERDTreeMinimalUI=1
" }}}

" Tagbar {{{
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['»', '·']
" }}}

" showmarks {{{
"let g:showmarks_ignore_type = "hmpq"
"let g:showmarks_hlline_lower = 1
"let g:showmarks_hlline_upper = 1
"let g:showmarks_hlline_other = 0
"let g:showmarks_textupper = "\t"
"let g:showmarks_textlower = "\t"
"let g:showmarks_textother = "\t"
" }}}

" indent guides {{{
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" }}}

" easymotion {{{
let g:EasyMotion_do_mapping = 0 " Disable default mapping
nmap <Space> <Plug>(easymotion-s)

" search (highlight not working atm)
"map <leader>/ <Plug>(easymotion-sn)
"omap <leader>/ <Plug>(easymotion-tn)
"map n <Plug>(easymotion-next)
"map N <Plug>(easymotion-prev)

" }}}

" fuzzyfinder {{{
"let g:fuf_botRight = 1
"let g:fuf_file_exclude = '\v\~$'
"\ . '|\.(o|png|PNG|JPG|class|CLASS|jpg|exe|bak|swp|jar|war|ear|zip|tar|gz|bz2)$'
"\ . '|(^|[/\\])\.(svn|hg|git|bzr)($|[/\\])'
"\ . '|.*[/\\]$' 
" }}}

" session {{{
let g:session_autoload = "prompt"
let g:session_autosave = 0
let g:session_default_to_last = 1
" }}}

" ctrlp {{{
let g:ctrlp_by_filename = 1
let g:ctrlp_cache_dir = $VIMRUNTIME.'/.ctrlp_cache'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = '\v\~$'
\ . '|\.(o|png|PNG|JPG|class|CLASS|jpg|exe|bak|swp|jar|war|ear|zip|tar|gz|bz2)$'
\ . '|(^|[/\\])\.(svn|hg|git|bzr)($|[/\\])'
\ . '|.*[/\\]$' 
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 2
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" Make sure ctrlp is installed and loaded
"if !exists('g:loaded_ctrlp') || ( exists('g:loaded_ctrlp') && !g:loaded_ctrlp )
	"finish
"endif

" ctrlp only looks for this
"let g:ctrlp_status_func = {
	"\ 'main': 'CtrlP_Statusline_1',
	"\ 'prog': 'CtrlP_Statusline_2',
    "\ }

"" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"" a:1 a:2 a:3 a:4 a:5 a:6 a:7
"fu! CtrlP_Statusline_1(...)
	"let focus = '%#LineNr# '.a:1.' %*'
	"let byfname = '%#Character# '.a:2.' %*'
	"let regex = a:3 ? '%#LineNr# regex %*' : ''
	"let prv = ' <'.a:4.'>='
	"let item = '{ '.a:5.' }'
	"let nxt = '=<'.a:6.'>'
	"let marked = ' '.a:7.' '
	"let dir = ' %=%<%#LineNr# '.getcwd().' %*'
	"" Return almost the full statusline
	"retu focus.byfname.regex.item.marked.dir
"endf

"" Argument: len
"" a:1
"fu! CtrlP_Statusline_2(...)
	"let len = '%#Function# '.a:1.' %*'
	"let dir = ' %=%<%#LineNr# '.getcwd().' %*'
	"" Return the full statusline
	"retu len.dir
"endf
" }}}

" powerline {{{
"let g:Powerline_symbols = "compatible"
" }}}

" xmledit {{{
let g:xml_syntax_folding = 1
" }}}

" delimitMate {{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
" }}}
" }}} =========================================================================

" {{{ mappings ================================================================
let mapleader = ","
let g:mapleader = ","
let localleader = "\\"

" save a file a super user
cmap w!! %!sudo tee > /dev/null %

" command line editing
cnoremap <c-j> <t_kd>
cnoremap <c-k> <t_ku>
cnoremap <c-a> <Home>
cnoremap <c-e> <End>

" relative line numbers when operator-pending
"nnoremap <silent> d :setlocal rnu<cr>d
"nnoremap <silent> y :setlocal rnu<cr>y
"nnoremap <silent> c :setlocal rnu<cr>c
"nnoremap <silent> = :setlocal rnu<cr>=
"nnoremap <silent> < :setlocal rnu<cr><
"nnoremap <silent> > :setlocal rnu<cr>>
"nnoremap <silent> ~ :setlocal rnu<cr>~›

" Keep search matches in the middle of the window and pulse the line when moving
" to them. Same with jumps.
"nnoremap n nzzzv
"nnoremap n nzzzv
"nnoremap g; g;zz
"nnoremap g, g,zz

" Don't move on *
nnoremap * *<c-o>

" Space to toggle folds.
"nnoremap <Space> za
"vnoremap <Space> za

" Recursively open current top level fold
nnoremap zO zCzO

" Center location
nnoremap <Return> zvzz

" Close all but current fold
nnoremap <Leader>z zMzvzz

" return cursor to starting position after a repeat
nnoremap . .`[

" make Y work like C and D (yank to end of line)
nnoremap Y y$

" repeat on all lines in visual selection
vnoremap <silent> . :normal .<cr>

" reselect selection after indenting
vnoremap > >gv
vnoremap < <gv

" quick insert->normal mode with jj
inoremap jj <ESC>

" no need to hit shift to access command mode
nnoremap ; :

" clear search results
nnoremap <leader><space> :noh<cr>

" easier line+column marks
nnoremap ' `
nnoremap ` '
vnoremap ' `
vnoremap ` '

" wrapped lines treated as separate when moving up and down
nnoremap j gj
nnoremap k gk

" coarse movement
"nnoremap <s-h> b
"nnoremap <s-j> 10j
"nnoremap <s-k> 10k
"nnoremap <s-l> w
"vnoremap <s-h> ge
"vnoremap <s-j> 10j
"vnoremap <s-k> 10k
"vnoremap <s-l> e

" split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fast save
nnoremap <leader>w :w!<cr>
vnoremap <leader>w :w!<cr>

" switch to directory of open buffer
"nnoremap <leader>cd :cd %:p:h<cr>
"vnoremap <leader>cd :cd %:p:h<cr>

" / searches literally, <leader>/ is search by regex, see :help magic
"nnoremap / /\V
"nnoremap ? ?\V
"nnoremap <leader>/ /\v
"nnoremap <leader>? ?\v
"vnoremap / /\V
"vnoremap ? ?\V
"vnoremap <leader>/ /\v
"vnoremap <leader>? ?\v

" move a line of text using ALT+[jk], indent with ALT+[hl]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
nnoremap <A-h> <<
nnoremap <A-l> >>
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
inoremap <A-h> <Esc><<`]a
inoremap <A-l> <Esc>>>`]a
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
vnoremap <A-h> <gv
vnoremap <A-l> >gv

" details - tab/eol/whitespace chars
nnoremap <silent> <leader>d :call g:ToggleShowDetails()<cr>
vnoremap <silent> <leader>d :call g:ToggleShowDetails()<cr>

" toggle line numbers - absolute/relative/none
nnoremap <silent> <leader>n :call g:ToggleNuMode()<cr>
vnoremap <silent> <leader>n :call g:ToggleNuMode()<cr>

" show the active highlighting under the cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" split - horizontal split and switch to it
nnoremap <leader>s <C-w>s

" split - vertical split and switch to it
nnoremap <leader>S <C-w>v<C-w>l

" tab
nnoremap <leader>t :tabnew<cr>

" windows cygwin/clipboard, vimtip 1623
if g:platform == 'win'
  nnoremap <silent> <leader>Y :call g:PutWinClip('n', 1)<CR>
  vnoremap <silent> <leader>Y :call g:PutWinClip(visualmode(), 1)<CR>
  nnoremap <silent> <leader>P :call g:GetWinClip()<CR>
  vnoremap <silent> <leader>P x:call g:GetWinClip()<CR>
endif

" search for selected text, forwards (*)
vnoremap <silent> * :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy/<C-R><C-R>=substitute(
\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

" search for selected text, backwards (#)
vnoremap <silent> # :<C-U>
\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
\gvy?<C-R><C-R>=substitute(
\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
\gV:call setreg('"', old_reg, old_regtype)<CR>

" {{{ plugins =================================================================
" scratch buffer
"nnoremap <leader><tab> :Scratch<cr> 
" buffer (ctrlp)
nnoremap <leader>b :CtrlPBuffer<cr>
" file (ctrlp)
nnoremap <leader>f :CtrlP<cr>
" MRU file (ctrlp)
nnoremap <leader>F :CtrlPMRUFiles<cr>
" git status
nnoremap <leader>gs :Gstatus<cr>
" git log
nnoremap <leader>gl :Extradite<cr>
" gitv (like gitk) current file
nnoremap <leader>gv :Gitv!<cr>
" gitv (like gitk) rep
nnoremap <leader>gV :Gitv!<cr>
" git quickfix last log entries
nnoremap <leader>gq :Glog<cr>
" git diff
nnoremap <leader>gd :Gdiff<cr>
" git blame
nnoremap <leader>gb :Gblame<cr>
" git commit
nnoremap <leader>gc :Gcommit<cr>
" git read (effectively reverts the current buffer to the index version)
nnoremap <leader>gr :Gread<cr>
" NERDTree explorer 
nnoremap <F5> :NERDTreeToggle<cr>
" quickfix (copen)
nnoremap <F7> :botright cope<cr>
" vimrc
nnoremap <leader>rc :e $MYVIMRC<cr>
" vim-session
nnoremap <leader>SS :SaveSession
nnoremap <leader>SO :OpenSession
" tagbar
nnoremap <F6> :TagbarToggle<cr>
" gundo tree
nnoremap <leader>u :GundoToggle<cr>
" smart buffer delete
nnoremap <silent> <leader>x :Sbd<cr>
nnoremap <silent> <leader>X :Sbdm<cr>
" YankRing
nnoremap <leader>y :YRShow<cr>
" snipmate
"inoremap <silent> <tab> <c-r>=snipMate#TriggerSnippet()<cr>
"snoremap <silent> <tab> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
"inoremap <silent> <s-tab> <c-r>=snipMate#BackwardsSnippet()<cr>
"snoremap <silent> <s-tab> <esc>i<right><c-r>=snipMate#BackwardsSnippet()<cr>
"inoremap <silent> <c-r><tab> <c-r>=snipMate#ShowAvailableSnips()<cr>
" fzf
set rtp+=~/.fzf
" }}}
" }}} =========================================================================

" {{{ functions ===============================================================
function! g:MyGitHead(n)
  if exists('g:loaded_fugitive')
    return fugitive#head(a:n)
  else
    return ' '
  endif
endfunction

" write to cygwin clipboard, vimtip 1623
function! g:PutWinClip(type, ...) range
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  if a:type == 'n'
    silent exe a:firstline . "," . a:lastline . "y"
  elseif a:type == 'c'
    silent exe a:1 . "," . a:2 . "y"
  else
    silent exe "normal! `<" . a:type . "`>y"
  endif
  call writefile(split(@@,"\n"), '/dev/clipboard')
  let &selection = sel_save
  let @@ = reg_save
endfunction

" read from cygwin clipboard, vimptip 1623
function! g:GetWinClip()
  let reg_save = @@
  let @@ = join(readfile('/dev/clipboard'), "\n")
  setlocal paste
  exe 'normal p'
  setlocal nopaste
  let @@ = reg_save
endfunction

" toggles none->absolute->relative line numbers       
function! g:ToggleNuMode() " {{{
  if(&number)
    if(&relativenumber)
      setlocal norelativenumber
      setlocal nonumber
    else
      setlocal relativenumber
    endif
endfunc " }}}

function! g:HandleWinEnter()
  "if(&number || &relativenumber)
    "setlocal relativenumber
  "endif
  setlocal cursorline
endfunction

function! g:HandleWinLeave()
  "if(&number || &relativenumber)
      "setlocal number
  "endif
  setlocal nocursorline
endfunction

function! g:QuickEdit()
  setlocal laststatus=0
  setlocal linebreak
  setlocal lines=10
  setlocal nonumber
  setlocal wrap
endfunction

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 1, windowwidth - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  "return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  return '↕' . line . '…' . repeat(" ",fillcharcount) . '←' . foldedlinecount 
endfunction " }}}

" Shows tab characters/columns, trailing whitespace, newlines
function! g:ToggleShowDetails() " {{{
  if(&list)
    set colorcolumn=
    set cursorline
    set foldcolumn=0
    silent IndentGuidesDisable
  else
    set colorcolumn=1,80,120
    set foldcolumn=1
    set nocursorline
    silent IndentGuidesEnable
  endif
  silent RainbowToggle
  set list!
endfunc " }}}

" Makes tab names the basename of the file instead of the path
" see http://bradgrissom.com/index.php?/archives/61-Rename-tabs-in-Vim.html
function! MyTabLine() " {{{
  let s = ''
  for i in range(tabpagenr('$'))
      " select the highlighting
      if i + 1 == tabpagenr()
          let s .= '%#TabLineSel#'
      else
          let s .= '%#TabLine#'
      endif

      " set the tab page number (for mouse clicks)
      let s .= '%' . (i + 1) . 'T'

      " the label is made by MyTabLabel()
      "let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
      let s .= ' %{BradLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill# %T'

  " right-align the label to close the current tab page
  "if tabpagenr('$') > 1
  "    let s .= '%=%#TabLine#%999Xclose'
  "endif

  return s
endfunc " }}}

function! BradLabel(n) " {{{
  let buflist = tabpagebuflist(a:n)
  let winnr   = tabpagewinnr(a:n)
  let bufnam  = bufname(buflist[winnr - 1])
  " This is getting the basename() of bufname above
  let base    = substitute(substitute(bufnam, '.*\', '', ''), '.*/', '', '')
  let name    = a:n . ' ' . base
  return name
endfunction " }}}

function! MyTabLabel(n) " {{{
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction " }}}
" }}}

" {{{ filetypes ===============================================================
augroup ft_ftl " {{{
  au!
  au FileType ftl setlocal tabstop=2
  au FileType ftl setlocal foldmethod=indent
  au FileType ftl setlocal foldlevel=4
  au FileType ftl setlocal filetype=html.ftl
  "au FileType ftl inoremap <c-return> <esc>A;<esc>^
augroup END " }}}
augroup ft_html " {{{
  au!
  au FileType html setlocal tabstop=2
  au FileType html setlocal foldmethod=indent
  au FileType html setlocal foldlevel=4
  "au FileType html inoremap <c-return> <esc>miA;<esc>`ia
augroup END " }}}
augroup ft_man " {{{
  au!
  au FileType man setlocal nomodifiable nolist
augroup END " }}}
augroup ft_java " {{{
  au!
  au FileType java setlocal foldmethod=marker
  au FileType java setlocal foldmarker={,}
  au FileType java setlocal foldlevel=1
  au FileType java setlocal foldmethod=marker
  au FileType java setlocal shiftwidth=4
  "au FileType java inoremap ; <C-o>A;
  "au FileType java inoremap { {<CR><CR>}<C-o>k<TAB><TAB>
  "au FileType java inoremap  <C-o>A;<CR>
  "au FileType java compiler ant
  "au FileType java setlocal makeprg=mvn\ -q\ install
  "au BufEnter pom.xml setlocal makeprg=mvn\ -q\ install
  "au FileType java let b:delimitMate_eol_marker = ";"
augroup END " }}}
augroup ft_javascript " {{{
  au!
  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
  au FileType javascript setlocal foldlevel=1
  au FileType javascript setlocal shiftwidth=2
  "au FileType javascript inoremap ; <C-o>A;
  "au FileType javascript inoremap { {<CR><CR>}<C-o>k<TAB><TAB>
  "au FileType javascript inoremap  <C-o>A;<CR>
  "au FileType javascript inoremap <expr> <c-return> <esc>miA;<esc>`ia
  au FileType javascript inoremap  <esc>miA;<esc>`ia
  "au FileType javascript let b:delimitMate_eol_marker = ";"
augroup END " }}}
augroup ft_json " {{{
  au!
  au FileType json setlocal expandtab
  au FileType json setlocal foldmethod=marker
  au FileType json setlocal foldmarker={,}
  au FileType json setlocal foldlevel=1
augroup END " }}}
augroup ft_xml " {{{
  au!
  au FileType xml setlocal expandtab
  au FileType xml setlocal foldmethod=syntax
  au FileType xml setlocal foldlevel=2
  au FileType xml setlocal shiftwidth=2
  au FileType xml setlocal tabstop=2
augroup END " }}}
augroup ft_nerdtree " {{{
  au!
  "au FileType nerdtree setlocal colorcolumn= nonu
augroup END " }}}
augroup ft_tagbar " {{{
  au!
  "au FileType tagbar setlocal colorcolumn= statusline="Tag Bar" nornu
augroup END " }}}
augroup ft_fugitiveblame " {{{
  au!
  au FileType fugitiveblame setlocal colorcolumn= nu
augroup END " }}}
augroup ft_quickfix " {{{
  au!
  au FileType qf setlocal colorcolumn= nornu nocursorline 
augroup END " }}}
augroup ft_extradite " {{{
  au!
  au FileType extradite setlocal colorcolumn= nu
augroup END " }}}
" }}} =========================================================================

