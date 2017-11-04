#!/bin/sh

mkdir -pv ~/.zsh/completion

curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > ~/.zsh/completion/_docker
curl -L https://git.zx2c4.com/password-store/plain/src/completion/pass.zsh-completion > ~/.zsh/completion/_pass
rustup completions zsh > ~/.zsh/completion/_rustup
helm completion zsh > ~/.zsh/completion/_helm
curl -L https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > ~/.zsh/completion/aws_zsh_completer.sh
