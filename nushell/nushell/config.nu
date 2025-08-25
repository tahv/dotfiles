# config.nu
#
# Installed by:
# version = "0.104.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options

# setup config
$env.config.buffer_editor = "nvim"
$env.config.table.mode = "compact"

# setup default vendor directory
mkdir ($nu.data-dir | path join "vendor/autoload")

# source "config-home.nu"
# source "config-ubisoft.nu"

source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)

# setup starship
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# source ../nu_scripts/custom-completions/git/git-completions.nu

# commands
alias vim = nvim
alias v = nvim
def ll [] { ls -la | select mode user size modified name target }
