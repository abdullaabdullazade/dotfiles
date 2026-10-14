# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH="$PATH:/home/abdullaxows/.foundry/bin"
export PATH="$PATH:$HOME/.foundry/bin"
export PATH="$PATH:$HOME/.foundry/bin"
. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

alias studio='QT_QPA_PLATFORM=xcb ~/android-studio/bin/studio.sh >/dev/null 2>&1 &'

# Android SDK tools (adb 37.0.0 — version match fix)
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/emulator:$PATH

# Claude Code — multi-account switch
alias claude1='CLAUDE_CONFIG_DIR=~/.claude claude'          # esas hesab (movcud)
alias claude2='CLAUDE_CONFIG_DIR=~/.claude-acc2 claude'     # ikinci hesab


# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
[[ -r "$HOME/.grok/completions/bash/grok.bash" ]] && source "$HOME/.grok/completions/bash/grok.bash"
# <<< grok installer <<<


# Added by Antigravity CLI installer
export PATH="/home/abdullaxows/.local/bin:$PATH"
. "/home/abdullaxows/.deno/env"

# strix
export PATH=/home/abdullaxows/.strix/bin:$PATH

# Strix -> DeepSeek
export STRIX_LLM="deepseek/deepseek-v4-pro"
export LLM_API_KEY="REPLACE_ME"
export LLM_API_BASE="https://api.deepseek.com"
