export PATH=$PATH:$HOME/android-studio/bin
alias macos='cd ~/OSX-KVM && GDK_BACKEND=x11 ./OpenCore-Boot.sh'
alias macos='cd ~/OSX-KVM && GDK_BACKEND=x11 bash ./OpenCore-Boot.sh'

alias studio='QT_QPA_PLATFORM=xcb ~/android-studio/bin/studio.sh >/dev/null 2>&1 &'

# Android SDK tools (adb 37.0.0 — version match fix)
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$HOME/Android/Sdk/platform-tools:$HOME/Android/Sdk/emulator:$PATH


# Added by Antigravity CLI installer
export PATH="/home/abdullaxows/.local/bin:$PATH"
