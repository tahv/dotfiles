# git

## Installation

### macOS

```bash
brew install git
ln -s $(pwd)/git ~/.config/git
```

### Windows

> **Note:** mklink require admin privileges.

```bat
winget install --exact --id Git.Git
mkdir "%USERPROFILE%\.config" 2>nul
mklink /D "%USERPROFILE%\.config\git" "%cd%\git"
```

## Uninstallation

### macOS

```bash
brew uninstall git
rm -rf ~/.config/git
```

### Windows

```bat
winget uninstall --exact --id Git.Git
rd /q /s "%USERPROFILE%\.config\git" 2>nul
```
