set -xg theme_color_scheme gruvbox
set -xg theme_nerd_fonts no
set -xg fish_key_bindings fish_vi_key_bindings
set -xg theme_show_exit_status no

set -xg STARSHIP_SHELL fish
set -xg EDITOR nvim
set -xg GPG_TTY (tty)
set -xg HOMEBREW_NO_GITHUB_API 1 # don"t show brew git information on brew commands
set -xg LANG en_US.UTF-8
set -xg LC_ALL en_US.UTF-8
set -xg TF_LOG INFO
set -xg TF_LOG_PATH /tmp/terraform.log

if test -f /opt/homebrew/bin/brew
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/sbin
end

if type -p go >/dev/null 2>&1
    set -xg GOPATH ~/src/go
    fish_add_path $GOPATH/bin
end

if type -p yarn >/dev/null 2>&1
    fish_add_path $HOME/.yarn/bin
    fish_add_path $HOME/.config/yarn/global/node_modules/.bin
end

if type -p direnv >/dev/null 2>&1
    direnv hook fish | source
end

if test -d $HOME/.cargo
    fish_add_path $HOME/.cargo/bin
end

source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

if [ -f "$HOME/Downloads/google-cloud-sdk/path.fish.inc" ]
    set -Ux PYENV_ROOT $HOME/.local/share/pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
    pyenv shell 3.10.7
    . "$HOME/Downloads/google-cloud-sdk/path.fish.inc"
end

if [ -f "$HOME/.local/profile" ]; source "$HOME/.local/profile"; end
if [ -f "$HOME/.local/alias" ]; source "$HOME/.local/alias"; end

if [ -d "$HOME/Library/Android/sdk" ];
    set -xg ANDROID_HOME "$HOME/Library/Android/sdk"
    fish_add_path $ANDROID_HOME/emulator
    fish_add_path $ANDROID_HOME/tools
    fish_add_path $ANDROID_HOME/tools/bin
    fish_add_path $ANDROID_HOME/platform-tools
end

zoxide init fish | source

# If running from tty1 start sway
set TTY1 (tty)
if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
    set -xg XDG_CURRENT_DESKTOP sway
    exec sway
end

starship init fish | source

if [ -d "/usr/local/opt/ruby" ];
    fish_add_path "/usr/local/opt/ruby/bin"
    fish_add_path "$HOME/.gem/ruby/3.0.0/bin"
end

if [ -d $HOME/.local/bin ]
    fish_add_path $HOME/.local/bin
end

if [ -d $HOME/.krew ]
    fish_add_path $HOME/.krew/bin
end

if [ -d /opt/homebrew/opt/libpq/bin ]
    fish_add_path /opt/homebrew/opt/libpq/bin
end

set -xg KIND_EXPERIMENTAL_PROVIDER podman
