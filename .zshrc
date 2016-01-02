# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey "" history-incremental-search-backward

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
