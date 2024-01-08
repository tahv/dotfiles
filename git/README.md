# git

## Installation

### macOS

```bash
brew install git
[ -d $(pwd)/git ] && ln -s $(pwd)/git ~/.config/git
```

### Windows

```bat
winget install --exact --id Git.Git
rd /q /s "%USERPROFILE%\.config\git" 2>nul || break
if not exist "%USERPROFILE%\.config" mkdir "%USERPROFILE%\.config" 
if exists git (mklink /D %USERPROFILE%\.config\git %cd%\git) || echo wrong directory
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
rd /q /s "%USERPROFILE%\.config\git" 2>nul || break
```
