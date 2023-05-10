# lazyvim

[https://github.com/LazyVim/LazyVim](https://github.com/LazyVim/LazyVim)

[starter](https://github.com/LazyVim/starter)

## Install

<details>
<summary>macOS</summary>

> require [nerd-fonts](../nerdfonts)

Make a backup of your current neovim config.

```bash
# required
mv ~/.config/nvim ~/.config/nvim.bak

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Or delete them.

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
