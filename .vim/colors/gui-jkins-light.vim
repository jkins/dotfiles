" gui-jkins-light - vim colorscheme
" author: Jeff Kinslow

set background=light
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "gui-jkins-light"

" gui
" ============================================================================
" COLORS
" Dark Blue   #011526
" Deep Blue   #011C40
" Slate Blue  #315969
" Green       #2CA32E
" Red         #9C190B

hi Normal           guibg=#F0F0F0 guifg=#000000 gui=none   
hi ColorColumn      guibg=#E5E5E5               gui=none   
hi Comment                        guifg=#555555 gui=italic   
hi Constant                       guifg=#007F7F gui=none   
hi Cursor           guibg=#151515 guifg=#EFEFEF gui=none   
hi CursorColumn     guibg=#E0E0E0               gui=none   
hi CursorLine       guibg=#E0E0E0               gui=none   
hi CursorLineNr     guibg=#2F2F2F guifg=#009FFF gui=none
hi DiffAdd          guibg=#CCF0CC               gui=none   
hi DiffChange       guibg=#F0F0C0               gui=none   
hi DiffDelete       guibg=#F0CCCC guifg=#3F3F3F gui=none   
hi DiffText         guibg=#F0F05F               gui=none   
hi Directory                      guifg=#5F5F5F gui=none   
hi Error            guibg=#DFDFDF guifg=#E8594E gui=none   
hi ErrorMsg         guibg=#E8594E               gui=none   
hi Folded           guibg=#151525 guifg=#AFAFAF gui=none   
hi Function                       guifg=#C00000 gui=none
hi Identifier                     guifg=#00007F gui=none   
hi Ignore                         guifg=#3F3F3F gui=none   
hi IncSearch        guibg=#000000 guifg=#00FF00 gui=none   
hi Include                        guifg=#C00000 gui=none
hi Keyword                        guifg=#0000C0 gui=none   
hi LineNr           guibg=#1F1F1F guifg=#C0C0C0 gui=none   
hi MatchParen       guibg=#A0A07F               gui=none   
hi ModeMsg          guibg=#00F07F guifg=#000000 gui=none
hi NonText          guibg=#D0D0D0 guifg=#A0A0A0 gui=none   
hi Number                         guifg=#007F7F gui=none   
hi Pmenu            guibg=#0F0F8F guifg=#C0C0C0 gui=none
hi PmenuSel         guibg=#2F2FAF guifg=#F0F0F0 gui=none
hi PmenuSbar        guibg=#0F0F6F guifg=#000000 gui=none
hi PmenuThumb       guibg=#4F4FCF guifg=#FFFFFF gui=none
hi Operator                       guifg=#F04521 gui=none   
hi PreProc                        guifg=#F04521 gui=none   
hi Question                       guifg=#58E887 gui=none   
hi Search           guibg=#00F000 guifg=#000000 gui=none   
hi SignColumn       guibg=#FF0000 guifg=#000000 gui=none
hi Special                        guifg=#3F3F3F gui=none
hi Statement                      guifg=#7F0000 gui=none   
hi StatusLine       guibg=#1F1F1F guifg=#C0C0C0 gui=none   
hi StatusLineNC     guibg=#000000 guifg=#7F7F7F gui=none   
hi String                         guifg=#007F00 gui=none   
hi TabLine          guibg=#E0E0E0 guifg=#5F5F5F gui=underline
hi TabLineSel       guibg=#00007F guifg=#FFFFFF gui=none
hi TabNum           guibg=#E0E0E0 guifg=#5F5F5F gui=underline
hi TabNumSel        guibg=#0000FF guifg=#C0C0C0 gui=none
hi TabLineFill      guibg=#E0E0E0 guifg=#3F3F3F gui=underline
hi Title                          guifg=#00717D gui=none   
hi Type                           guifg=#00007F gui=none
hi Todo             guibg=#F0F05F guifg=#003647 gui=bold,underline
hi Underlined                                   gui=none   
hi VertSplit        guibg=#000000 guifg=#C0C0C0 gui=none   
hi Visual           guibg=#007FF0 guifg=#F0F0F0 gui=none   
hi WildMenu         guibg=#0000FF guifg=#FF0000 gui=none   

" xml
hi xmlAttrib gui=none guifg=#000000 
hi xmlEndTag gui=none guifg=#7F0000
hi xmlEqual gui=none guifg=#00007F
hi xmlTag        gui=none    guifg=#00007F
hi xmlTagName  gui=none    guifg=#00007F

" html
hi htmlArg gui=none guifg=#000000
hi htmlEndTag gui=none guifg=#C00000
hi htmlTag        gui=none    guifg=#00007F
hi htmlTagName  gui=none    guifg=#000000

" ftl
hi ftlEndDirective gui=none guifg=#C00000
hi ftlStartDirective gui=none guifg=#0000C0

" Easymotion
hi EasyMotionTarget   guibg=#000000 guifg=#007FF0
hi EasyMotionShade    guibg=#C0C0F0 guifg=#505050

" NERD Tree
hi NERDTreeCWD         guibg=#5F5F5F    guifg=#F0F0F0
hi NERDTreeClosable    guibg=#00007F    guifg=#F0F0F0
hi NERDTreeDirSlash                     guifg=#00007F
hi NERDTreeOpenable                     guifg=#00007F
hi NERDTreePart                         guifg=#5F5F5F
hi NERDTreePartFile                     guifg=#007F00
hi NERDTreeHelp                         guifg=#707070

" Tagbar
hi TagbarSignature guifg=#707070
hi TagbarAccessPublic guifg=#007F00
hi TagbarAccessPrivate guifg=#C00000
hi TagbarAccessProtected guifg=#00007F
hi TagbarScope guifg=#007F7F

" YankRing
hi yankringHeaders guifg=#00007F
hi yankringItemNumber guifg=#007F00

" green cursor line on insert mode
"autocmd InsertEnter * hi CursorLine guibg=#B9E9B9
"autocmd InsertLeave * hi CursorLine guibg=#D9D9D9
