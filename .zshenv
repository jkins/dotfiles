# Editors
export SHELL='zsh'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='vim -c PAGER -'


# NVM Dir
export NVM_DIR=$(readlink -f "$HOME/.nvm")


# Language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Paths
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  ~/bin
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

# find a target file by pattern, then execute a command on its relative path
c_f() {
	cmd=$1
	pattern=$2
	results=$(find . -iname "$pattern")
	if [[ -z $results ]]; then
		echo "Didn't find files matching '$pattern'"
		return 1
	fi

	matches=($(echo ${results}))
	n=${#matches[@]}
	if [[ $n == 1 ]]; then
      echo "Found 1 file matching '$pattern': ${matches[1]}"
      ${cmd} $(dirname ${matches[1]})
	else
		echo "Found $n files matching '$pattern'"
		for i in {1..${n}}
		do 
			echo "${i}  ${matches[i]}"
		done
		echo -n "Path #: "

		read opt 
		if [[ $opt == 0 || $opt -gt $n ]]; then
			echo "Invalid selection."
			return 1
		else
            ${cmd} $(dirname $matches[$opt])
		fi
	fi
}

# go up the tree to a dir name
cdu() {
  dest=$1
  if [[ -z $dest ]]; then
    echo "Usage: $0 destdir"
  elif [[ "$PWD" == "/" ]]; then
    echo "In root."
    return 1
  fi

  local pth=$PWD
  while [ true ]; do
    pth=$( dirname $pth )
    if [[ "$pth" == "/" ]]; then
      echo "Searched to root; dir "$dest" not found."
      return 1
    elif [[ $(basename $pth) == "$dest" ]]; then
      cd $pth
      return 0
    fi
  done
}

# go to the git/svn module root
cdr() {
	if [[ -d ./.git || -d ./.svn ]]; then
		echo "Already in module root."
		return 1
	elif [[ "$PWD" == "/" ]]; then
		echo "In root."
		return 1
	fi

	local pth=$PWD
	while [ true ]; do
		pth=$( dirname $pth )
		if [[ "$pth" == "/" ]]; then
			echo "Searched to root; not in a git/svn module."
			return 1
		elif [[ -d $pth/.git || -d $pth/.svn ]]; then
			cd $pth
			return 0
		fi
	done	
}
