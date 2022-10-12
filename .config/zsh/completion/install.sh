#!/bin/sh

mkdir -pv ~/.zsh/completion

curl -L https://git.zx2c4.com/password-store/plain/src/completion/pass.zsh-completion > ~/.zsh/completion/_pass
curl -L https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh > ~/.zsh/completion/aws_zsh_completer.sh
pipenv --completion > ~/.zsh/completion/_pipenv
