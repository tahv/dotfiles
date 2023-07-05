# alacritty

[https://github.com/alacritty/alacritty](https://github.com/alacritty/alacritty)

## Install

<details>
<summary>macOS</summary>

> require [nerd-fonts](../nerdfonts)

Install software and create symlink.

```bash
brew install alacritty
[ -f $(pwd)/alacritty.yml ] && mkdir ~/.config/alacritty && ln -s $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml
```

</details>

<details>
<summary>Windows</summary>

> require [nerd-fonts](../nerdfonts)

Install software and create symlink.

> mklink require **admin**.

```bat
winget install Alacritty.Alacritty
if exist %APPDATA%\alacritty (rmdir /s /q %APPDATA%\alacritty)
if exist alacritty.yml (mkdir %APPDATA%\alacritty & mklink %APPDATA%\alacritty\alacritty.yml %cd%\alacritty.yml)
```

</details>

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall alacritty
rm -rf ~/.config/alacritty
```

</details>

<details>
<summary>Windows</summary>

Uninstall software and remove config.

```bat
winget uninstall Alacritty.Alacritty
if exist %APPDATA%\alacritty (rmdir /s /q %APPDATA%\alacritty)
```

</details>
