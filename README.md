# dotfiles

My personal dotfiles, with installation instructions.

## [alacritty](https://github.com/alacritty/alacritty)

### Install - macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install alacritty
ln -s $(pwd)/alacritty ~/.config/alacritty
```

### Install - Windows

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Alacritty.Alacritty
mklink /D "%APPDATA%\alacritty" "%cd%\alacritty"
```

### Uninstall - macOS

```bash
brew uninstall alacritty
rm -rf ~/.config/alacritty
```

### Uninstall - Windows

```bat
winget uninstall --exact --id Alacritty.Alacritty
rd /q /s "%APPDATA%\alacritty"
```

## [clink](https://chrisant996.github.io/clink)

### Install - Windows

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id chrisant996.Clink
mklink "%LOCALAPPDATA%\clink\clink_settings" "%cd%\clink\clink_settings"
clink installscripts "%cd%\clink\scripts"
```

### Uninstall - Windows

```bat
winget uninstall --exact --id chrisant996.Clink
clink uninstallscripts "%cd%\clink\scripts"
rd /q /s "%LOCALAPPDATA%\clink" 2>nul
```

## git

### Install - macOS

<!-- TODO: move ./git/git -> ./git -->

```bash
brew install git
ln -s $(pwd)/git/git ~/.config/git
```

### Install - Windows

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Git.Git
mkdir "%USERPROFILE%\.config" 2>nul
mklink /D "%USERPROFILE%\.config\git" "%cd%\git\git"
```

### Uninstall - macOS

```bash
brew uninstall git
rm -rf ~/.config/git
```

### Uninstall - Windows

```bat
winget uninstall --exact --id Git.Git
rd /q /s "%USERPROFILE%\.config\git" 2>nul
```

## [ghostty](https://github.com/ghostty-org/ghostty)

### Install - macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install --cask ghostty
ln -s $(pwd)/ghostty ~/.config/ghostty
```

### Uninstall - macOS

```bash
brew uninstall --cask ghostty
rm -rf ~/.config/ghostty
```

## [neovim](https://github.com/neovim/neovim)

### Install - macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install neovim
brew install ripgrep
ln -s $(pwd)/neovim/nvim ~/.config/nvim
```

### Install - Windows

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Neovim.Neovim
winget install --exact --id BurntSushi.ripgrep.MSVC
mklink /D "%LOCALAPPDATA%\nvim" "%cd%\neovim\nvim"
echo @nvim.exe %*> "C:\Program Files\Neovim\bin\vim.bat"
```

### Uninstall - macOS

```bash
brew uninstall neovim
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

### Uninstall - Windows

```bat
winget uninstall --exact --id Neovim.Neovim
rd /q /s "%LOCALAPPDATA%\nvim" 2>nul
rd /q /s "%LOCALAPPDATA%\nvim-data" 2>nul
```

## [nerd-fonts](https://github.com/ryanoasis/nerd-fonts>)

### Install - macOS

```bash
brew install font-fira-code-nerd-font
```

### Install - Windows

> [!NOTE]
> [WinGet font support ryanoasis/nerd-fonts#1935](https://github.com/ryanoasis/nerd-fonts/issues/1935)

```bat
if exist %TEMP%\nerdfont (rmdir /s /q %TEMP%\nerdfont)
mkdir %TEMP%\nerdfont
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Bold/FiraCodeNerdFontMono-Bold.ttf
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Light/FiraCodeNerdFontMono-Light.ttf
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Medium/FiraCodeNerdFontMono-Medium.ttf
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Retina/FiraCodeNerdFontMono-Retina.ttf
curl -fLO --output-dir %TEMP%\nerdfont https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/SemiBold/FiraCodeNerdFontMono-SemiBold.ttf
powershell -Command "Get-ChildItem -Path $env:TEMP\nerdfont | % { (New-Object -ComObject Shell.Application).Namespace(0x14).CopyHere($_.fullname) }"
rmdir /s /q %TEMP%\nerdfont
```

### Uninstall - macOS

```bash
brew uninstall font-fira-code-nerd-font
```

### Uninstall - Windows

Manually remove the fonts in **Font settings**.

<!-- TODO: Investigate uninstall script

<https://www.powershellgallery.com/packages/PSWinGlue/0.5.5/Content/Scripts%5CUninstall-Font.ps1>

```bat
del /q /f /s /a %LOCALAPPDATA%\Microsoft\Windows\Fonts\FiraCodeNerdFontMono*.ttf
```
-->

## [nushell](https://www.nushell.sh/)

### Install - macOS

```bash
brew install nushell
ln -s $(pwd)/nushell/nushell ~/Library/Application\ Support/nushell
```

### Install - Windows

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install nushell
mklink /D "%APPDATA%\nushell" "%cd%\nushell\nushell"
```

### Uninstall - macOS

```bash
brew uninstall nushell
rm -rf ~/Library/Application\ Support/nushell
```

### Uninstall - Windows

```bat
winget install nushell
rd /q /s "%APPDATA%\nushell" 2>nul
```

## [starship](https://github.com/starship/starship)

### Install - macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

<!-- TODO: require bashrc dotfile -->

```bash
brew install starship
ln -s $(pwd)/starship/starship.toml ~/.config/starship.toml
```

### Install - Windows

> [!NOTE]
> Requires [clink](#clink) and [nerd-fonts](#nerd-fonts)

```bat
winget install --exact --id Starship.Starship
mklink "%USERPROFILE%\.config\starship.toml" "%cd%\starship\starship.toml"
```

### Uninstall - macOS

```bash
brew uninstall starship
rm -f ~/.config/starship.toml
```

### Uninstall - Windows

```bat
winget uninstall --id Starship.Starship
del /f /q "%USERPROFILE%\.config\starship.toml"
```

## [tmux](https://github.com/tmux/tmux)

### Install - macOS

```bash
brew install tmux
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf
```

### Uninstall - macOS

```bash
brew uninstall tmux
rm -f ~/.tmux.conf
```

## [Windows Terminal](https://github.com/microsoft/terminal)

### Install - Windows

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Microsoft.WindowsTerminal
mklink "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "%cd%\windows-terminal\settings.json"
```

### Uninstall - Windows

```bat
winget install --exact --id Microsoft.WindowsTerminal
del /f /q "%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
```

## [yabai](https://github.com/koekeishiya/yabai)

### Install - macOS

<!-- TODO: move ./yabai/yabai -> ./yabai -->

```bash
brew install asmvik/formulae/yabai jq
ln -s $(pwd)/yabai/yabai ~/.config/yabai
yabai --restart-service
```

### Uninstall - macOS

```bash
brew uninstall asmvik/formulae/yabai
rm -rf ~/.config/yabai
```
