# .zshrc -- Jeff Kinslow
# vim: foldmethod=marker

# Environment Variables {{{----------------------------------------------------
export CLICOLOR=1
export COMPLETION_WAITING_DOTS="true"
export EDITOR='vim'
export GIT_EDITOR='vim'
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SVN_EDITOR='vim'
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="jkins"
# TEMP {{{
command -v config.guess >/dev/null 2>&1 && { 
	if [[ $(config.guess) == *cygwin* ]]
	then
		export TMP=/tmp
		export TEMP=/tmp
	fi
}
# }}}
# TERM {{{
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
elif [ -e /usr/share/terminfo/x/xterm-color ]; then
	export TERM='xterm-color'
else
	export TERM='xterm'
fi
# }}}
# }}}--------------------------------------------------------------------------

# oh-my-zsh {{{----------------------------------------------------------------
plugins=(git vi-mode ssh-agent)
source $ZSH/oh-my-zsh.sh
zstyle :omz:plugins:ssh-agent id_rsa id_rsa_ngc
# }}}

# Key Binds {{{----------------------------------------------------------------
bindkey '^R' history-incremental-search-backward
# }}}

# Aliases {{{------------------------------------------------------------------
alias cls='echo -n [2J' 
alias g="opengvim"
alias gf="gvim --remote-silent $1 &"
alias gs="git status -s"
alias gsd="git svn dcommit"
alias gsl="git svn log --show-commit"
alias gsr="git svn rebase"
alias h=history
alias la="ls --color=auto -FA"
alias ld="ls --color=auto -d */"
alias ldl="ls --color=auto -ldA */"
alias ll="ls --color=auto -FAhl"
alias ls="ls --color=auto -F"
alias lsbm='cat ~/.dirs'
alias lt="ls --color=auto -FAhlt"
# }}}

# Functions {{{----------------------------------------------------------------
# bookmark dir
bm() {
  command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}

# cd + ls
cs() {
	cd "$@"
	ls --color=auto -F
}

# find a file and go to its dir
cdf() {
	c_f cd $1
}
csf() {
	c_f cs $1
}

# find a target file by name, then execute a command on its relative path
c_f() {
	cmd=$1
	name=$2
	results=$(find . -iname "$name" -printf "%h ")
	if [[ -z $results ]]; then
		echo "Didn't find file named '$name'"
		return 1
	fi

	paths=($(echo ${results}))
	n=${#paths[@]}
	if [[ $n == 1 ]]; then
		${cmd} ${paths[1]}
	else
		echo "Found many files named '$name'"
		for i in {1..${n}}
		do 
			echo "${i}  ${paths[i]}"
		done
		echo -n "Path #: "

		read opt 
		if [[ $opt == 0 || $opt -gt $n ]]; then
			echo "Invalid selection."
			return 1
		else
			${cmd} ${paths[$opt]}
		fi
	fi
}

# go to the git module root
cdm() {
	if [[ -d ./.git ]]; then
		echo "Already in git module root."
		return 1
	elif [[ "$PWD" == "/" ]]; then
		echo "In root."
		return 1
	fi

	local pth=$PWD
	while [ true ]; do
		pth=$( dirname $pth )
		if [[ "$pth" == "/" ]]; then
			echo "Searched to root; not in a git module."
			return 1
		elif [[ -d $pth/.git ]]; then
			cd $pth
			return 0
		fi
	done	
}

# search history
hf(){
	grep "$@" $HISTFILE
}

# find a target file and open with gvim
opengvim() {
	name=$1
	if [[ "$name" == "" ]]; then
		echo "File name required."
		return 1
	elif [[ -e "$name" ]]; then # file exists in working dir, open it
		gvim --servername GVIM --remote-silent $(cygpath -d $name) &
	else # find file and open it
		results=$(find . -name "$name" -printf "%h/%f ")
		if [[ -z $results ]]; then
			echo "Didn't find file named '$name'"
			return 1
		fi

		paths=($(echo ${results}))
		n=${#paths[@]}
		if [[ $n == 1 ]]; then
			echo "Found at ${paths[1]}"
			gvim --servername GVIM --remote-silent $(cygpath -d ${paths[1]}) &
		else
			echo "Found many files named '$name'"
			for i in {1..${n}}
			do 
				echo "${i}  ${paths[i]}"
			done
			echo -n "Path #: "

			read opt 
			if [[ $opt == 0 || $opt -gt $n ]]; then
				echo "Invalid selection."
				return 1
			else
				gvim --servername GVIM --remote-silent $(cygpath -d ${paths[$opt]}) &
			fi
		fi
	fi
}

# window title
setTitle() {
	echo -ne "\e]2;$@\a\e]1;$@\a"
}
# }}}

# Misc {{{---------------------------------------------------------------------
# Displays a Matrix!
function matrix {
	tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"
}
# }}}

# Runtime {{{------------------------------------------------------------------
# dir bookmarks
# http://www.macosxhints.com/article.php?story=20020716005123797
if [[ ! -f ~/.dirs ]]; then # if doesn't exist, create it
  touch ~/.dirs
fi
source ~/.dirs # Initialization for the above 'lsbm' facility: source the .sdirs file
export SOURCED_ZSHRC=1
# }}}

