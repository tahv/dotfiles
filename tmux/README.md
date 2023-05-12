# tmux

[https://github.com/tmux/tmux](https://github.com/tmux/tmux)

## Install

<details>
<summary>macOS</summary>

Install software and create symlink

```bash
brew install tmux
[ -f $(pwd)/.tmux.conf ] && ln -s $(pwd)/.tmux.conf ~/.tmux.conf
```

</details>


## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config

```bash
brew uninstall tmux
rm -f ~/.tmux.conf
```

</details>
