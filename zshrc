#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

bindkey "^E" vi-end-of-line

source ~/.cargo/env
source ~/.alias

export GPG_TTY=$(tty)
# export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib
# export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export ONEFLOW_CLIENT_DIR=/Users/pcaulagi/oneflow/src/client
