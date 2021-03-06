# .bashrc -- Jeff Kinslow
# vim: foldmethod=marker

# Environment Variables {{{----------------------------------------------------
export CLICOLOR=1
export EDITOR='vim'
export GIT_EDITOR='vim'
export GREP_COLOR='1;32'
export HISTCONTROL=ignoredups
export HISTFILE=~/.bash_history
export HISTFILESIZE=10000
export HISTIGNORE="&:ls:ll:cd*:cs*:[bf]g:exit:..:..."
export LS_COLORS='di=94:fi=0:ln=96:pi=5:so=5;91:bd=5;91:cd=5:or=31:mi=90:ex=92'
export PROMPT_COMMAND='setPrompt'
export PS2="\[${COLOR_GRAY}\]› \[${COLOR_NONE}\]"
export SSH_ENV="$HOME/.ssh/environment"
export SVN_EDITOR='vim'
# Colors {{{
export COLOR_NONE='\e[0m' # Reset
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[1;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'
# }}}
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

# Shell {{{--------------------------------------------------------------------
bind "set completion-ignore-case-on"	# ignore case when completing
bind "set show-all-if-ambiguous On"		# show list automatically
bind "set bell-style none"				# disable bell
set -o vi				# vi command mode
shopt -s cdspell
shopt -s checkwinsize	# After each command, adjusts lines and columns
shopt -s cmdhist
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend		# Append to history
shopt -s nocaseglob
shopt -u autocd
shopt -u cdable_vars
# }}}

# Aliases {{{------------------------------------------------------------------
alias lsbm='cat ~/.dirs'
alias colorlist="set | egrep '^COLOR_\w*'" # lists all the colors
alias h=history
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls --color=auto -F"
alias la="ls --color=auto -FA"
alias ll="ls --color=auto -FAhl"
alias ld="ls --color=auto -d */"
alias ldl="ls --color=auto -ldA */"
alias lt="ls --color=auto -FAhlt"
alias cls='echo -n [2J' 
alias gs="git status -s"
alias gsr="git svn rebase"
alias gsd="git svn dcommit"
alias gsl="git svn log --show-commit"
alias g="opengvim"
# }}}

# Functions {{{----------------------------------------------------------------
# bookmark dir
bm() {
  command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}

#cd + ls
cs() {
	cd "$@"
	ls --color=auto -F
}

# find a file and go to its dir
cdf() {
	local path=( $(find . -name $1) )
	if [ "$path" != "" ]; then
		cd $(dirname $path)
	else
		echo "Didn't find '$1'"
		return 1
	fi
}

# go to the git module root
cdm() {
	if [[ -d ./.git ]]; then
		echo "Already in git module root."
		return 1
	elif [ "$PWD" == "/" ]; then
		echo "In root."
		return 1
	fi

	local path=$PWD
	while [ true ]; do
		path=$( dirname $path )
		if [ "$path" == "/" ]; then
			echo "Searched to root; not in a git module."
			return 1
		elif [[ -d $path/.git ]]; then
			cd $path
			return 0
		fi
	done	
}

# find through history
hf(){
	grep "$@" $HISTFILE
}

matrix() {
	tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"
}

setTitle() {
	echo -ne "\e]2;$@\a\e]1;$@\a"
}

start_sshagent() {
	echo -n "Initialising new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo "done."
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	ssh-add ~/.ssh/id_rsa ~/.ssh/id_rsa_ngc
}

opengvim() {
	if [ "$1" == "" ]; then # no file given, just load gvim
		gvim --servername GVIM &
	elif [ -e "$1" ]; then # file exists in working dir, open it
		gvim --servername GVIM --remote-silent $(cygpath -d $1) &
	else # find file and open it
		echo "'$1' not in working directory, searching..."
		local file=$(find . -name "$1")
		if [ -n "$file" ]; then
			local filepath=$(cygpath -d $file)
			echo "found at $file"
			gvim --servername GVIM --remote-silent $filepath &
		else
			echo "not found"
			return 1
		fi
	fi
}
# }}}

# Completion {{{----------------------------------------------------------------
# http://www.caliban.org/bash/index.shtml#completion
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
	source /opt/local/etc/bash_completion
fi
# git completion
if [ -f ~/bin/git-completion.bash ]; then
	source ~/bin/git-completion.bash
fi
# ant completion
if [ -f ~/bin/complete-ant-cmd ]; then
	complete -C ~/bin/complete-ant-cmd ant build.sh
fi
# Add completion to source and .
complete -F _command source
complete -F _command .
# }}}

# Prompt {{{-------------------------------------------------------------------
# add git ps1 if git is on this system
prompt_git=$(builtin type -P git &>/dev/null; echo $?)

# Special chars: ―  …  » ›
setPrompt() {
	# build 'return' string
	local ret=$?

	# time
	local termwidth=${COLUMNS}
	local _ret_plain=""
	local curtime=$(date +"%I:%M:%S")
	if [[ ret -ne 0 ]]; then
		_ret_plain="> $ret$curtime "
		_prompt_ret="\[${COLOR_LIGHT_RED}\]»\[${COLOR_LIGHT_GRAY}\] $ret\[${COLOR_NONE}\] "
	else
		_ret_plain="$curtime"
		_prompt_ret=""
	fi

	local fillsize=${termwidth}-${#_ret_plain}-1
	if [[ $fillsize -gt 0 ]]; then
		local fill="――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
		local fill="${fill:0:${fillsize}}"
	else
		local fill=""
	fi

	_prompt_ret="${_prompt_ret}\[${COLOR_GRAY}\]${fill} ${curtime}\[${COLOR_NONE}\]\n"

	local _prompt=""

	# if root, color $ red, else gray
	local _sym=""
	if [[ $EUID -eq 0 ]]; then
		_sym="\[${COLOR_LIGHT_RED}\]\$\[${COLOR_NONE}\]"
	else
		_sym="\[${COLOR_GRAY}\]\$\[${COLOR_NONE}\]"
	fi

	# git ps1
	if [[ $prompt_git -eq 0 ]]; then
		prompt_git_ps1="$(__git_ps1)"
	else
		prompt_git_ps1=""
	fi

	# set display pwd
	local _pwd_plain="${PWD//$HOME/~}"
	local _pwd="\[${COLOR_LIGHT_GRAY}\]${_pwd_plain}\[${COLOR_NONE}\]"
	
	# Display host in prompt and window title if ssh connection
	# local		pwd
	# remote	user@host:pwd
	local _host=""
	if [ "$SSH_CONNECTION" == "" ]; then
		_host_plain=""
		_host=""
		setTitle ${_pwd_plain}
	else
		_host_plain="${HOSTNAME}:"
		_host="\[${COLOR_LIGHT_GRAY}\]${HOSTNAME}\[${COLOR_GRAY}\]:"
		setTitle ${USER}@${HOSTNAME}:${_pwd_plain}
	fi

	# truncate working dir if needed
	_prompt_firstline="[${_host}${_pwd_plain}]${prompt_git_ps1}"
	let cut=${#_prompt_firstline}-${termwidth}+1
	if [[ $cut -gt 0 ]]; then
		_pre="\[${COLOR_GRAY}\]…"
		_pwd="${_pre}\[${COLOR_LIGHT_GRAY}\]${_pwd_plain:${cut}}\[${COLOR_NONE}\]"
	fi

	_prompt="${_prompt_ret}\n\[${COLOR_LIGHT_BLUE}\][${_host}${_pwd}\[${COLOR_LIGHT_BLUE}\]]\[${COLOR_GRAY}\]${prompt_git_ps1}\n${_sym}\[${COLOR_NONE}\] "

	# set PS1
	PS1="${_prompt}"
}
# }}}

# Runtime {{{------------------------------------------------------------------

# Source SSH settings, if applicable
if [ "$SSH_CONNECTION" == "" ]; then
	if [ -f "${SSH_ENV}" ]; then
		. "${SSH_ENV}" > /dev/null
		#ps ${SSH_AGENT_PID} doesn't work under cywgin
		ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
			start_agent;
		}
	else
		start_agent;
	fi 
fi

# dir bookmarks
# http://www.macosxhints.com/article.php?story=20020716005123797
if [ ! -f ~/.dirs ]; then # if doesn't exist, create it
  touch ~/.dirs
fi
source ~/.dirs # Initialization for the above 'lsbm' facility: source the .sdirs file

export SOURCED_BASHRC=1
# }}}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
