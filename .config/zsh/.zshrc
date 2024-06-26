# local binaries
export PATH=$PATH:$HOME/.local/bin
# scripts folder
export PATH=$PATH:$HOME/scripts
# android sdk
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# variables
local plugin_dir="$HOME/.config/zsh/plugins"
local alias_dir="$HOME/.config/zsh/aliases"

# histfile
HISTFILE=$HOME/.config/zsh/.histfile
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

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
for plugin in $plugin_dir/*.zsh; do
  source $plugin
done

# aliases
for alias_file in $alias_dir/*.zsh; do
  source $alias_file
done

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
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# vi mode
bindkey -v
export KEYTIMEOUT=1
