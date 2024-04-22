# => system commands
alias cl="clear"
alias ei="exit"
alias l="exa -lha --git --icons --group-directories-first"
alias ls="exa --icons"
# alias l="ls -lhA --group-directories-first"
# alias ls="ls --color"
alias grep="grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"
alias zz="z -"

# => important programs
alias vim="nvim"
alias v="nvim"
alias fm="vifm"

# => scripts
alias ratemir='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist'

# => downloaded programs
alias neo="neofetch"
