echo 'Hello from .zshenv'

#. "$HOME/.cargo/env"

function exists() {
  command -v $1 >/dev/null 2>&1
}
