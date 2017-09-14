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
if [[ -s '/Users/pcaulagi/Downloads/google-cloud-sdk/path.zsh.inc' ]]; then
    source '/Users/pcaulagi/Downloads/google-cloud-sdk/path.zsh.inc'
fi
# sso
if [[ -s '/Users/pradipcaulagi/Downloads/google-cloud-sdk/path.zsh.inc' ]]; then
    source '/Users/pradipcaulagi/Downloads/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [[ -s '/Users/pcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc' ]]; then
    source '/Users/pcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc'
fi
# sso
if [[ -s '/Users/pradipcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc' ]]; then
    source '/Users/pradipcaulagi/Downloads/google-cloud-sdk/completion.zsh.inc'
fi

# enable completions for docker, docker-compose
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

export PROJECT_ID=`gcloud config get-value project`
export DB_DUMP=/Users/pradipcaulagi/dumps/Dump20170825.sql
export HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2`
export NNTPSERVER=nntp.aioe.org
