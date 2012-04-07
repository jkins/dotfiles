" .vimrc - Jeff Kinslow
" vim: foldmethod=marker

" {{{ pathogen/general ======================================================== 
call pathogen#infect()
filetype plugin indent on
" }}}

" {{{ language ================================================================
try
	lang en_US
catch
endtry
" }}}

" {{{ colors ==================================================================
syntax enable
colorscheme jkins
"colorscheme solarized
" }}}

" {{{ settings ================================================================
" * means value modified elsewhere
set autoread            " autorefresh buffer when file changes
set autoindent          " copy indent from previous line
set autowrite           " autosave when leaving buffers
set backspace=indent,eol,start " backspace behavior in insert mode 
set backup              " *use backup ~ files
set backupdir^=~/tmp//,$VIMRUNTIME/temp//
set cmdheight=1         " commandbar height
set colorcolumn=1,80,120
set nocompatible        " don't need vi compatibility
set completeopt=longest,menuone
set copyindent          " copy previous indent style
set cursorline          " * highlight the current line
set directory^=~/tmp//,$VIMRUNTIME/temp//
set encoding=utf-8
set ffs=unix,dos        " default file types
set fillchars=fold:―,vert:¦
set foldlevelstart=0    " *dont open folds
set formatoptions=qrn1  " see :help fo-table
set gdefault            " substitute whole line by default
set hidden              " change buffer without saving
set history=1000
set hlsearch            " highlight search terms
set ignorecase          " lowercase search => case insensitive search
set incsearch           " search as you type
set laststatus=2        " statusline is always second-to-last line
set lazyredraw          " don't redraw when executing macros
set listchars=tab:»\ ,trail:·,eol:¬
"set magic              " leave magic at default settings
set makeprg=ant\ -emacs
set modelines=5
set mouse=nvi
set mousemodel=popup    " popup menu on right-click
set rnu                 "* line numbers
set printoptions=paper:letter
set ruler               " show line/column in status bar
set scrolloff=2         " keep current line n lines away from edge
set sessionoptions=buffers,curdir,folds,help,options,tabpages,winsize
set shiftround
set shiftwidth=4
set shortmess=atI       " short messages
set showmatch           " highlight matching search items
set showmode            " show the mode in the status bar
set showtabline=1       " show tabline when there's more than one tab
set sidescrolloff=5    " keep cursor n columns away from edge
set smartcase           " different cases make search case-sensitive
"set smartindent
" looks like: /path/to/file [Git(master)] Tue 01/23/00 12:22 PM (unix){JAVA}[114,65][30%]
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ %{strftime(\"%a\ %m/%d/%y\ %I:%M\ %p\",\ getftime(expand('%')))}\ (%{&ff}){%Y}[%l,%v][%p%%]
set smarttab
if exists("+spelllang")
	set spelllang=en_US
endif
set suffixes+=.class    " don't autocomplete these extensions
set noswapfile
set tabstop=4           " a tab is 4 characters wide
set tabline=%!MyTabLine()
set tags=~/.tags
set textwidth=0         " auto-newline after n chars (0 disabled)
set tildeop				" ~ behaves like an operator
set title
set ttyfast
set undodir=$VIMRUNTIME\\undo\\undofile            " persistent undo
set virtualedit=block
set visualbell          " flash editor instead of beeping on error
set wildmenu
" wildignore {{{
set wildignore+=.git,.svn,.hg                   " version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg  " binary
set wildignore+=classes,*.class                 " java bytecode
set wildignore+=*.sw?                           " vim swap files
" }}}
set wildmode=list:longest,full,full
set nowrap              " don't wrap text
" }}}
"
" {{{ win32 ===================================================================
if has("win32") || has("win64") 
	let g:mswindows=1
	"source $VIMRUNTIME/mswin.vim
	"behave mswin
	if $PATH =~? 'cygwin' && !exists("g:no_cygwin_shell")
		set shell=bash
		set shellquote="\""
		set shellpipe=2>&1\|tee
		set shellslash
	endif
endif
" }}}

" {{{ gvim ====================================================================
if has("gui_running")
	" start at 45x90
	autocmd GUIEnter * set columns=90 | set lines=45 

	set guioptions=crLbh
	
	if g:mswindows
		set guifont=Consolas:h12:cANSI
		" zoom levels
		noremap <f1> :set guifont=Consolas:h3:cANSI<CR>
		noremap <f2> :set guifont=Consolas:h10:cANSI<CR>
		noremap <f3> :set guifont=Consolas:h12:cANSI<CR>
		noremap <f4> :set guifont=Consolas:h18:cANSI<CR>
		vnoremap <f1> :set guifont=Consolas:h3:cANSI<CR>
		vnoremap <f2> :set guifont=Consolas:h10:cANSI<CR>
		vnoremap <f3> :set guifont=Consolas:h12:cANSI<CR>
		vnoremap <f4> :set guifont=Consolas:h18:cANSI<CR>
	else
		"Inconsolata? TODO: *nix fonts
	endif
endif
" }}}


" {{{ events/autocmd ==========================================================
" leave insert mode after 15sec of no input
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore

" no line numbers for some buffers
au FileType nerdtree setlocal colorcolumn= nonu
au FileType tagbar setlocal colorcolumn= statusline="Tag Bar" nornu
au FileType fugitiveblame setlocal colorcolumn= nu
au FileType qf setlocal colorcolumn= nornu nocursorline 
au FileType extradite setlocal colorcolumn= nu

" Resize splits when the window is resized
au VimResized * :wincmd =

" When vimrc is edited, reload it
au! bufwritepost .vimrc source $MYVIMRC
au! bufwritepost _vimrc source $MYVIMRC    " windows

" Enable cursorline only in the current buffer
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

" Normal line numbers in diff
au FilterWritePost * if &diff | setlocal nu | endif

" When loading a file, if it reads in as Unix, but has a DOS line ending,
" and is not in binary mode, reload it in DOS format. Do this AFTER loading
" last known position to prevent always opening on last line.
"
" Time out the search after 1/10 second. Timeouts only available in 7.1.211
" and up, so just risk long loads in earlier versions.
if (v:version > 701 || v:version == 701 && has("patch211"))
  autocmd BufReadPost * nested
        \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc', 0, 100)) |
        \   let b:reload_dos = 1 |
        \   redir => s:num_dos_ends |
        \   silent %s#\r$##n |
        \   redir END |
        \   e ++ff=dos |
        \   echomsg "File has ".
        \     substitute(s:num_dos_ends, '^.\{-}\(\d\+\).*', '\1', '').
        \     " DOS-style line endings out of ".line('$')." lines." |
        \ endif
else
  autocmd BufReadPost * nested
        \ if !exists('b:reload_dos') && !&binary && &ff=='unix' && (0 < search('\r$', 'nc')) |
        \   let b:reload_dos = 1 |
        \   e ++ff=dos |
        \ endif
endif
autocmd BufReadPost * if exists('b:reload_dos') | unlet b:reload_dos | endif
" }}}

" {{{ plugin settings =========================================================
" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_auto_select = 1

" NERDTree
let g:NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$', '\.class$', '\.jpg$']
let g:NERDTreeMinimalUI=1
" Tagbar
let g:tagbar_compact = 1
" showmarks
"let g:showmarks_ignore_type = "hmpq"
"let g:showmarks_hlline_lower = 1
"let g:showmarks_hlline_upper = 1
"let g:showmarks_hlline_other = 0
"let g:showmarks_textupper = "\t"
"let g:showmarks_textlower = "\t"
"let g:showmarks_textother = "\t"
" indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" buffergator
"let g:buffergator_autoexpand_on_split = 0
"let g:buffergator_sort_regime = "mru"
"let g:buffergator_split_size = 6
"let g:buffergator_suppress_keymaps = 1
"let g:buffergator_viewport_split_policy = "B"
" easymotion
let g:EasyMotion_leader_key = '<Leader>m'
" fuzzyfinder
"let g:fuf_botRight = 1
"let g:fuf_file_exclude = '\v\~$'
"\ . '|\.(o|png|PNG|JPG|class|CLASS|jpg|exe|bak|swp|jar|war|ear|zip|tar|gz|bz2)$'
"\ . '|(^|[/\\])\.(svn|hg|git|bzr)($|[/\\])'
"\ . '|.*[/\\]$' 
" session
let g:session_autoload = 0
let g:session_autosave = 0
let g:session_default_to_last = 0
" ctrlp
let g:ctrlp_by_filename = 1
let g:ctrlp_cache_dir = $VIMRUNTIME.'/.ctrlp_cache'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_exclude = '\v\~$'
\ . '|\.(o|png|PNG|JPG|class|CLASS|jpg|exe|bak|swp|jar|war|ear|zip|tar|gz|bz2)$'
\ . '|(^|[/\\])\.(svn|hg|git|bzr)($|[/\\])'
\ . '|.*[/\\]$' 
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 2
" powerline
let g:Powerline_symbols = "compatible"
" xmledit
let g:xml_syntax_folding = 1
" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" }}}

" {{{ mappings ================================================================
let mapleader = ","
let g:mapleader = ","

" save a file a super user
cmap w!! %!sudo tee > /dev/null %

" relative line numbers when operator-pending
"nnoremap <silent> d :setlocal rnu<cr>d
"nnoremap <silent> y :setlocal rnu<cr>y
"nnoremap <silent> c :setlocal rnu<cr>c
"nnoremap <silent> = :setlocal rnu<cr>=
"nnoremap <silent> < :setlocal rnu<cr><
"nnoremap <silent> > :setlocal rnu<cr>>
"nnoremap <silent> ~ :setlocal rnu<cr>~›

" \ joins lines
nnoremap \ J
" Keep search matches in the middle of the window and pulse the line when moving
" to them. Same with jumps.
nnoremap n nzzzv
nnoremap n nzzzv
nnoremap g; g;zz
nnoremap g, g,zz
" Don't move on *
nnoremap * *<c-o>
" Center location
nnoremap <return> zvzz
" Close all but the current fold
nnoremap <c-return> zMzvzz
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
" Recursively open current top level fold
nnoremap zO zCzO
nnoremap <leader>z zMzvzz
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
" big movements by 10
"vnoremap <m-k> <c-u>
"vnoremap <m-j> <c-d>
nnoremap <s-h> b
nnoremap <s-j> 10j
nnoremap <s-k> 10k
nnoremap <s-l> w
vnoremap <s-h> b
vnoremap <s-j> 10j
vnoremap <s-k> 10k
vnoremap <s-l> w
" split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" fast save
nnoremap <leader>w :w!<cr>
vnoremap <leader>w :w!<cr>
" switch to directory of open buffer
nnoremap <leader>cd :cd %:p:h<cr>
vnoremap <leader>cd :cd %:p:h<cr>
" Build
nnoremap <leader>B :call g:MyMake()<cr>
" / searches literally, <leader>/ is search by regex, see :help magic
nnoremap / /\V
nnoremap ? ?\V
nnoremap <leader>/ /\v
nnoremap <leader>? ?\v
vnoremap / /\V
vnoremap ? ?\V
vnoremap <leader>/ /\v
vnoremap <leader>? ?\v
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
nnoremap <leader>d :call g:ToggleShowDetails()<cr>
vnoremap <leader>d :call g:ToggleShowDetails()<cr>
" numbers - absolute/relative line numbers
nnoremap <leader>N :call g:ToggleNuMode()<cr>
vnoremap <leader>N :call g:ToggleNuMode()<cr>
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
" smart buffer delete
nnoremap <leader>x :Sbd<cr>
nnoremap <leader>X :Sbdm<cr>

" search for selected text, forwards(*) or backwards(#)
" =============================================================================
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" {{{ plugins =================================================================
" scratch buffer
nnoremap <leader><tab> :Scratch<cr> 
" buffer (ctrlp)
nnoremap <leader>b :CtrlPBuffer<cr>
" diffmarks (what it should be called, not 'svndiff')
nnoremap <leader>D :call Svndiff("prev")<cr>
" file (ctrlp)
nnoremap <leader>f :CtrlP<cr>
" MRU file (ctrlp)
nnoremap <leader>F :CtrlPMRUFiles<cr>
" git status
nnoremap <leader>gs :Gstatus<cr>
" git log
nnoremap <leader>gl :Extradite<cr>
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
" showmarks
nnoremap <leader>MM :ShowMarksToggle<cr>
nnoremap <leader>Mc :ShowMarksClearMark<cr>
nnoremap <leader>MC :ShowMarksClearAll<cr>
vnoremap <leader>MM :ShowMarksToggle<cr>
vnoremap <leader>Mc :ShowMarksClearMark<cr>
vnoremap <leader>MC :ShowMarksClearAll<cr>
" NERDTree explorer 
nnoremap <leader>n :NERDTree<cr>
" quickfix (copen)
nnoremap <leader>q :botright cope<cr>
" vimrc
nnoremap <leader>rc :e $MYVIMRC<cr>
" vim-session
nnoremap <leader>SS :SaveSession
nnoremap <leader>SO :OpenSession
" tagbar
nnoremap <leader>T :TagbarToggle<cr>
" gundo tree
nnoremap <leader>u :GundoToggle<cr>
" YankRing
nnoremap <leader>y :YRShow<cr>
" snipmate
inoremap <silent> <tab> <c-r>=TriggerSnippet()<cr>
snoremap <silent> <tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
inoremap <silent> <s-tab> <c-r>=BackwardsSnippet()<cr>
snoremap <silent> <s-tab> <esc>i<right><c-r>=BackwardsSnippet()<cr>
inoremap <silent> <c-r><tab> <c-r>=ShowAvailableSnips()<cr>
" }}}
" }}}

" {{{ functions ===============================================================
" toggles relative/absolute line numbers       
function! g:ToggleNuMode() " {{{
	let b:numode = exists('b:numode') ? !b:numode : 0
	if b:numode
		setlocal number
	else
		setlocal relativenumber
	endif
endfunc " }}}

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 1, windowwidth - 8 - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    "return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
    return '›' . line . '…' . repeat(" ",fillcharcount-7) . '‹' . foldedlinecount . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Shows tab characters/columns, trailing whitespace, newlines
function! g:ToggleShowDetails() " {{{

	if(&list == 0)
		setlocal nocursorline
		:IndentGuidesEnable
		:RainbowParenthesesToggle
	else
		setlocal cursorline
		:IndentGuidesDisable
		:RainbowParenthesesToggle
	endif
	setlocal list!
endfunc " }}}

" Toggles between maximized and unmaximized mode
function! g:ToggleMax() " {{{
	let w:maximized = exists('w:maximized') ? !w:maximized : 0
	if w:maximized
		set columns=90
		set lines=45
	else
		simalt ~x
	endif
endfunc " }}}

" Make behaving strangely on Windows
function! g:MyMake() " {{{
	let f = $VIMRUNTIME . "\\temp\\.errorfile"
	execute "!ant -emacs > \\\"$(cygpath -u \\\"" . f . "\\\")\\\""
	execute "cfile" f
endfunc " }}}

" Toggles between ~90% and 100% opacity on windows
function! g:ToggleTrans() " {{{
	let w:trans = exists('w:trans') ? !w:trans : 1
	if w:trans
		:call libcallnr("vimtweak.dll", "SetAlpha", 225)
	else
		:call libcallnr("vimtweak.dll", "SetAlpha", 255)
	endif
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
	"	let s .= '%=%#TabLine#%999Xclose'
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

function! MyGuiTabLine() " {{{
	let s = ''
	let s .= ' %{BradLabel(' . tabpagenr() . ')} '
	return s
endfunction " }}}
" }}}

" {{{ filetypes ===============================================================
"   {{{ ftl 
augroup ft_ftl
	au!
	au FileType ftl setlocal tabstop=2
	au FileType ftl setlocal shiftwidth=2
	au FileType ftl setlocal foldmethod=indent
	au FileType ftl setlocal foldlevel=4
	au FileType ftl setlocal filetype=html.ftl
	au FileType ftl inoremap <c-return> <esc>A;<esc>^
augroup END
"   }}}
"   {{{ html 
augroup ft_html
	au!
	au FileType html setlocal tabstop=2
	au FileType html setlocal shiftwidth=2
	au FileType html setlocal foldmethod=indent
	au FileType html setlocal foldlevel=4
	au FileType html inoremap <c-return> <esc>A;<esc>^
augroup END
"   }}}
"   {{{ java 
augroup ft_java
	au!
	au FileType java setlocal foldmethod=marker
	au FileType java setlocal foldmarker={,}
	au FileType java setlocal foldlevel=1
	au FileType java inoremap <c-return> <esc>A;<esc>^
augroup END
"   }}}
"   {{{ javascript 
augroup ft_javascript
	au!
	au FileType javascript setlocal foldmethod=marker
	au FileType javascript setlocal foldmarker={,}
	au FileType javascript setlocal foldlevel=1
	au FileType javascript inoremap <c-return> <esc>A;<esc>^
augroup END
"   }}}
"   {{{ xml 
augroup ft_xml
	au!
	au FileType xml setlocal foldmethod=syntax
	au FileType xml setlocal foldlevel=2
	au FileType xml setlocal shiftwidth=2
	au FileType xml setlocal tabstop=2
augroup END
"   }}}
" }}}
