# nerd-fonts

[https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

## Install

<details>
<summary>macOS</summary>

```bash
brew install homebrew/cask-fonts/font-fira-code-nerd-font
```

</details>

<details>
<summary>Windows</summary>

Download and install `Fira Code Nerd Font Mono` fonts.

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

</details>

## Uninstall

<details>
<summary>macOS</summary>

```bash
brew uninstall homebrew/cask-fonts/font-fira-code-nerd-font
```

</details>

<details>
<summary>Windows</summary>

You have to remove the fonts manually in `Font settings`.

<!--
TODO: Investigate uninstall script
https://www.powershellgallery.com/packages/PSWinGlue/0.5.5/Content/Scripts%5CUninstall-Font.ps1

del /q /f /s /a %LOCALAPPDATA%\Microsoft\Windows\Fonts\FiraCodeNerdFontMono*.ttf
-->

</details>
