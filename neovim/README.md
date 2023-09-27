# neovim

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

## Install

<details>
<summary>macOS</summary>

> require [nerd-fonts](../nerdfonts)

Delete current neovim config.

```bash
# required
rm -rf ~/.config/nvim

# optional but recommended
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

Install software and create symlink.

```bash
brew install neovim lazygit ripgrep
[ -d $(pwd)/nvim ] && ln -s $(pwd)/nvim ~/.config/nvim
```

</details>

## Uninstall

<details>
<summary>macOS</summary>

Uninstall software and remove config.

```bash
brew uninstall neovim lazygit ripgrep
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

</details>
