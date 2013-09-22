# Editors
export SHELL='zsh'
export EDITOR='vim'
export VISUAL='vim'
export GREP_OPTIONS='--color=auto' GREP_COLOR='1,32'
export PAGER='less'


# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


# Paths
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)


# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi


# Aliases
alias g="opengvim"
# Override some prezto git module alises
alias gs="git status -s"
alias gsd="git svn dcommit"
alias gsl="git svn log --show-commit"
alias gsf="git svn fetch"
alias gsr="git svn rebase"
alias h=history
alias la="ls --color=auto -FA"
alias ld="ls --color=auto -d */"
alias ldl="ls --color=auto -ldA */"
alias ll="ls --color=auto -FAhl"
alias ls="ls --color=auto -F"
alias lsbm='cat ~/.dirs'
alias lt="ls --color=auto -FAhlt"


# Functions
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
