" 256-jkins-dark - 256-color terminal vim colorscheme
" author: Jeff Kinslow

set background=dark
set t_Co=256
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "256-jkins-dark"

"hi Normal           ctermbg=233 ctermfg=253 cterm=none   
hi Normal           ctermbg=none ctermfg=253 cterm=none   
hi ColorColumn      ctermbg=234             cterm=none   
hi Comment                      ctermfg=245 cterm=none   
hi Constant                     ctermfg=042 cterm=none   
hi Cursor           ctermbg=254 ctermfg=000 cterm=none   
hi CursorColumn     ctermbg=234             cterm=none   
hi CursorLine       ctermbg=234             cterm=none   
hi CursorLineNr     ctermbg=233 ctermfg=027 cterm=none
hi DiffAdd          ctermbg=022             cterm=none   
hi DiffChange       ctermbg=058             cterm=none   
hi DiffDelete       ctermbg=052 ctermfg=233 cterm=none   
hi DiffText         ctermbg=100             cterm=none   
hi Directory                    ctermfg=111 cterm=none   
":hi Error            ctermbg=#DFDFDF ctermfg=#E8594E cterm=none   
":hi ErrorMsg         ctermbg=#E8594E               cterm=none   
hi FoldColumn       ctermbg=232 ctermfg=019 cterm=none   
hi Folded           ctermbg=232 ctermfg=240 cterm=none   
hi Function                     ctermfg=160 cterm=none
hi Identifier                   ctermfg=027 cterm=none   
hi Ignore                       ctermfg=240 cterm=none   
hi IncSearch        ctermbg=002 ctermfg=000 cterm=none   
hi Include                      ctermfg=196 cterm=none
hi Keyword                      ctermfg=038 cterm=none   
hi LineNr           ctermbg=232 ctermfg=240 cterm=none   
hi MatchParen       ctermbg=239             cterm=none   
hi ModeMsg          ctermbg=010 ctermfg=000 cterm=none
hi NonText          ctermbg=none ctermfg=234 cterm=none   
hi Number                       ctermfg=042 cterm=none   
hi Pmenu            ctermbg=232 ctermfg=240 cterm=none
hi PmenuSel         ctermbg=027 ctermfg=232 cterm=none
hi PmenuSbar        ctermbg=000             cterm=none
hi PmenuThumb       ctermbg=235             cterm=none
hi Operator                     ctermfg=009 cterm=none   
hi PreProc                      ctermfg=208 cterm=none   
hi Question                     ctermfg=226 cterm=none   
hi Search           ctermbg=010 ctermfg=000 cterm=none   
hi SignColumn       ctermbg=232 ctermfg=021 cterm=none
hi Special                      ctermfg=249 cterm=none
hi Statement                    ctermfg=038 cterm=none 
hi StatusLine       ctermbg=234 ctermfg=255 cterm=none   
hi StatusLineNC     ctermbg=234 ctermfg=246 cterm=none   
hi String                       ctermfg=040 cterm=none   
hi TabLine          ctermbg=234 ctermfg=243 cterm=underline
hi TabLineSel       ctermbg=027 ctermfg=254 cterm=none
hi TabNum           ctermbg=234 ctermfg=243 cterm=underline
hi TabNumSel        ctermbg=027 ctermfg=254 cterm=none
hi TabLineFill      ctermbg=232 ctermfg=243 cterm=underline
hi Title                        ctermfg=045 cterm=none
hi Type                         ctermfg=027 cterm=none
hi Todo             ctermbg=226 ctermfg=017 cterm=underline
hi Underlined                                   cterm=none   
hi VertSplit         ctermfg=000 cterm=none   
hi Visual           ctermbg=012 ctermfg=232 cterm=none   
hi WildMenu         ctermbg=017 ctermfg=248 cterm=none   

" xml
hi xmlAttrib   ctermfg=109 cterm=none
hi xmlAttribPunct   ctermfg=033 cterm=none
hi xmlEndTag   ctermfg=101 cterm=none
"hi xmlEqual    cterm=none ctermfg=#00007F
hi xmlTag      ctermfg=033 cterm=none 
hi xmlTagName  ctermfg=039 cterm=none
hi xmlEqual    ctermfg=033 cterm=none
hi xmlString   ctermfg=153 cterm=none

" html
":hi htmlArg cterm=none ctermfg=#000000
":hi htmlEndTag cterm=none ctermfg=#C00000
":hi htmlTag        cterm=none    ctermfg=#00007F
":hi htmlTagName  cterm=none    ctermfg=#000000

" ftl
":hi ftlEndDirective cterm=none ctermfg=#C00000
":hi ftlStartDirective cterm=none ctermfg=#0000C0

" Easymotion
"hi EasyMotionTarget   ctermbg=232 ctermfg=039
"hi EasyMotionShade    ctermbg=234 ctermfg=240
"hi EasyMotionTarget2First ctermbg=232 ctermfg=027
"hi EasyMotionTarget2Second ctermbg=232 ctermfg=027
hi EasyMotionTarget   ctermbg=232 ctermfg=039
hi EasyMotionShade    ctermfg=240
hi EasyMotionTarget2First ctermbg=232 ctermfg=027
hi EasyMotionTarget2Second ctermbg=232 ctermfg=027

" NERD Tree
hi NERDTreeCWD         ctermbg=236 ctermfg=247
hi NERDTreeClosable    ctermbg=027 ctermfg=000
hi NERDTreeDirSlash                ctermfg=012
hi NERDTreeOpenable                ctermfg=012
hi NERDTreePart                    ctermfg=236
hi NERDTreePartFile                ctermfg=010
"hi NERDTreeHelp                   ctermfg=#707070

" Tagbar
hi TagbarAccessPublic    ctermfg=040
hi TagbarAccessPrivate   ctermfg=196
hi TagbarAccessProtected ctermfg=012
hi TagbarFoldIcon        ctermfg=027
hi TagbarNestedKind      ctermbg=027 ctermfg=254
hi TagbarSignature       ctermfg=245
hi TagbarScope           ctermfg=012

" CtrlP
hi CtrlPMatch ctermbg=232 ctermfg=027

" YankRing
":hi yankringHeaders ctermfg=#00007F
":hi yankringItemNumber ctermfg=#007F00
