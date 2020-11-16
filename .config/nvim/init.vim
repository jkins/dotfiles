" {{{ settings ================================================================

let mapleader = ","
let g:mapleader = ","
let localleader = "\\"

" * means value modified elsewhere
set noautochdir           " change working dir to current buffer
set autoread            " autorefresh buffer when file changes
"set autoindent          " copy indent from previous line
set autowrite           " autosave when leaving buffers
set backspace=indent,eol,start " backspace behavior in insert mode 
set backup              " *use backup ~ files
set backupcopy=yes      "
set backupdir^=~/tmp//,$VIMRUNTIME/temp//
set cmdheight=2         " commandbar height
set completeopt=longest,menuone
"set copyindent          " copy previous indent style
set directory^=~/.vim/tmp//,$VIMRUNTIME/temp//
set encoding=utf-8
set expandtab
set fileformats=unix
set fillchars=fold:-,vert:▒
set foldlevelstart=0    " *dont open folds
set foldtext=MyFoldText()
set formatoptions=cqjn  " see :help fo-table
set gdefault            " substitute whole line by default
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-cursor/lcursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175
set hidden              " change buffer without saving
set history=1000
set hlsearch            " highlight search terms
set ignorecase          " lowercase search => case insensitive search
set incsearch           " search as you type
set laststatus=2        " statusline is always second-to-last line
set lazyredraw          " don't redraw when executing macros
set listchars=tab:⇥\ ,trail:⍁,eol:↲,precedes:‹,extends:›
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
set shortmess=catI       " short messages
set showbreak=↪
set showmatch           " highlight matching search items
set showmode            " show the mode in the status bar
set showtabline=1       " show tabline when there's more than one tab
set sidescrolloff=5    " keep cursor n columns away from edge
set signcolumn=yes
set smartcase           " different cases make search case-sensitive
"set smartindent
set smarttab
if exists("+spelllang")
  set spelllang=en_US
endif
set suffixes+=.class    " don't autocomplete these extensions
set noswapfile
set tabstop=4           " a tab is 4 characters wide
set tags=./tags;/,~/tags
set textwidth=80         " auto-newline after n chars (0 disabled)
set tildeop             " ~ behaves like an operator
set timeoutlen=400      " ms before mappings are accepted
set title               " vim can change window title
set undodir=~/.vim/undo//,$VIMRUNTIME/undo// " persistent undo
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


" {{{ plugins vim-plug ========================================================
call plug#begin('~/.local/share/nvim/plugged')

Plug 'PeterRincker/vim-argumentative'
Plug 'lambdalisue/vim-pager'
Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/html5.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-git'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'posva/vim-vue'

Plug 'pangloss/vim-javascript' "{{{
"}}}

Plug 'Raimondi/delimitMate' "{{{
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
"}}}

"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "{{{
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#omni_patterns = {}
""let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
"let g:deoplete#auto_completion_start_length = 2
"let g:deoplete#sources = {}
"let g:deoplete#sources._ = []
"let g:deoplete#file#enable_buffer_path = 1
""}}}

Plug 'easymotion/vim-easymotion' "{{{
let g:EasyMotion_do_mapping = 0 " Disable default mapping
" nmap <space> <Plug>(easymotion-overwin-f2)
nmap <space> <Plug>(easymotion-overwin-w)
nmap <tab> <Plug>(easymotion-overwin-line)
"}}}

Plug 'int3/vim-extradite' "{{{
" git log
nmap <leader>gl :Extradite<cr>
"}}}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } "{{{
Plug 'junegunn/fzf.vim'
nmap <leader>f :GFiles<cr>
nmap <leader>F :GFiles?<cr>
nmap <leader>b :Buffers<cr>
"}}}

Plug 'junegunn/rainbow_parentheses.vim' "{{{

"}}}

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }} "{{{
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
"}}}

Plug 'mileszs/ack.vim' "{{{
let g:ackprg = 'ag --vimgrep'
"}}}

"Plug 'nathanaelkane/vim-indent-guides' "{{{
"highlight IndentGuidesOdd ctermbg=darkgrey
"highlight IndentGuidesEven ctermbg=8
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1
""}}}

Plug 'Yggdroot/indentLine' "{{{
let g:indentLine_setColors=0
let g:indentLine_char='┆'
"}}}

"Plug 'SirVer/ultisnips' "{{{
"let g:UltiSnipsExpandTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
""}}}

Plug 'honza/vim-snippets' "{{{
"}}}

Plug 'simnalamburt/vim-mundo' "{{{
nmap <leader>u :MundoToggle<cr>
"}}}

Plug 'tpope/vim-fugitive' "{{{
" git status
nmap <leader>gs :Gstatus<cr>
" git quickfix last log entries
nmap <leader>gq :Glog<cr>
" git diff
nmap <leader>gd :Gdiff<cr>
" git blame
nmap <leader>gb :Gblame<cr>
" git commit
nmap <leader>gc :Gcommit<cr>
" git read (effectively reverts the current buffer to the index version)
nmap <leader>gr :Gread<cr>
"}}}

Plug 'vim-airline/vim-airline' "{{{
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_inactive_collapse=1
let g:airline_left_sep='▛'
let g:airline_right_sep='▜'
let g:airline_theme="murmur"
"}}}

Plug 'bfredl/nvim-miniyank' "{{{
nmap <leader>P <Plug>(miniyank-startPut)
"}}}

"Plug 'artur-shaik/vim-javacomplete2' "{{{
"}}}
"
Plug 'JalaiAmitahl/maven-compiler.vim' "{{{
"}}}

call plug#end()
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
au! bufwritepost $MYVIMRC source $MYVIMRC

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


" {{{ mappings ================================================================

" delete buffer without closing split, also close location windows
nnoremap <silent> <leader>x :lclose<bar>b#<bar>bd #<CR>

" Don't move on *
nnoremap * *<c-o>

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

" format entire file and jump back
nnoremap g= gg=Gg``

" clear search results
nnoremap <leader><space> :noh<cr>

" wrapped lines treated as separate when moving up and down
nnoremap j gj
nnoremap k gk

" split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" escape terminal
" tnoremap <Esc> <C-\><C-N>

" fast save
nnoremap <leader>w :w!<cr>
vnoremap <leader>w :w!<cr>

" switch to directory of open buffer
nnoremap <leader>cd :cd %:p:h<cr>

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
nnoremap <M-j> :m+<CR>
nnoremap <M-h> <<
nnoremap <M-l> >>
nnoremap <M-k> :m-2<CR>
inoremap <M-j> <Esc>:m+<CR>gi
inoremap <M-k> <Esc>:m-2<CR>gi
inoremap <M-h> <Esc><<`]a
inoremap <M-l> <Esc>>>`]a
vnoremap <M-j> :m'>+<CR>gv
vnoremap <M-k> :m-2<CR>gv
vnoremap <M-h> <gv
vnoremap <M-l> >gv

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

" 'replace' a line - comment it out and place a fresh copy below
nmap <leader>r :copy .<cr>kgccj
vmap <leader>r :copy '>+<cr>gvgc`[

" easier system clipboard copy/paste
nnoremap <silent> <leader>y "+y
vnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p
vnoremap <silent> <leader>p "+p

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

" quickfix (copen)
nnoremap <silent> <F7> :call g:ToggleQuickFix()<cr>
" vimrc
nnoremap <leader>rc :e $MYVIMRC<cr>
" }}} =========================================================================


" {{{ functions ===============================================================
function! g:ToggleQuickFix() " {{{
  let l:nr = winnr("$")
  if l:nr == 1
    copen
  else
    cclose
  endif
endfunc " }}}

" toggles none->absolute->relative line numbers       
function! g:ToggleNuMode() " {{{
  if(&number)
    if(&relativenumber)
      setlocal norelativenumber
      setlocal nonumber
    else
      setlocal relativenumber
    endif
  else
    setlocal number
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
set colorcolumn=1,80,120
set cursorline
set foldcolumn=0
set list
function! g:ToggleShowDetails() " {{{
  if(&list)
    set colorcolumn=
    set cursorline
    "set foldcolumn=0
    "silent IndentGuidesDisable
    silent IndentLinesDisable
  else
    set colorcolumn=1,80,120
    "set foldcolumn=1
    set nocursorline
    "silent IndentGuidesEnable
    silent IndentLinesEnable
  endif
  silent RainbowToggle
  set list!
endfunc " }}}

" {{{ au / filetypes ==========================================================
augroup term " {{{
  au!
  au TermOpen * setlocal nonumber
augroup END " }}}

augroup ft_vim " {{{
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType vim setlocal foldmarker={{{,}}}
  au FileType vim setlocal tabstop=2
augroup END " }}}
augroup ft_coffee " {{{
  au!
  au FileType coffee setlocal foldmethod=indent
  au FileType coffee setlocal tabstop=2
  au FileType coffee setlocal foldlevel=1
augroup END " }}}
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
augroup ft_md " {{{
  au!
  au FileType md setlocal textwidth=80
augroup END " }}}
augroup ft_netrw " {{{
  au!
  au FileType netrw setlocal nomodifiable nolist colorcolumn=
augroup END " }}}
augroup ft_java " {{{
  au!
  " eclim correction
  au FileType java nnoremap <silent> <buffer> <localleader><localleader> :JavaCorrect<cr>
  " completion
  au FileType java inoremap <buffer> <localleader><tab> <C-X><C-U>
  " Java import
  au FileType java nnoremap <silent> <buffer> <localleader>i :JavaImport<cr>
  " Java import organize
  au FileType java nnoremap <silent> <buffer> <localleader>I :JavaImportOrganize<cr>
  au FileType java setlocal foldmethod=marker
  au FileType java setlocal foldmarker={,}
  au FileType java setlocal foldlevel=1
  au FileType java setlocal foldmethod=marker
  au FileType java setlocal shiftwidth=4
  au FileType java setlocal omnifunc=javacomplete#Complete
  "au FileType java inoremap ; <C-o>A;
  "au FileType java inoremap { {<CR><CR>}<C-o>k<TAB><TAB>
  "au FileType java inoremap  <C-o>A;<CR>
  au FileType java compiler mvn
  "au FileType java setlocal makeprg=mvn\ -q\ install
  "au BufEnter pom.xml setlocal makeprg=mvn\ -q\ install
  "au FileType java let b:delimitMate_eol_marker = ";"
  au FileType java nnoremap <F5> :make compile<CR>
  au FileType java nnoremap <S-F5> :make clean compile<CR>
  au FileType java nnoremap <F6> :make install<CR>
  au FileType java nnoremap <S-F6> :make clean install<CR>
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
  au FileType json setlocal conceallevel=0
  au FileType json setlocal expandtab
  au FileType json setlocal foldmethod=syntax
  au FileType json setlocal foldmarker={,}
  au FileType json setlocal foldlevel=1
augroup END " }}}
augroup ft_pom " {{{
  au!
  au FileType pom compiler mvn
augroup END " }}}
augroup ft_xml " {{{
  au!
  au FileType xml setlocal expandtab
  au FileType xml setlocal foldmethod=syntax
  au FileType xml setlocal foldlevel=2
  au FileType xml setlocal shiftwidth=2
  au FileType xml setlocal tabstop=2
  au FileType xml setlocal equalprg=xmllint\ --format\ -
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

" {{{ colorscheme
colorscheme jkins-space-transparent
" }}}

