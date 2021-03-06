set -xg theme_color_scheme gruvbox
set -xg theme_nerd_fonts no
set -xg fish_key_bindings fish_vi_key_bindings
set -xg theme_show_exit_status no

set -xg STARSHIP_SHELL fish
set -xg EDITOR nvim
set -xg GPG_TTY (tty)
set -xg HOMEBREW_NO_GITHUB_API 1 # don"t show brew git information on brew commands
set -xg HOST_IP 192.168.65.2
set -xg LANG en_US.UTF-8
set -xg LC_ALL en_US.UTF-8
set -xg TF_LOG INFO
set -xg TF_LOG_PATH /tmp/terraform.log
set -xg VIRTUAL_ENV_DISABLE_PROMPT 1
set -xg WEECHAT_HOME $XDG_CONFIG_HOME/weechat
set -xg PATH ~/bin $PATH
set -gx PATH $PATH $HOME/.krew/bin

if type -p go >/dev/null 2>&1
    set -xg GOPATH ~/src/go
    set -xg PATH $GOPATH/bin $PATH
end

if type -p yarn >/dev/null 2>&1
    set -xg PATH $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $PATH
end

if type -p direnv >/dev/null 2>&1
    eval (direnv hook fish)
end

if test -d $HOME/.cargo
    set -xg PATH $HOME/.cargo/bin $PATH
end

source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

if [ -f "$HOME/Downloads/google-cloud-sdk/path.fish.inc" ]; . "$HOME/Downloads/google-cloud-sdk/path.fish.inc"; end

if [ -f "$HOME/.local/profile" ]; source "$HOME/.local/profile"; end
if [ -f "$HOME/.local/alias" ]; source "$HOME/.local/alias"; end

if [ -d "$HOME/Library/Android/sdk" ];
    set -xg ANDROID_HOME "$HOME/Library/Android/sdk"
    set -xg PATH $ANDROID_HOME/emulator $PATH
    set -xg PATH $ANDROID_HOME/tools $PATH
    set -xg PATH $ANDROID_HOME/tools/bin $PATH
    set -xg PATH $ANDROID_HOME/platform-tools $PATH
end

zoxide init fish | source

# If running from tty1 start sway
set TTY1 (tty)
if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
    exec sway
end

starship init fish | source

if [ -d "/usr/local/opt/ruby" ];
    set -xg PATH "/usr/local/opt/ruby/bin" $PATH
    set -xg PATH "$HOME/.gem/ruby/3.0.0/bin" $PATH
end
