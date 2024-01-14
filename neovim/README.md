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

> **Note:** mklink require admin privileges.

```bat
winget install --exact --id Neovim.Neovim
winget install --exact --id BurntSushi.ripgrep.MSVC
mklink /D "%LOCALAPPDATA%\nvim" "%cd%\nvim"
echo nvim.exe %*> "C:\Program Files\Neovim\bin\vim.bat"
```

## Uninstall

### macOS

```bash
brew uninstall neovim ripgrep
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim
```

### Windows

```bat
winget uninstall --exact --id Neovim.Neovim
winget uninstall --exact --id BurntSushi.ripgrep.MSVC
rd /q /s "%LOCALAPPDATA%\nvim" 2>nul
rd /q /s "%LOCALAPPDATA%\nvim-data" 2>nul
```
