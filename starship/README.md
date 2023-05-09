# starship

[https://github.com/starship/starship](https://github.com/starship/starship)

## Install

<details>
<summary>macOS</summary>

> require [nerd-fonts](../nerdfonts)

> require bashrc dotfile

Install software and create symlink

```bash
brew install starship
[ -f $(pwd)/starship.toml ] && ln -s $(pwd)/starship.toml ~/.config/starship.toml
```

</details>

<!--
<details>
<summary>Windows</summary>

> require powershell dotfile

Install software and copy config

```bat
winget install --exact --id Starship.Starship
xcopy starship.toml "%USERPROFILE%\.config\starship.toml"
```


</details>
-->

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall starship
rm -f ~/.config/starship.toml
```

</details>

<!--
<details>
<summary>Windows</summary>

Uninstall software and remove config

```bat
winget uninstall --id Starship.Starship
del /f "%"USERPROFILE%\.config\starship.toml"
```

</details>
-->
