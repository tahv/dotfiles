# dotfiles

Personal dotfiles and install instructions.

<!-- TODO: nushell -->
<!-- TODO: clink -->
<!-- TODO: starship -->
<!-- TODO: tmux -->
<!-- TODO: windows-terminal -->
<!-- TODO: yabai -->

## [alacritty](github.com/alacritty/alacritty)

### Installation: macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install alacritty
ln -s $(pwd)/alacritty ~/.config/alacritty
```

### Installation: Windows

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Alacritty.Alacritty
mklink /D "%APPDATA%\alacritty" "%cd%\alacritty"
```

### Uninstallation: macOS

```bash
brew uninstall alacritty
rm -rf ~/.config/alacritty
```

### Uninstallation: Windows

```bat
winget uninstall --exact --id Alacritty.Alacritty
rd /q /s "%APPDATA%\alacritty"
```

## git

### Installation: macOS

<!-- TODO: move ./git/git -> ./git -->

```bash
brew install git
ln -s $(pwd)/git/git ~/.config/git
```

### Installation: Windows

> [!WARNING]
> `mklink` requires **admin** privileges.

```bat
winget install --exact --id Git.Git
mkdir "%USERPROFILE%\.config" 2>nul
mklink /D "%USERPROFILE%\.config\git" "%cd%\git\git"
```

### Uninstallation: macOS

```bash
brew uninstall git
rm -rf ~/.config/git
```

### Uninstallation: Windows

```bat
winget uninstall --exact --id Git.Git
rd /q /s "%USERPROFILE%\.config\git" 2>nul
```

## [ghostty](https://github.com/ghostty-org/ghostty)

### Installation: macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install --cask ghostty
ln -s $(pwd)/ghostty ~/.config/ghostty
```

### Uninstallation: macOS

```bash
brew uninstall --cask ghostty
rm -rf ~/.config/ghostty
```

## [neovim](https://github.com/neovim/neovim)

### Installation: macOS

> [!NOTE]
> Requires [nerd-fonts](#nerd-fonts)

```bash
brew install neovim
brew install ripgrep
ln -s $(pwd)/neovim/nvim ~/.config/nvim
```

### Installation: Windows

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

### Uninstallation: macOS

```bash
brew uninstall neovim
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

### Uninstallation: Windows

```bat
winget uninstall --exact --id Neovim.Neovim
rd /q /s "%LOCALAPPDATA%\nvim" 2>nul
rd /q /s "%LOCALAPPDATA%\nvim-data" 2>nul
```

## [nerd-fonts](https://github.com/ryanoasis/nerd-fonts>)

### Installation: macOS

```bash
brew install font-fira-code-nerd-font
```

### Installation: Windows

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

### Uninstallation: macOS

```bash
brew uninstall font-fira-code-nerd-font
```

### Uninstallation: Windows

Manually remove the fonts in **Font settings**.

<!-- TODO: Investigate uninstall script

<https://www.powershellgallery.com/packages/PSWinGlue/0.5.5/Content/Scripts%5CUninstall-Font.ps1>

```bat
del /q /f /s /a %LOCALAPPDATA%\Microsoft\Windows\Fonts\FiraCodeNerdFontMono*.ttf
```
-->
