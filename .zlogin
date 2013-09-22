# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# welcome message
echo -e $(date -u +"%a %b %d %Y %T %Z (%s)")
echo -e $(date +"%a %b %d %Y %r %Z (%:::z)")
echo -e ${USERNAME}@${HOSTNAME}:${PWD}

