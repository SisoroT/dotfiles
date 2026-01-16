# => system commands
if command -v eza &> /dev/null; then
    alias l="eza -lha --git --icons --group-directories-first"
else
    alias l="ls -lhA --group-directories-first --color=auto"
fi
alias grep="grep  --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

# => important programs
alias vim="nvim"

# => scripts
alias ratemir='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist'
