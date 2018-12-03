set -xg theme_color_scheme zenburn
set -xg theme_nerd_fonts yes
set -xg fish_key_bindings fish_vi_key_bindings
set -xg theme_show_exit_status no

set -xg EDITOR nvim
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8

set -xg VIRTUAL_ENV_DISABLE_PROMPT 1

# don't show brew git information on brew commands
set -xg HOMEBREW_NO_GITHUB_API 1

set -xg GPG_TTY (tty)
set -xg OPENSSL_LIB_DIR /usr/local/opt/openssl/lib
set -xg OPENSSL_INCLUDE_DIR /usr/local/opt/openssl/include

# use gitignore when searching with fzf
# export FZF_DEFAULT_COMMAND='ag -g ""'

# source ~/Downloads/google-cloud-sdk/path.fish.inc

set -xg PROJECT_ID `gcloud config get-value project`
set -xg HOST_IP 192.168.65.2
set -xg NNTPSERVER nntp.aioe.org

set -xg GOPATH ~/go
set -xg PATH $GOPATH/bin $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $HOME/.cargo/bin $PATH

. ~/.alias
. ~/.personal

eval (direnv hook fish)