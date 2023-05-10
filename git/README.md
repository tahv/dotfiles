# git

## Install

<details>
<summary>macOS</summary>

Install software and create symlink

```bash
brew install git
[ -f $(pwd)/.gitconfig ] && ln -s $(pwd)/.gitconfig ~/.gitconfig
[ -f $(pwd)/.gitignore_global ] && ln -s $(pwd)/.gitignore_global ~/.gitignore_global
```

</details>

<!--
<details>
<summary>Windows</summary>

Install software and copy config

> the `.gitignore_global` won't work automatically on Windows, the `excludesfile` option
> in `.gitconfig` must be a full path.

```bat
winget install --exact --id Git.Git
xcopy .gitconfig "%USERPROFILE%\.gitconfig"
xcopy .gitignore_global "%USERPROFILE%\.gitignore_global"
```


</details>
-->

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall git
rm -f ~/.gitconfig ~/.gitignore_global
```

</details>

<!--
<details>
<summary>Windows</summary>

Uninstall software and remove config

```bat
winget uninstall --exact --id Git.Git
del /f "%USERPROFILE%\.gitconfig"
del /f "%USERPROFILE%\.gitignore_global"
```

</details>
-->
