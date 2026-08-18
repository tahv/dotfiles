$env.config.buffer_editor = "nvim"
$env.config.table.mode = "light"
$env.config.show_banner = "short"

print $"(ansi ($env.config.color_config?.banner_highlight1? | default "green"))(ansi attr_bold)Nushell (ansi reset)v(version | get version)(ansi reset)"

let vendor_autoload = $"($nu.data-dir)/vendor/autoload"
mkdir $vendor_autoload

if (which starship | is-not-empty) {
    starship init nu | save -f $"($vendor_autoload)/starship.nu"
}

# TODO: completion: https://github.com/jdx/mise/discussions/4974
if (which mise | is-not-empty) {
    mise activate nu | save -f $"($vendor_autoload)/mise.nu"
}

if (which just | is-not-empty) {
    just --completions nushell
    | save -f $"($vendor_autoload)/just-completion.nu"
}

if (which uv | is-not-empty) {
    uv generate-shell-completion nushell
    | save -f $"($vendor_autoload)/uv-completion.nu"
}

alias vim = nvim
alias v = nvim
def ll [] {
    ls -la | select mode user size modified name target
}

source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)
