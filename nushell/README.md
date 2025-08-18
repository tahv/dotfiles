# Nushell

[www.nushell.sh](https://www.nushell.sh/)

## Install

### macOS

```bash
brew install nushell
ln -s $(pwd)/nushell ~/Library/Application\ Support/nushell
```

### Windows

> [!NOTE]
>
> - `mklink` requires admin privileges.

```bat
winget install nushell
mklink /D "%APPDATA%\nushell" "%cd%\nushell"
```

## Uninstall

### macOS

```bash
brew uninstall nushell
rm -rf ~/Library/Application\ Support/nushell
```

### Windows

```bat
winget install nushell
rd /q /s "%APPDATA%\nushell" 2>nul
```
