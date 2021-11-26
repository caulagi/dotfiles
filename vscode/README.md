# Configuration for VS Code

On Mac, `settings.json` should be copied to `~/Library/Application\ Support/Code/User`

## Extensions

**Export**

```
code --list-extensions > vscode-extensions.list
```

**Import**

```
cat vscode-extensions.list | xargs -L 1 code --install-extension
```
