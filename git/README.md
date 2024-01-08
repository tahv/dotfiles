# git

## Installation

### macOS

```bash
brew install git
[ -d $(pwd)/git ] && ln -s $(pwd)/git ~/.config/git
```

### Windows

> **Note:** mklink require admin privilege.

```bat
winget install --exact --id Git.Git
mkdir "%USERPROFILE%\.config" 2>nul
rd /q /s "%USERPROFILE%\.config\git" 2>nul
mklink /D "%USERPROFILE%\.config\git" "%cd%\git"
```

</details>

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
