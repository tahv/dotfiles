$env.config.buffer_editor = "nvim"
$env.config.table.mode = "compact"

# $env.config.show_banner = false

let vendor_autoload = $"($nu.data-dir)/vendor/autoload"
mkdir $vendor_autoload

if (which starship | is-not-empty) {
    starship init nu | save -f $"($vendor_autoload)/starship.nu"
}

if (which mise | is-not-empty) {
    mise activate nu | save -f $"($vendor_autoload)/mise.nu"
    # TODO: completion: https://github.com/jdx/mise/discussions/4974
}

if (which just | is-not-empty) {
    just --completions nushell | save -f $"($vendor_autoload)/just-completion.nu"
}

if (which uv | is-not-empty) {
    uv generate-shell-completion nushell | save -f $"($vendor_autoload)/uv-completion.nu"
}

# site-specific config
source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)

alias vim = nvim
alias v = nvim
def ll [] {
    ls -la | select mode user size modified name target
}
