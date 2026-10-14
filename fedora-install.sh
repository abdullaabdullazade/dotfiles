#!/usr/bin/env bash
# fedora-install.sh — bring up this end-4 / illogical-impulse rice on a fresh
# Fedora (tested on Fedora 43 Workstation).
#
# Does three things:
#   1. enables the COPRs these packages come from
#   2. installs everything in packages.txt
#   3. runs ./install.sh to deploy the dotfiles
#
# Run as your normal user (it will call sudo when needed):
#   ./fedora-install.sh
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
c_b=$'\e[34m'; c_g=$'\e[32m'; c_0=$'\e[0m'
info(){ printf '%s[*]%s %s\n' "$c_b" "$c_0" "$*"; }
ok(){   printf '%s[+]%s %s\n' "$c_g" "$c_0" "$*"; }

command -v dnf >/dev/null || { echo "dnf not found — this script is Fedora-only."; exit 1; }

# 1. COPRs (where the Hyprland ecosystem + quickshell + starship live on Fedora)
COPRS=(
  solopasha/hyprland        # hyprland, hypridle/lock/paper, matugen, swww, grimblast, mpvpaper
  errornointernet/quickshell
  atim/starship
)
for c in "${COPRS[@]}"; do
  info "enabling copr: $c"
  sudo dnf -y copr enable "$c"
done

# 2. packages
info "installing packages from packages.txt"
# shellcheck disable=SC2046
sudo dnf -y install $(grep -vE '^\s*#|^\s*$' packages.txt)

# extras most end-4 dots need that aren't core
info "installing common extras"
sudo dnf -y install \
  wl-clipboard brightnessctl playerctl \
  fonts-rajdhani-nerd-fonts jetbrains-mono-fonts-all \
  papirus-icon-theme ddcutil 2>/dev/null || true

# 3. deploy dotfiles
info "deploying dotfiles"
./install.sh "$@"

echo
ok "Fedora setup complete."
ok "Log into a Hyprland session (SDDM/greetd) to start the rice."
echo "   Then press Super to open the shell; Ctrl+Super+T = wallpaper selector."
