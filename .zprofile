# .bash_profile -- Jeff Kinslow
echo "zsh $ZSH_VERSION"
uname -smr

# path
if [ -d ~/bin ]; then
	PATH=~/bin:"${PATH}"
fi

# welcome message
echo
date -u +"%a %b %d %Y %T %Z (%s)"
date +"%a %b %d %Y %r %Z (%:::z)"
echo -e ${USER}@${HOST}:${PWD}

