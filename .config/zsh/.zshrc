#set -xe

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export ADOTDIR=$HOME/.config/antigen
source "${ZDOTDIR:-$HOME}/antigen.zsh"

COMPLETION_DIR=$ZDOTDIR/completion
mkdir -pv $COMPLETION_DIR

antigen use prezto

antigen bundle sorin-ionescu/prezto modules/environment
antigen bundle sorin-ionescu/prezto modules/editor
antigen bundle sorin-ionescu/prezto modules/history
antigen bundle sorin-ionescu/prezto modules/git
antigen bundle sorin-ionescu/prezto modules/prompt
antigen bundle sorin-ionescu/prezto modules/python
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

if [[ -f "$HOME/.cargo/env" ]]
then
    source ~/.cargo/env
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)
export VISUAL=nvim
export EDITOR=nvim
export STARSHIP_SHELL=zsh
export AWS_PAGER=""

# OPAM configuration
. /Users/pcaulagi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export GOPATH=~/src/go

# enable completions for docker, docker-compose
fpath=($COMPLETION_DIR $fpath)
autoload -Uz compinit && compinit -i

if type kubectl > /dev/null; then
    source <(kubectl completion zsh)
fi
if type clusterctl > /dev/null; then
    source <(clusterctl completion zsh)
fi
if type rustup > /dev/null; then
    rm $COMPLETION_DIR/_rustup
    rustup completions zsh > $COMPLETION_DIR/_rustup
fi
if type kops > /dev/null; then
    source <(kops completion zsh)
fi
if type helm > /dev/null; then
    source <(helm completion zsh)
fi
if type kind > /dev/null; then
    source <(kind completion zsh)
fi

path+=("$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH")
export WEECHAT_HOME=~/.config/weechat

if type direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if [[ -f "$HOME/.local/profile_zsh" ]]
then
    source "$HOME/.local/profile_zsh"
fi

if [[ -f "$HOME/.local/alias" ]]
then
    source "$HOME/.local/alias"
fi

export NVM_DIR="$HOME"/.config/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if [[ -d "$HOME/Library/Android/sdk" ]]
then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    path+=$ANDROID_HOME/emulator
    path+=$ANDROID_HOME/tools
    path+=$ANDROID_HOME/tools/bin
    path+=$ANDROID_HOME/platform-tools
fi

if type zoxide > /dev/null; then
    eval "$(zoxide init zsh)"
fi

eval "$(starship init zsh)"

if [[ -d "/usr/local/opt/ruby" ]]
then
    path+="/usr/local/opt/ruby/bin"
    path+="$HOME/.gem/ruby/3.0.0/bin"
fi

if [[ -d "$HOME/Downloads/google-cloud-sdk" ]]
then
    source "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"
    source "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"
    export PROJECT_ID=$(gcloud config get-value project)
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ ! -f "$COMPLETION_DIR/_pass" ]]
then
    curl -L https://git.zx2c4.com/password-store/plain/src/completion/pass.zsh-completion > $COMPLETION_DIR/_pass
fi

if [[ ! -f "$COMPLETION_DIR/aws_zsh_completer.sh" ]]
then
    curl -L https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > $COMPLETION_DIR/aws_zsh_completer.sh
fi

if [[ -d "$HOME/.krew" ]]
then
    path+="$HOME/.krew/bin"
fi

if [[ -d "/opt/homebrew/opt/libpq/bin" ]]
then
    path+="/opt/homebrew/opt/libpq/bin"
fi
