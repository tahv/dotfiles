# git

## Install

<details>
<summary>macOS</summary>

Install software and create symlink

```bash
brew install git
[ -f $(pwd)/.gitconfig ] && ln -s $(pwd)/.gitconfig ~/.gitconfig
```

</details>

<!--
<details>
<summary>Windows</summary>

> require powershell dotfile

Install software and copy config

```bat
winget install --exact --id Git.Git
xcopy .gitconfig "%USERPROFILE%\.gitconfig"
```


</details>
-->

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall git
rm -f ~/.gitconfig
```

</details>

<!--
<details>
<summary>Windows</summary>

Uninstall software and remove config

```bat
winget uninstall --exact --id Git.Git
del /f "%"USERPROFILE%\.gitconfig"
```

</details>
-->
