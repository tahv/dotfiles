# Windows Terminal

[https://github.com/microsoft/terminal](https://github.com/microsoft/terminal)

## Install

### Windows

> [!NOTE]
>
> - require [nerd-fonts](../nerdfonts).
> - `mklink` require admin privileges.

```bat
winget install --exact --id Microsoft.WindowsTerminal
mklink "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "%cd%\settings.json"
```

## Uninstall

### Windows

```bat
winget install --exact --id Microsoft.WindowsTerminal
del /f /q "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
```
