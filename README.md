# dotfiles

Personal dotfiles, using [dotter](https://github.com/SuperCuber/dotter) for symlinking.

Install dotter:

```bash
# on macOS with homebrew
brew install dotter

# on Windows with winget
winget install --exact --id SuperCuber.Dotter
```

Symlink the files & directories:

> [!WARNING]
> On Windows, in order to create symbolic links, either
> [**Developer Mode**](https://learn.microsoft.com/en-us/windows/advanced-settings/developer-mode)
> must be enabled, or the command must be **run as administrator**.

```bash
dotter deploy

# don't deploy, just print information
dotter deploy --dry-run

# force deployment if targets already exists
dotter deploy --force
```

When editing existing config, changes are immediately active, no rebuild needed.

## Installations

<details>
<summary><b>alacritty</b></summary>

> [!NOTE]
> Requires `nerd-fonts`.

```bash
# macOS
brew install alacritty

# Windows
winget install --exact --id Alacritty.Alacritty
```

</details>

<details>
<summary><b>clink</b></summary>

```bash
# Windows
winget uninstall --exact --id chrisant996.Clink
```

</details>

<details>
<summary><b>git</b></summary>

```bash
# macOS
brew install git

# Windows
winget install --exact --id Git.Git
```

</details>

<details>
<summary><b>ghostty</b></summary>

```bash
# macOS
brew install --cask ghostty
```

</details>

<details>
<summary><b>neovim</b></summary>

> [!NOTE]
> Requires `nerd-fonts`.

```bash
# macOS
brew install neovim ripgrep

# windows
winget install --exact --id Neovim.Neovim
winget install --exact --id BurntSushi.ripgrep.MSVC
```

</details>

<details>
<summary><b>nerd-fonts</b></summary>

### macOS

> [!NOTE]
> [WinGet font support ryanoasis/nerd-fonts#1935](https://github.com/ryanoasis/nerd-fonts/issues/1935)

```bash
# macOS
brew install font-fira-code-nerd-font

# Windows
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

<!-- TODO: Investigate uninstall script
https://www.powershellgallery.com/packages/PSWinGlue/0.5.5/Content/Scripts%5CUninstall-Font.ps1

```bat
del /q /f /s /a %LOCALAPPDATA%\Microsoft\Windows\Fonts\FiraCodeNerdFontMono*.ttf
```
-->

</details>

<details>
<summary><b>nushell</b></summary>

```bash
# macOS
brew install nushell

# windows
winget install nushell
```

</details>

<details>
<summary><b>starship</b></summary>

> [!NOTE]
> Requires `nerd-fonts` (and `clink` on Windows).

<!-- TODO: require bashrc dotfile on unix -->

```bash
# macOS
brew install starship

# windows
winget install --exact --id Starship.Starship
```

</details>

<details>
<summary><b>tmux</b></summary>

```bash
# macOS
brew install tmux
```

</details>

<details>
<summary><b>Windows Terminal</b></summary>

> [!NOTE]
> Requires `nerd-fonts`.

```bash
# Windows
winget install --exact --id Microsoft.WindowsTerminal
```

</details>

<details>
<summary><b>yabai</b></summary>

```bash
# macOS
brew install asmvik/formulae/yabai jq
yabai --restart-service
```

</details>
