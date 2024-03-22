# clink

[https://chrisant996.github.io/clink](https://chrisant996.github.io/clink)

## Install

### Windows

```bat
winget install clink
mklink "%LOCALAPPDATA%\clink\clink_settings" "%cd%\clink_settings"
mklink "%LOCALAPPDATA%\clink\starship.lua" "%cd%\starship.lua"
```

## Uninstall

### Windows

```bat
winget uninstall clink
rd /q /s "%LOCALAPPDATA%\clink" 2>nul
```
