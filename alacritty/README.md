# alacritty

[https://github.com/alacritty/alacritty](https://github.com/alacritty/alacritty)

## Installation

### macOS

> require [nerd-fonts](../nerdfonts)

```bash
brew install alacritty
mkdir -p ~/.config/alacritty 
ln -s $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml
```

### Windows

> require [nerd-fonts](../nerdfonts)

> **Note:** mklink require admin privileges.

```bat
winget install --exact --id Alacritty.Alacritty
mkdir "%APPDATA%\alacritty" 2>nul
mklink "%APPDATA%\alacritty\alacritty.yml" "%cd%\alacritty.yml"
```

## Uninstall

### macOS

```bash
brew uninstall alacritty
rm -rf ~/.config/alacritty
```

### Windows

```bat
winget uninstall --exact --id Alacritty.Alacritty
rd /q /s "%APPDATA%\alacritty" 2>nul
```
