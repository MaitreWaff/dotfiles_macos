autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
export ANDROID_HOME=$HOME/Library/Android/sdk && export PATH=$PATH:$ANDROID_HOME/emulator && export PATH=$PATH:$ANDROID_HOME/platform-tools

eval "$(register-python-argcomplete --no-defaults exegol)"

PATH=~/.console-ninja/.bin:$PATH
. "$HOME/.cargo/env"
