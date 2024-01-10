# neovim

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

## Installation

### macOS

> **Note:** require [nerd-fonts](../nerdfonts)

```bash
brew install neovim ripgrep
ln -s $(pwd)/nvim ~/.config/nvim
```

### Windows

> **Note:** require [nerd-fonts](../nerdfonts)

> **TODO:** install `ripgrep` (telescope) and a 
> [C compiler](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)
> (treesitter)

```bat
winget install --exact --id Neovim.Neovim
mklink /D "%LOCALAPPDATA%\nvim" "%cd%\nvim"
```

## Uninstall

### macOS

```bash
brew uninstall neovim ripgrep
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

### Windows

> **TODO:** uninstall `ripgrep` and the C compiler

```bat
winget uninstall --exact --id Neovim.Neovim
rd /q /s "%LOCALAPPDATA%\nvim" 2>nul
```
