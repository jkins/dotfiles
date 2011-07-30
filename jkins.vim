" jeff kinslow - vim theme
" modified wombat
" 
" help topics:
" :he group-name
" :he highlight-groups
" :he cterm-colors
" and :edit $VIMRUNTIME/colors/README.txt

set background=dark
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif
let g:colors_name = "jkins"

" gui
" ============================================================================
" COLORS
" Orangered    #F04521
" Light Blue   #81A7FF
" Blue         #3D71EB
" Green        #3FB269
" Yellow       #FFE219

:hi Normal          gui=none    guibg=#101010    guifg=#D0D0D0
:hi ColorColumn     gui=none    guibg=#0C0C0C   
:hi Comment         gui=none                     guifg=#707070
:hi Constant        gui=none                     guifg=#FFE219
:hi Cursor          gui=none    guibg=#D0D0D0    guifg=#101010
:hi CursorColumn    gui=none    guibg=#2D2D2D   
:hi CursorLine      gui=none    guibg=#202020   
:hi DiffAdd         gui=none    guibg=#002400   
:hi DiffChange      gui=none    guibg=#19180A   
:hi DiffDelete      gui=none    guibg=#3B0500    guifg=#505050
:hi DiffText        gui=none    guibg=#2A291B   
:hi Directory       gui=none                     guifg=#A0A0A0
:hi Error           gui=none    guibg=#202020    guifg=#E8594E
:hi ErrorMsg        gui=none    guibg=#E8594E   
:hi FoldColumn      gui=none    guibg=#000000    guifg=#505050
:hi Folded          gui=none    guibg=#000000    guifg=#505050
:hi Function        gui=none                     guifg=#F04521
:hi Identifier      gui=none                     guifg=#F04521
:hi Ignore          gui=none                     guifg=#C0C0C0
:hi IncSearch       gui=none    guibg=#000000    guifg=#00FF00
:hi Include         gui=none                     guifg=#F04521
:hi Keyword         gui=none                     guifg=#7D0021
:hi LineNr          gui=none    guibg=#000000    guifg=#505050
:hi MatchParen      gui=none    guibg=#857B6F    guifg=#F6F3E8
:hi NonText         gui=none    guibg=#000000    guifg=#505050
:hi Number          gui=none                     guifg=#FFE219
:hi Pmenu           gui=none    guibg=#303030    guifg=#A0A0A0
:hi Operator        gui=none                     guifg=#F04221
:hi PreProc         gui=none                     guifg=#F04521
:hi Question        gui=none                     guifg=#58E887
:hi Search          gui=none    guibg=#58E887    guifg=#000000 
:hi Special         gui=none                     guifg=#A0A0A0
:hi SpellErrors     gui=none                     guifg=White
:hi Statement       gui=none                     guifg=#81A7FF
:hi StatusLine      gui=none    guibg=#A0A0A0    guifg=#000000
:hi StatusLineNC    gui=none    guibg=#505050    guifg=#000000
:hi String          gui=none                     guifg=#4FB269
:hi Title           gui=none                     guifg=#00717D
:hi Todo            gui=none    guibg=#F2D8A7    guifg=#003647
:hi Type            gui=none                     guifg=#3D71EB
:hi Underlined      gui=none   
:hi VertSplit       gui=none    guibg=#000000    guifg=#505050
:hi Visual          gui=none    guibg=#A0A0A0    guifg=#000055
:hi WildMenu        gui=none    guibg=#A0A0A0    guifg=#000055

" terminal
:hi Normal          cterm=none      ctermbg=Black     ctermfg=White
:hi ColorColumn     cterm=none      ctermbg=DarkGray
:hi Comment         cterm=none                        ctermfg=DarkGray
:hi Constant        cterm=none                        ctermfg=LightRed
:hi Cursor          cterm=none      ctermbg=White     ctermfg=DarkBlue
:hi CursorColumn    cterm=none      ctermbg=DarkGray
:hi CursorLine      cterm=none      ctermbg=DarkGray
:hi DiffAdd         cterm=none      ctermbg=DarkGreen
:hi DiffChange      cterm=none      ctermbg=Black
:hi DiffDelete      cterm=none      ctermbg=DarkRed   ctermfg=DarkGray
:hi DiffText        cterm=none      ctermbg=DarkGray  ctermfg=Yellow
:hi Directory       cterm=none      ctermfg=LightGray
:hi Error           cterm=none      ctermbg=DarkGray  ctermfg=DarkRed
:hi ErrorMsg        cterm=none      ctermbg=DarkGray  ctermfg=DarkRed
:hi FoldColumn      cterm=none      ctermbg=Black     ctermfg=DarkGray
:hi Folded          cterm=none      ctermbg=Black     ctermfg=DarkGray
:hi Function        cterm=none                        ctermfg=Blue
:hi Identifier      cterm=none                        ctermfg=Blue
:hi Ignore          cterm=none                        ctermfg=DarkGray
:hi IncSearch       cterm=none      ctermbg=Green
:hi Include         cterm=none                        ctermfg=red
:hi Keyword         cterm=none                        ctermfg=Blue
:hi LineNr          cterm=none      ctermbg=Gray      ctermfg=Black
:hi MatchParen      cterm=none      ctermbg=Black     ctermfg=Cyan
:hi NonText         cterm=none      ctermbg=Black     ctermfg=Gray
:hi Number          cterm=none      ctermbg=Black     ctermfg=Red
:hi Pmenu           cterm=none      ctermbg=DarkBlue  ctermfg=LightGray
:hi Operator        cterm=none                        ctermfg=DarkCyan
:hi PreProc         cterm=none                        ctermfg=DarkGreen
:hi Question        cterm=none                        ctermfg=DarkCyan
:hi Search          cterm=none      ctermbg=DarkGreen
:hi Special         cterm=none                        ctermfg=Gray
:hi SpellErrors     cterm=none
:hi Statement       cterm=none      ctermfg=LightBlue
:hi StatusLine      cterm=none      ctermbg=LightGray ctermfg=DarkBlue 
:hi StatusLineNC    cterm=none      ctermbg=DarkGray  ctermfg=LightGray 
:hi String          cterm=none                        ctermfg=Green
:hi Title           cterm=none      ctermbg=Black     ctermfg=DarkGray
:hi Todo            cterm=none      ctermbg=Yellow    ctermfg=DarkBlue
:hi Type            cterm=none      ctermbg=Black     ctermfg=Blue
:hi Underlined      cterm=none
:hi VertSplit       cterm=none      ctermbg=DarkGray  ctermfg=LightGray
:hi Visual          cterm=none      ctermbg=Black     ctermfg=Blue
:hi WildMenu        cterm=none      ctermbg=DarkBlue  ctermfg=LightGray

" NERD Tree
:hi NERDTreeCWD         guibg=#505050    guifg=#000000
:hi NERDTreeClosable    guibg=#3D71EB    guifg=#000000
:hi NERDTreeDirSlash                     guifg=#3D71EB
:hi NERDTreeOpenable                     guifg=#3D71EB
:hi NERDTreePart                         guifg=#505050
:hi NERDTreePartFile                     guifg=#4FB269

" Tag List
:hi MyTagListTagScope                    guifg=#505050
:hi MyTagListTitle                       guifg=#81A7FF
:hi MyTagListFileName                    guifg=#4FB269

" Show Marks
:hi SignColumn      guibg=#000000    guifg=#8AC6F2   
" lowercase
:hi ShowMarksHll    guibg=#001E33
" uppercase
:hi ShowMarksHlu    guibg=#00331E
" everything else
:hi ShowMarksHlo    guibg=#000000    guifg=#707070
" multiple on one line
:hi ShowMarksHlm    guibg=#570800  

" Mini Buf Explorer
:hi MBENormal               guibg=#000000   guifg=#707070
:hi MBEVisibleChangedActive guibg=#4FB269   guifg=#000000
:hi MBEChanged              guibg=#000000   guifg=#4FB269
:hi MBEVisibleChanged       guibg=#505050   guifg=#4FB269
:hi MBEVisibleActive        guibg=#A0A0A0   guifg=#000000
