# alacritty

[https://github.com/alacritty/alacritty](https://github.com/alacritty/alacritty)

## Installation

### macOS

> [!NOTE]
> require [nerd-fonts](../nerdfonts).

```bash
brew install alacritty
mkdir -p ~/.config/alacritty
ln -s $(pwd)/alacritty.toml ~/.config/alacritty/alacritty.toml
```

### Windows

> [!NOTE]
>
> - require [nerd-fonts](../nerdfonts).
> - `mklink` require admin privileges.

```bat
winget install --exact --id Alacritty.Alacritty
mkdir "%APPDATA%\alacritty"
mklink "%APPDATA%\alacritty\alacritty.toml" "%cd%\alacritty.toml"
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
rd /q /s "%APPDATA%\alacritty"
```
