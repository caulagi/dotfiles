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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)

# OPAM configuration
. /Users/pcaulagi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# enable completions for docker, docker-compose
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
source <(kubectl completion zsh)

# export PROJECT_ID=`gcloud config get-value project`
#export HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2`
# for cases where we can't use docker.for.mac.localhost in containers
#
export CLOUDSDK_PYTHON=python2.7
export HOST_IP=192.168.65.2
export NNTPSERVER=nntp.aioe.org

export GOPATH=~/src/go
export PATH=$GOPATH/bin:$PATH
export PATH=$PATH:$HOME/.linkerd2/bin

source ~/.zsh/completion/*
source ~/.zsh/completion/aws_zsh_completer.sh
source ~/.zsh/completion/_helm
source ~/.zsh/completion/_kops

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export WEECHAT_HOME=~/.config/weechat

eval "$(direnv hook zsh)"
[[ -f "$HOME/.local/profile_zsh" ]] && source "$HOME/.local/profile_zsh"

# tabtab source for serverless package
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
[[ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]] && . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"

export NVM_DIR="$HOME"/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
