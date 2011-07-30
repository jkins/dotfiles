" jeff kinslow vimrc
" =============================================================================

" pathogen
" =============================================================================
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on
filetype plugin indent on

" settings    * value modified elsewhere
" =============================================================================
set autoread            " autorefresh buffer when file changes
set autoindent          " copy indent from previous line
set autowrite           " autosave when leaving buffers
set backspace=indent,eol,start
set backup              " use backup ~ files
set backupdir^=~/tmp//,$VIMRUNTIME/temp//
set cmdheight=2         " commandbar height
set colorcolumn=80,120
set completeopt=longest,menuone
set copyindent          " copy previous indent
set cursorline          " * highlight the current line
set directory^=~/tmp//,$VIMRUNTIME/temp//
set encoding=utf-8
set ffs=unix,dos        " default file types
set foldmethod=indent   " fold lines at indentation
set formatoptions=qrn1  " see :help fo-table
set guitablabel=%!MyGuiTabLine()
set hidden              " change buffer without saving
set history=1000
set hlsearch            " highlight search terms
set ignorecase          " lowercase search => case insensitive
set incsearch           " search as you type
set laststatus=2        " statusline is always second-to-last line
set lazyredraw          " don't redraw when executing macros
set listchars=tab:»\ ,trail:·,eol:¬
"set magic              " leave magic at default settings
set makeprg=ant\ -emacs
set modelines=5
set mouse=nvi
set mousemodel=popup    " popup menu on right-click
set nocompatible        " don't need vi compatibility
set nowrap              " don't wrap text
set printoptions=paper:letter
set rnu                 " line numbers relative to current line
set ruler               " show line/column in status bar
set scrolloff=5         " keep current line n lines away from edge
set shellpipe="2>"      " *
set shiftround
set shiftwidth=4
set shortmess=atI       " short messages
set showmatch           " highlight matching search items
set showmode            " show the mode in the status bar
set showtabline=2       " show tabline all the time
set sidescrolloff=10    " keep cursor n columns away from edge
set smartcase           " different cases make search case-sensitive
"set smartindent
" looks like: /path/to/file [Git(master)] Tue 01/23/00 12:22 PM (unix){JAVA}[114,65][30%]
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ %{strftime(\"%a\ %m/%d/%y\ %I:%M\ %p\",\ getftime(expand('%')))}\ (%{&ff}){%Y}[%l,%v][%p%%]
set smarttab
if exists("+spelllang")
	set spelllang=en_US
endif
set suffixes+=.class    " don't autocomplete these extensions
set tabstop=4           " a tab is 4 characters wide
set tabline=%!MyTabLine()
set textwidth=0         " auto-newline after n chars (0 disabled)
set title
set ttyfast
set undodir=$VIMRUNTIME\\undo\\
set undofile            " persistent undo
set virtualedit=block
set visualbell          " flash editor instead of beeping on error
set wildmenu
set wildmode=list:longest,full,full

" windows
" =============================================================================
if has("win32") || has("win64") || has("dos32") || has("dos16")
	let g:mswindows=1
	source $VIMRUNTIME/mswin.vim
	behave mswin
	if $PATH =~? 'cygwin' && !exists("g:no_cygwin_shell")
		set shell=bash
		set shellpipe=2>&1\|tee
		set shellslash
	endif
endif

" gvim
" =============================================================================
if has("gui_running")
	if g:mswindows
		set guifont=Consolas:h12:cANSI
		" zoom levels
		noremap <f1> :set guifont=Consolas:h3:cANSI<CR>
		noremap <f2> :set guifont=Consolas:h10:cANSI<CR>
		noremap <f3> :set guifont=Consolas:h12:cANSI<CR>
		noremap <f4> :set guifont=Consolas:h18:cANSI<CR>
	else
		set guifont=Inconsolata:h12:cANSI
		" zoom levels
		noremap <f1> :set guifont=Inconsolata:h3:cANSI<CR>
		noremap <f2> :set guifont=Inconsolata:h10:cANSI<CR>
		noremap <f3> :set guifont=Inconsolata:h12:cANSI<CR>
		noremap <f4> :set guifont=Inconsolata:h18:cANSI<CR>

	endif

	set guioptions-=m    " turn off menu bar
	set guioptions-=T    " turn off tool bar
	
	" start at 45x90
	set columns=90
	set lines=45
endif

" language
" =============================================================================
try
	lang en_US
catch
endtry

" events/autocmd
" =============================================================================
" leave insert mode after 15sec of no input
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore
" no line numbers for some buffers
au FileType nerdtree setlocal nonu
au FileType taglist setlocal nornu
au FileType taglist setlocal colorcolumn= statusline="Tag List"
au FileType fuf setlocal nornu
au FileType fugitiveblame setlocal nu
au FileType extradite setlocal nu
au FileType qf setlocal nornu nocursorline colorcolumn=
" When vimrc is edited, reload it
au! bufwritepost .vimrc source $MYVIMRC
au! bufwritepost _vimrc source $MYVIMRC    " windows

" Enable cursorline only in the current buffer
au BufEnter * setlocal cursorline
au BufLeave * setlocal nocursorline

" Normal line numbers in diff
au FilterWritePost * if &diff | set nu | else | set rnu | endif

" colors
" =============================================================================
syntax enable
colorscheme jkins
"colorscheme solarized

" plugin settings
" =============================================================================
" taglist
let g:Tlist_Show_One_File = 1
let g:Tlist_Use_Right_Window = 1
let g:Tlist_WinWidth = 30
" showmarks
let g:showmarks_ignore_type = "hmpq"
let g:showmarks_hlline_lower = 1
let g:showmarks_hlline_upper = 1
let g:showmarks_hlline_other = 0

" mappings
" =============================================================================
let mapleader = ","
let g:mapleader = ","
" leave cursor at position before editing started after repeat
nnoremap . .'[
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
" no movement training wheels
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
" wrapped lines treated as separate when moving up and down
nnoremap j gj
nnoremap k gk
" big movements by 10
nnoremap <s-h> 10h
nnoremap <s-j> 10j
nnoremap <s-k> 10k
nnoremap <s-l> 10l
vnoremap <s-h> 10h
vnoremap <s-j> 10j
vnoremap <s-k> 10k
vnoremap <s-l> 10l
" split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" tab movement (like unimpaired)
nnoremap [t :tabp<cr>
nnoremap ]t :tabn<cr>
" sort selection
vnoremap <leader>S :sort<cr>
" fast save
nmap <leader>w :w!<cr>
" switch to directory of open buffer
map <leader>cd :cd %:p:h<cr>
" Build
map <leader>B :call g:MyMake()<cr>
" / is literal search, <leader>/ is regex search, see :help magic
nnoremap / /\V
nnoremap ? ?\V
nnoremap <leader>/ /\v
nnoremap <leader>? ?\v
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
" transparency on win32
nnoremap <leader>T :call g:ToggleTrans()<cr>
" toggle maximization
nnoremap <leader>M :call g:ToggleMax()<cr>
" snipmate
inoremap <silent> <tab> <c-r>=TriggerSnippet()<cr>
snoremap <silent> <tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
inoremap <silent> <s-tab> <c-r>=BackwardsSnippet()<cr>
snoremap <silent> <s-tab> <esc>i<right><c-r>=BackwardsSnippet()<cr>
inoremap <silent> <c-r><tab> <c-r>=ShowAvailableSnips()<cr>

" SHOW
" =============================================================================
" details - tab/eol/whitespace chars
nnoremap <leader>sd :call g:ToggleShowDetails()<cr>
vnoremap <leader>sd :call g:ToggleShowDetails()<cr>
" numbers - absolute/relative line numbers
nnoremap <leader>sn :call g:ToggleNuMode()<cr>
vnoremap <leader>sn :call g:ToggleNuMode()<cr>
" tags
nnoremap <leader>st :TlistToggle<cr>
vnoremap <leader>st :TlistToggle<cr>

" OPEN 
" =============================================================================
" NERDTree explorer 
nnoremap <leader>on :NERDTree<cr>
" YankRing
nnoremap <leader>oy :YRShow<cr>
" config - vimrc
nnoremap <leader>oc :tabnew $MYVIMRC<cr>
" split - horizontal split and switch to it
nnoremap <leader>os <C-w>s
" split - vertical split and switch to it
nnoremap <leader>oS <C-w>v<C-w>l
" tab
nnoremap <leader>ot :tabnew<cr>
" marks
nnoremap <leader>om :marks<cr>
" registers
nnoremap <leader>or :register<cr>
" jumps
nnoremap <leader>oj :jumps<cr>
" file (fuzzy finder)
nnoremap <leader>of :FufCoverageFile<cr>
" quickfix (copen)
nnoremap <leader>oq :botright cope<cr>

" git (fugitive and extradite)
" =============================================================================
" status
nnoremap <leader>gs :Gstatus<cr>
" log
nnoremap <leader>gl :Extradite<cr>
" quickfix last log entries
nnoremap <leader>gq :Glog<cr>
" diff
nnoremap <leader>gd :Gdiff<cr>
" blame
nnoremap <leader>gb :Gblame<cr>
" commit
nnoremap <leader>gC :Gcommit<cr>
" read (effectively reverts the current buffer to the git checkout version)
nnoremap <leader>gr :Gread<cr>

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

" toggles relative/absolute line numbers       
" =============================================================================
function! g:ToggleNuMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc

" Shows tab characters/columns, trailing whitespace, newlines
" =============================================================================
function! g:ToggleShowDetails()
	if(&list == 0)
		set nocursorline
	else
		set cursorline
	endif
	set list!
endfunc

" Toggles between maximized and unmaximized mode
" =============================================================================
function! g:ToggleMax()
	let w:maximized = exists('w:maximized') ? !w:maximized : 0
	if w:maximized
		set columns=90
		set lines=45
	else
		simalt ~x
	endif
endfunc

" Make behaving strangely on Windows
" =============================================================================
function! g:MyMake()
	let f = $VIMRUNTIME . "\\temp\\.errorfile"
	execute "!ant -emacs > \"" . f . "\""
	execute "cfile" f
endfunc

" Toggles between ~90% and 100% opacity on windows
" =============================================================================
function! g:ToggleTrans()
	let w:trans = exists('w:trans') ? !w:trans : 1
	if w:trans
		:call libcallnr("vimtweak.dll", "SetAlpha", 225)
	else
		:call libcallnr("vimtweak.dll", "SetAlpha", 255)
	endif
endfunc

" Makes tab names be the basename of the file instead of the path
" see http://bradgrissom.com/index.php?/archives/61-Rename-tabs-in-Vim.html
" =============================================================================
function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i + 1 == tabpagenr()
			let s .= '%&TabLineSel;'
		else
			let s .= '%&TabLine;'
		endif

		" set the tab page number (for mouse clicks)
		let s .= '%' . (i + 1) . 'T'

		" the label is made by MyTabLabel()
		"let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
		let s .= ' %{BradLabel(' . (i + 1) . ')} '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s .= '%&TabLineFill;%T'

	" right-align the label to close the current tab page
	if tabpagenr('$') > 1
		let s .= '%=%&TabLine;%999Xclose'
	endif

	return s
endfunction

function! BradLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr   = tabpagewinnr(a:n)
	let bufnam  = bufname(buflist[winnr - 1])
	" This is getting the basename() of bufname above
	let base    = substitute(substitute(bufnam, '.*\', '', ''), '.*/', '', '')
	let name    = a:n . ' ' . base
	return name
endfunction

function! MyTabLabel(n)
	let buflist = tabpagebuflist(a:n)
	let winnr = tabpagewinnr(a:n)
	return bufname(buflist[winnr - 1])
endfunction

function! MyGuiTabLine()
	let s = ''
	let s .= ' %{BradLabel(' . tabpagenr() . ')} '
	return s
endfunction

" EOF
