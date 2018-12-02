set -x theme_color_scheme zenburn
set -x EDITOR nvim
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8


set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x theme_nerd_fonts yes
set -x fish_key_bindings fish_vi_key_bindings

# don't show brew git information on brew commands
set -x HOMEBREW_NO_GITHUB_API 1

set -x GPG_TTY (tty)
set -x OPENSSL_LIB_DIR /usr/local/opt/openssl/lib
set -x OPENSSL_INCLUDE_DIR /usr/local/opt/openssl/include

# use gitignore when searching with fzf
# export FZF_DEFAULT_COMMAND='ag -g ""'

# source ~/Downloads/google-cloud-sdk/path.fish.inc

set -x PROJECT_ID `gcloud config get-value project`
set -x HOST_IP 192.168.65.2
set -x NNTPSERVER nntp.aioe.org

set -x GOPATH ~/go
set -x PATH $GOPATH/bin $PATH

. ~/.alias
. ~/.personal

eval (direnv hook fish)
