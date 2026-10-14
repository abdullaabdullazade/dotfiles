# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
. "$HOME/.cargo/env"


# >>> railway initialize >>>
source "$HOME/.railway/env"
# <<< railway initialize <<<


# Added by Antigravity CLI installer
export PATH="/home/abdullaxows/.local/bin:$PATH"
. "/home/abdullaxows/.deno/env"
