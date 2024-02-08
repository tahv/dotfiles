# starship

[https://github.com/starship/starship](https://github.com/starship/starship)

## Install

### macOS

> require [nerd-fonts](../nerdfonts)

<!-- TODO: require bashrc dotfile -->

Install software and create symlink

```bash
brew install starship
ln -s $(pwd)/starship.toml ~/.config/starship.toml
```

### Windows

> require [clink](../clink) and [nerd-fonts](../nerdfonts)

```bat
winget install --exact --id Starship.Starship
mklink "%USERPROFILE%\.config\starship.toml" "%cd%\starship.toml"
echo load(io.popen('starship init cmd'):read("*a"))() > "%LOCALAPPDATA%\clink\starship.lua"
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
del /f /q "%LOCALAPPDATA%\clink\starship.lua"
```
