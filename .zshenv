export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"

if [ -e /home/pcaulagi/.nix-profile/etc/profile.d/nix.sh ]; then . /home/pcaulagi/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
