function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias pamcan pacman
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    
end
alias kalifish='distrobox enter kali -- fish'

# Android Studio + emulator — force xcb (Wayland fix)
function studio
    QT_QPA_PLATFORM=xcb ~/android-studio/bin/studio.sh >/dev/null 2>&1 &
end


# Android SDK tools (adb 37.0.0)
set -gx ANDROID_HOME $HOME/Android/Sdk
fish_add_path $HOME/Android/Sdk/platform-tools $HOME/Android/Sdk/emulator

alias vpnup='sudo wg-quick up wg0'
alias vpndown='sudo wg-quick down wg0'


# Claude Code — multi-account switch
alias claude1='env CLAUDE_CONFIG_DIR=$HOME/.claude claude'
alias claude2='env CLAUDE_CONFIG_DIR=$HOME/.claude-acc2 claude'


# Added by Antigravity CLI installer
set -gx PATH "/home/abdullaxows/.local/bin" $PATH

# Go
set -gx GOROOT $HOME/.local/go-sdk/go
set -gx GOPATH $HOME/go
fish_add_path $GOROOT/bin $GOPATH/bin
