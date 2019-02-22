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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)
# export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib
# export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include

# use gitignore when searching with fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# OPAM configuration
. /Users/pcaulagi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# enable completions for docker, docker-compose
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# export PROJECT_ID=`gcloud config get-value project`
#export HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2`
# for cases where we can't use docker.for.mac.localhost in containers
#
export CLOUDSDK_PYTHON=python2.7
export HOST_IP=192.168.65.2
export NNTPSERVER=nntp.aioe.org

export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

source ~/.zsh/completion/*
source ~/.zsh/completion/aws_zsh_completer.sh
source ~/.zsh/completion/_helm
source ~/.zsh/completion/_kops

source ~/.personal

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export WEECHAT_HOME=~/.config/weechat

eval "$(direnv hook zsh)"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export NVM_DIR="$HOME"/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
