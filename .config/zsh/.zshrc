# Paths
# path to vifmrun script
export PATH=/home/sisoro/.config/vifm/scripts:$PATH
# path to scripts folder
export PATH=/home/sisoro/scripts:$PATH

# path to histfile
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# cd without having to type cd
setopt autocd autopushd

# dont highlight pasted text
zle_highlight=('paste:none')

# enable autocompletion in terminal
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt COMPLETE_ALIASES

# load plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/sisoro/.config/zsh/plugins/command-not-found.zsh
source /home/sisoro/.config/zsh/plugins/extract.zsh
source /home/sisoro/.config/zsh/plugins/web-search.zsh

# load aliases
source /home/sisoro/.config/zsh/aliases/aliasrc
source /home/sisoro/.config/zsh/aliases/git-aliases
source /home/sisoro/.config/zsh/aliases/arch-aliases

# use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
echo -ne '\e[5 q' # Use beam shape cursor on startup.
precmd() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# makes fzf only go 4 deep for better performance
export FZF_DEFAULT_COMMAND='find . -maxdepth 4'

# source fzf terminal shortcuts
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
