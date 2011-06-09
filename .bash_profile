# .bash_profile -- Jeff Kinslow
echo "bash $BASH_VERSION"
echo $(uname -smr)

# path
if [ -d ~/bin ]; then
	PATH=~/bin:"${PATH}"
fi

# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the user bashrc if it exists and hasn't been sourced yet
if [ -z $SOURCED_BASHRC ]; then
	if [ -e "${HOME}/.bashrc" ] ; then
		source "${HOME}/.bashrc"
	fi
fi

# welcome message
echo
echo -e $(date -u +"%a %b %d %Y %T %Z (%s)")
echo -e $(date +"%a %b %d %Y %r %Z (%:::z)")
echo -e ${USER}@${HOSTNAME}:${PWD}

