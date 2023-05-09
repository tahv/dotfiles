# alacritty

[https://github.com/alacritty/alacritty](https://github.com/alacritty/alacritty)

## Install

<details>
<summary>macOS</summary>

> require [nerd-fonts](../nerdfonts)

Install software and create symlink

```bash
brew install alacritty
[ -f $(pwd)/alacritty.yml ] && mkdir ~/.config/alacritty && ln -s $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml
```

</details>

<!--
<details>
<summary>Windows</summary>

> require powershell dotfile

Install software and copy config

```bat
winget install --exact --id Alacritty.Alacritty
xcopy alacritty.yml "%APPDATA%\alacritty\alacritty.yml"
```


</details>
-->

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall alacritty
rm -rf ~/.config/alacritty
```

</details>

<!--
<details>
<summary>Windows</summary>

Uninstall software and remove config

```bat
winget uninstall --exact --id Alacritty.Alacritty
rmdir "%APPDATA%\alacritty"
```

</details>
-->
