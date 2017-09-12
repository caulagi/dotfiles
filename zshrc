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

# use gitignore when searching with fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# OPAM configuration
. /Users/pcaulagi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pcaulagi/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/pcaulagi/Downloads/google-cloud-sdk/path.zsh.inc'; fi
# sso
if [ -f '/Users/pradipcaulagi/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/pcaulagi/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/pcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
# sso
if [ -f '/Users/pradipcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/pcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export NNTPSERVER=nntp.aioe.org
