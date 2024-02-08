# clink

[https://chrisant996.github.io/clink](https://chrisant996.github.io/clink)

## Install

### Windows

```bat
winget install clink
del /f /q "%LOCALAPPDATA%\clink\clink_settings"
mklink "%LOCALAPPDATA%\clink\clink_settings" "%cd%\clink_settings"
```

## Uninstall

### Windows

```bat
winget uninstall clink
rd /q /s "%LOCALAPPDATA%\clink" 2>nul
```
