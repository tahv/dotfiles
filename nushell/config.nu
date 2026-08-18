$env.config.buffer_editor = "nvim"
$env.config.table.mode = "light"
$env.config.show_banner = "short"

print $"(ansi ($env.config.color_config?.banner_highlight1? | default "green"))(ansi attr_bold)Nushell (ansi reset)v(version | get version)(ansi reset)"

# Helper function for creating files in 'vendor/autoload'
def make-vendor-file [app: string, activate: closure, filename: string] {
    let filepath = $"($nu.data-dir)" | path join vendor autoload $filename
    if ($filepath | path exists) { return }
    if (which $app | is-empty) { return }
    mkdir ($filepath | path dirname)
    do $activate | save -f $filepath
}

make-vendor-file "starship" {|| starship init nu } "starship.nu"
make-vendor-file "mise" {|| mise activate nu } "mise.nu"
make-vendor-file "just" {|| just --completions nushell } "just-completion.nu"
make-vendor-file "uv" {|| uv generate-shell-completion nushell } "uv-completion.nu"
# TODO: mise-completion.nu: https://github.com/jdx/mise/discussions/4974
hide make-vendor-file

alias vim = nvim
alias v = nvim
def ll [] {
    ls -la | select mode? user? size modified name target
}

source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)
