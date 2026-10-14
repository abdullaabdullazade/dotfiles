#!/usr/bin/env bash
# sysinfo.sh — show the machine this rice runs on, and which tracked config
# each tool actually uses. Pure bash; no dependencies beyond coreutils.
set -uo pipefail

c0=$'\e[0m'; cb=$'\e[1m'; ac=$'\e[35m'; dim=$'\e[2m'; gr=$'\e[32m'; ye=$'\e[33m'
k(){ printf '  %s%-10s%s %s\n' "$ac" "$1" "$c0" "$2"; }

. /etc/os-release 2>/dev/null || true
DISTRO="${PRETTY_NAME:-unknown}"
KERNEL="$(uname -r)"
UPTIME="$(uptime -p 2>/dev/null | sed 's/^up //')"
WM="$(hyprctl version 2>/dev/null | grep -oE 'v[0-9.]+' | head -1)"
SHELLN="$(basename "${SHELL:-sh}")"
CPU="$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ *//')"
GPU="$(lspci 2>/dev/null | grep -iE 'vga|3d' | sed 's/.*: //;s/ (rev.*//' | head -1)"
MEM="$(free -h --si 2>/dev/null | awk '/Mem:/{print $3" / "$2}')"
PKGS="$(rpm -qa 2>/dev/null | wc -l)"

printf '\n%s  ▁▂▃ abdullaxows@%s ▃▂▁%s\n\n' "$cb" "$(hostname)" "$c0"
k OS      "$DISTRO"
k Kernel  "$KERNEL"
k Uptime  "${UPTIME:-n/a}"
k WM      "Hyprland ${WM:-?}"
k Shell   "$SHELLN"
k CPU     "$CPU"
k GPU     "${GPU:-n/a}"
k Memory  "${MEM:-n/a}"
k Pkgs    "${PKGS} (rpm)"

echo
printf '%s  tracked tooling%s\n' "$cb" "$c0"
# name | config path | package to check
rows=(
  "Compositor|~/.config/hypr|hyprland"
  "Shell/Bar |~/.config/quickshell|quickshell-git"
  "Terminal  |~/.config/kitty|kitty"
  "Terminal  |~/.config/foot|foot"
  "Launcher  |~/.config/fuzzel|fuzzel"
  "Logout    |~/.config/wlogout|wlogout"
  "Colorgen  |~/.config/matugen|matugen"
  "Fish      |~/.config/fish|fish"
  "Prompt    |~/.config/starship.toml|starship"
  "Audio viz |~/.config/cava|cava"
  "Monitor   |~/.config/btop|btop"
  "Media     |~/.config/mpv|mpv"
)
for r in "${rows[@]}"; do
  IFS='|' read -r name path pkg <<<"$r"
  p="${path/#\~/$HOME}"
  present="${gr}cfg${c0}"; [ -e "$p" ] || present="${dim}---${c0}"
  if rpm -q "$pkg" &>/dev/null; then inst="${gr}✓${c0}"; else inst="${ye}?${c0}"; fi
  printf '  %s %-10s %b %-26s %b\n' "$ac·$c0" "$name" "$present" "$path" "$inst"
done
printf '\n  %scfg%s = config tracked in repo   %s✓%s = package installed   %s?%s = not via rpm\n\n' \
  "$gr" "$c0" "$gr" "$c0" "$ye" "$c0"
