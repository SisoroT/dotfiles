for file (
  # Arch Linux. Must have pkgfile installed: https://wiki.archlinux.org/index.php/Pkgfile#Command_not_found
  /usr/share/doc/pkgfile/command-not-found.zsh
  # macOS (M1 and classic Homebrew): https://github.com/Homebrew/homebrew-command-not-found
  /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
  /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
); do
  if [[ -r "$file" ]]; then
    source "$file"
    unset file
    return 0
  fi
done
unset file
