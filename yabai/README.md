# yabai

[https://github.com/koekeishiya/yabai](https://github.com/koekeishiya/yabai)

> macOS only

## Install

Install software and create symlink

```bash
brew install koekeishiya/formulae/yabai
brew install jq
[ -d $(pwd)/yabai ] && ln -s $(pwd)/yabai ~/.config/yabai
yabai --restart-service
```

## Uninstall

Uninstall software and remove config

```bash
brew uninstall koekeishiya/formulae/yabai
brew uninstall jq
rm -rf ~/.config/yabai
```
