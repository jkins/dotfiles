" jeff kinslow - vim theme
" modified wombat

let colors_name = "jkins"

:set background=dark
:highlight clear
if version > 580
 hi clear
 if exists("syntax_on")
 syntax reset
 endif
endif

" COLORS
" green		#95E454
" yellow	#CAE682
" red		#E5786D
" blue		#8AC6F2
"
" dark		#101010
" 			#202020
" 			#505050
"
" Blue			#325A66
" Cream			#FFF8B2
" Yellow-Range	#DEA140
" Light Red		#A32B26
" Dark Red		#590D0B
"
:hi ColorColumn		guibg=#0C0C0C
:hi Comment							guifg=#707070	gui=none
:hi Constant						guifg=#E5786D	gui=none
:hi Cursor			guibg=#D0D0D0	guifg=#101010	gui=none
:hi CursorColumn	guibg=#2D2D2D
:hi CursorLine		guibg=#2D2D2D
:hi Define							guifg=gold
":hi DiffAdd			guibg=#071207	guifg=#D0D0D0	gui=none
":hi DiffChange		guibg=#141410	guifg=#C0C0C0	gui=none
":hi DiffDelete		guibg=#0A0302	guifg=#707070 	gui=none
":hi DiffAdd			guibg=#003D00	guifg=#D0D0D0	gui=none
:hi DiffAdd			guibg=#002400					gui=none
:hi DiffChange		guibg=#19180A					gui=none
:hi DiffDelete		guibg=#3B0500	guifg=#505050 	gui=none
:hi DiffText		guibg=#2A291B					gui=none
:hi Directory		guifg=#909090
:hi Error 			guibg=#202020	guifg=#E8594E	gui=none
:hi ErrorMsg		guibg=#E8594E 
:hi FoldColumn		guibg=#000000 	guifg=#505050	gui=none
:hi Folded			guibg=#000000	guifg=#505050	gui=none
:hi Function						guifg=#8AC6F2	gui=none
:hi Identifier						guifg=#8AC6F2	gui=none
:hi Ignore							guifg=grey40
:hi IncSearch		guibg=#000000	guifg=#00FF00	gui=none
:hi Include							guifg=#E8594E	gui=none
:hi Keyword							guifg=#CAE682	gui=none
:hi LineNr			guibg=#000000 	guifg=#505050 	gui=none
:hi MatchParen		guibg=#857B6F	guifg=#F6F3E8	gui=none
":hi ModeMsg							guifg=goldenrod
":hi MoreMsg							guifg=SeaGreen 
:hi NonText			guibg=#000000 	guifg=#505050	gui=none
:hi Normal			guibg=#101010	guifg=#D0D0D0	gui=none
:hi Number							guifg=#E5786D	gui=none
:hi Pmenu			guibg=#303030	guifg=#A0A0A0	gui=none
:hi Operator 						guifg=#E8594E	gui=none
:hi PreProc 						guifg=#E5786D	gui=none
:hi Question						guifg=#58E887 	gui=none
:hi Search			guibg=#58E887	guifg=#000000	gui=none
:hi Special 						guifg=#8AC6F2	gui=none
":hi SpecialKey						guifg=yellowgreen ctermfg=darkgreen
:hi SpellErrors						guifg=White 	gui=none
:hi Statement						guifg=#CAE682	gui=none
:hi StatusLine		guibg=#A0A0A0	guifg=#000000 	gui=none
:hi StatusLineNC	guibg=#555555	guifg=#000000	gui=none
:hi String							guifg=#95E454	gui=none
":hi Structure						guifg=green ctermfg=green
:hi Title							guifg=#8AC6F2	gui=none
:hi Todo 			guibg=#FFE75E	guifg=#E8594E	gui=none
:hi Type							guifg=#8AC6F2	gui=none
:hi Underlined	cterm=underline
:hi VertSplit		guibg=#000000	guifg=#505050 	gui=none
:hi Visual			guibg=#A0A0A0 	guifg=#000055	gui=none 
":hi VisualNOS cterm=bold,underline
":hi WarningMsg		guibg=#A0A0A0	guifg=#000055	gui=none
:hi WildMenu		guibg=#A0A0A0	guifg=#000055	gui=none

" NERD Tree
:hi treeOpenable					guifg=#8AC6F2
:hi treeCWD							guifg=#95E454
:hi treePart						guifg=#505050

" Tag List
:hi MyTagListTagScope				guifg=#505050
:hi MyTagListTitle					guifg=#8AC6F2
:hi MyTagListFileName				guifg=#95E454

" Show Marks
:hi SignColumn		guibg=#000000	guifg=#8AC6F2	
" lowercase
":hi ShowMarksHll	guibg=#000000	guifg=#8AC6F2	
:hi ShowMarksHll	guibg=#001E33
" uppercase
":hi ShowMarksHlu	guibg=#000000	guifg=#E8594E
:hi ShowMarksHlu	guibg=#570800
" everything else
":hi ShowMarksHlo	guibg=#000000	guifg=#707070	
:hi ShowMarksHlo	guibg=#000000	guifg=#707070	
" multiple on one line
":hi ShowMarksHlm	guibg=#000000	guifg=#8AC6F2	
:hi ShowMarksHlm	guibg=#000000	guifg=#8AC6F2	

