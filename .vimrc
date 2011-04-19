" jeff kinslow vimrc
" =============================================================================

" pathogen
" =============================================================================
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype on
filetype plugin indent on

" windows
" =============================================================================
if has("win32")
	source $VIMRUNTIME/mswin.vim
	behave mswin
	"this is breaking fugitive, not that important
	"set shell=C:/cygwin/bin/bash
	"set shellcmdflag=--login\ -c
	"set shellxquote=\"
endif

" gvim
" =============================================================================
if has("gui_running")
	set guifont=Consolas:h12:cANSI
	set guioptions-=m	" turn off menu bar
	set guioptions-=T	" turn off tool bar

	" zoom levels
	noremap <f1> :set guifont=Consolas:h3:cANSI<CR>
	noremap <f2> :set guifont=Consolas:h10:cANSI<CR>
	noremap <f3> :set guifont=Consolas:h12:cANSI<CR>
	noremap <f4> :set guifont=Consolas:h18:cANSI<CR>
endif

" language
" =============================================================================
try
	lang en_US
catch
endtry

" events/autocmd
" =============================================================================
" position window at start
" au GUIEnter * winpos 100 100
" leave insert mode after 15sec of no input
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore
" no line numbers for some buffers
au FileType nerdtree setlocal nonu
au FileType taglist setlocal nornu
au FileType fuf setlocal nornu
au FileType fugitiveblame setlocal nu
au FileType extradite setlocal nu
au FileType qf setlocal nornu
" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source $MYVIMRC
autocmd! bufwritepost _vimrc source $MYVIMRC	" windows


" colors
" =============================================================================
syntax enable
colorscheme jkins

" settings
" =============================================================================
set autoread			" autorefresh buffer when file changes
set autoindent
set backspace=indent,eol,start
set backup				" use backup ~ files
set backupdir=$VIMRUNTIME\\temp\\
set cmdheight=2			" commandbar height
set colorcolumn=80,120
set columns=90
set completeopt=longest,menuone
set copyindent			" copy previous indent
set cursorline			" highlight the current line
set directory=$VIMRUNTIME\\temp\\
set encoding=utf-8
set ffs=unix,dos		" default file types
set foldmethod=indent
set formatoptions=qrn1	" :help fo-table
set gdefault			" do replacements globally
set hidden				" change buffer without saving
set history=1000
set hls 				" highlite search
set hlsearch
set ignorecase			" lowercase search => case insensitive
set incsearch			" search as you type
set laststatus=2		" always hide the statusline
set lines=45
set listchars=tab:»\ ,trail:·,eol:¬
"set magic				" leave magic at default settings
set modelines=0
set nocompatible		" don't need vi compatibility
set nolazyredraw		" don't redraw when executing macros
set nowrap				" don't wrap text
set rnu					" change line numbers relative to current line
set ruler				" show line/column in status bar
set scrolloff=5			" keep current line n lines away from edge
set shiftround
set shiftwidth=4
set sidescrolloff=10	" keep current line n columns away from edge
set shortmess=atI		" short messages
set showmatch			" highlight matching search items
set showmode			" show the mode in the status bar
set showtabline=2		" show tabline all the time
set smartcase			" different case   => case   sensitive
set smartindent			" TODO	
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ %{strftime(\"%a\ %m/%d/%y\ %I:%M\ %p\",\ getftime(expand('%')))}\ (%{&ff}){%Y}[%l,%v][%p%%]
set smarttab
set tabstop=4			" a tab is 4 characters wide
set textwidth=0			" auto-newline after n chars (0 disabled)
set title
set ttyfast
set undodir=$VIMRUNTIME\\undo\\
set undofile			" persistent undo
set visualbell			" flash editor instead of beeping on error
set wildmenu
set wildmode=list:longest

" plugin settings
" =============================================================================
" taglist
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 30
" showmarks
let showmarks_ignore_type = "hmpq"

" mappings
" =============================================================================
let mapleader = ","
let g:mapleader = ","
" Leave cursor at position before editing started after repeat
nmap . .`[
" Repeat on all lines in visual selection
vnoremap <silent> . :normal .<cr>
" reselect selection after indenting
vnoremap > >gv
vnoremap < <gv
" quick exit insert mode with jj
inoremap jj <ESC>
" no need to hit shift to access command mode
nnoremap ; :
" clear search results
nnoremap <leader><space> :noh<cr>
" easier line+column markers
nnoremap ' `
" no movement training wheels
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
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
" tab movement
nnoremap <M-h> :tabp<cr>
nnoremap <M-l> :tabn<cr>
" sort selection
vnoremap <leader>S :sort<cr>
" fast save
nmap <leader>w :w!<cr>
" switch to directory of open buffer
map <leader>cd :cd %:p:h<cr>
" / is search, <leader>/ is regex, see :help magic
nnoremap / /\V
nnoremap <leader>/ /\v
nnoremap ? ?\V
nnoremap <leader>? ?\v
" move a line of text using ALT+[jk], indent with ALT+[hl]
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
ino <silent> <tab> <c-r>=TriggerSnippet()<cr>
snor <silent> <tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
ino <silent> <s-tab> <c-r>=BackwardsSnippet()<cr>
snor <silent> <s-tab> <esc>i<right><c-r>=BackwardsSnippet()<cr>
ino <silent> <c-r><tab> <c-r>=ShowAvailableSnips()<cr>

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
nnoremap <leader>op :YRShow<cr>
" config - rc - vimrc
nnoremap <leader>oc :tabnew $MYVIMRC<cr>
" split - vertical split and switch to it
nnoremap <leader>ovs <C-w>v<C-w>l
" split - horizontal split and switch to it
nnoremap <leader>ohs <C-w>s
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
nnoremap <leader>qn :cn<cr>
nnoremap <leader>qp :cp<cr>

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

" visual * search (not working)
" =============================================================================
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" vim default MyDiff
" =============================================================================
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

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
		winpos 100 100
	else
		simalt ~x
	endif
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
" EOF
