#!/usr/bin/env bash
# install.sh — deploy these dotfiles into your home directory.
#
# Usage:
#   ./install.sh            # symlink everything (default), backing up anything in the way
#   ./install.sh --copy     # copy instead of symlink
#   ./install.sh --dry-run  # show what would happen, change nothing
#   ./install.sh --help
#
# Existing files/dirs are moved to ~/.dotfiles-backup/<timestamp>/ before linking.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="link"
DRY=0

for a in "$@"; do
  case "$a" in
    --copy)    MODE="copy" ;;
    --dry-run) DRY=1 ;;
    --help|-h) sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "unknown arg: $a"; exit 1 ;;
  esac
done

TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.dotfiles-backup/$TS"

c_g=$'\e[32m'; c_y=$'\e[33m'; c_b=$'\e[34m'; c_r=$'\e[31m'; c_0=$'\e[0m'
info(){ printf '%s[*]%s %s\n' "$c_b" "$c_0" "$*"; }
ok(){   printf '%s[+]%s %s\n' "$c_g" "$c_0" "$*"; }
warn(){ printf '%s[!]%s %s\n' "$c_y" "$c_0" "$*"; }

# deploy <src-abs> <dest-abs>
deploy() {
  local src="$1" dest="$2"
  # already the correct symlink? skip.
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    ok "up to date: ${dest/#$HOME/\~}"; return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    warn "backup:  ${dest/#$HOME/\~}"
    [ "$DRY" = 1 ] || { mkdir -p "$BACKUP/$(dirname "${dest#$HOME/}")"; mv "$dest" "$BACKUP/${dest#$HOME/}"; }
  fi
  info "${MODE}:   ${dest/#$HOME/\~}"
  [ "$DRY" = 1 ] && return
  mkdir -p "$(dirname "$dest")"
  if [ "$MODE" = "link" ]; then ln -s "$src" "$dest"
  else cp -a "$src" "$dest"; fi
}

[ "$DRY" = 1 ] && warn "DRY RUN — nothing will change"
info "repo:   $REPO"
info "backup: ${BACKUP/#$HOME/\~}"
echo

# ~/.config/* entries
for src in "$REPO"/config/*; do
  deploy "$src" "$HOME/.config/$(basename "$src")"
done

# home dotfiles (dotfile-named inside home/)
if [ -d "$REPO/home" ]; then
  for src in "$REPO"/home/.*; do
    b="$(basename "$src")"
    [ "$b" = "." ] || [ "$b" = ".." ] && continue
    deploy "$src" "$HOME/$b"
  done
fi

echo
ok "done."
grep -q 'REPLACE_ME' "$HOME/.bashrc" 2>/dev/null && \
  warn "reminder: set real secrets (LLM_API_KEY etc.) — repo ships REPLACE_ME placeholders."
