# dotfiles

My personal Hyprland rice on **Fedora 43**, built on top of
[end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) (the *illogical-impulse*
layout) with a [Quickshell](https://quickshell.org/) bar/shell and
[Matugen](https://github.com/InioX/matugen) dynamic theming.

```
 OS       Fedora Linux 43 (Workstation)
 WM       Hyprland 0.51.1
 Shell    Quickshell (illogical-impulse) + fish
 Theme    Matugen (Material You, generated from wallpaper)
 Terminal kitty / foot
 Prompt   starship
 CPU      Intel Core i7-13700H   ·   GPU  Intel Iris Xe
```

## What's in here

| Path | Tool | Notes |
|------|------|-------|
| `config/hypr/` | Hyprland | compositor, hypridle, hyprlock, hyprpaper, monitors, workspaces |
| `config/quickshell/` | Quickshell | the bar, widgets, launcher, OSD (illogical-impulse `ii`) |
| `config/illogical-impulse/` | — | shell config.json + translations |
| `config/matugen/` | Matugen | colour-generation templates (feeds GTK/Qt/kitty/etc.) |
| `config/kitty/`, `config/foot/` | terminals | |
| `config/fish/` | fish | `config.fish`, `conf.d/`, `functions/` (autogen completions excluded) |
| `config/fuzzel/` | launcher | |
| `config/wlogout/` | logout menu | |
| `config/cava/` | audio visualiser | |
| `config/btop/` | resource monitor | |
| `config/mpv/` | media player | |
| `config/gtk-3.0`, `gtk-4.0`, `qt5ct`, `qt6ct`, `Kvantum`, `kdeglobals`, `fontconfig` | theming | GTK + Qt look to match Matugen |
| `config/starship.toml` | prompt | |
| `config/zshrc.d/` | zsh drop-ins | |
| `home/` | `.bashrc` `.bash_profile` `.zshrc` `.gitconfig` | |
| `wallpapers/` | images | copied to `~/Pictures/Wallpapers` by `install.sh` |

## "Will someone get exactly my setup?"

Configs: yes. Pixel-identical: mostly, with caveats.

- **Wallpapers are included** (`wallpapers/` → `~/Pictures/Wallpapers`). Matugen
  regenerates colours from the active wallpaper, so with the same wallpaper the
  theme matches.
- **Paths are absolute** (`/home/abdullaxows/...`). On the same username it just
  works. On a different username, run `./install.sh --copy` — it rewrites those
  paths to the new `$HOME`. Symlink mode cannot (it would edit repo files).
- **Not included:** font / icon / cursor / GTK-theme *packages* themselves — the
  configs point to them, install them via your package manager if a glyph or icon
  is missing.

## Install

```bash
git clone <this-repo> ~/dotfiles
cd ~/dotfiles

# 1. packages (Fedora)
sudo dnf install $(grep -v '^#' packages.txt)

# 2. preview — changes nothing
./install.sh --dry-run

# 3. deploy (symlinks everything, backs up what's in the way)
./install.sh
```

`install.sh` symlinks each entry into `~/.config` / `~`. Anything already there is
moved to `~/.dotfiles-backup/<timestamp>/` first, so nothing is lost. Use
`./install.sh --copy` to copy instead of symlink.

Because it's symlinks, editing a file in `~/.config` **is** editing the repo —
`git add -p` and commit to version a change.

## See what's on the machine

```bash
./sysinfo.sh
```

Prints host, kernel, hardware, and a table of every tracked tool: whether its
config is present in the repo and whether the package is installed.

## Secrets

No live secrets are committed. Anything sensitive is replaced with `REPLACE_ME`
(e.g. `LLM_API_KEY` in `home/.bashrc`) — set the real value locally after install.
`.env`, keys, and `fish_variables` are gitignored.

## Credits

- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) — base rice / illogical-impulse
- [Quickshell](https://quickshell.org/) · [Matugen](https://github.com/InioX/matugen) · [Hyprland](https://hyprland.org/)
