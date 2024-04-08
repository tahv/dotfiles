# starship

[https://github.com/starship/starship](https://github.com/starship/starship)

## Install

### macOS

> require [nerd-fonts](../nerdfonts)

<!-- TODO: require bashrc dotfile -->

```bash
brew install starship
ln -s $(pwd)/starship.toml ~/.config/starship.toml
```

### Windows

> require [clink](../clink) and [nerd-fonts](../nerdfonts)

```bat
winget install --exact --id Starship.Starship
mklink "%USERPROFILE%\.config\starship.toml" "%cd%\starship.toml"
```

## Uninstall

### macOS

```bash
brew uninstall starship
rm -f ~/.config/starship.toml
```

### Windows

```bat
winget uninstall --id Starship.Starship
del /f /q "%USERPROFILE%\.config\starship.toml"
```
