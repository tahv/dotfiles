# Print info during startup in the same style as nushell 'banner'
def print-info [title: string, message: string] {
    print $"(ansi ($env.config.color_config?.banner_highlight1? | default "green"))(ansi attr_bold)($title) (ansi reset)($message)(ansi reset)"
}

# Create file in the 'vendor/autoload' directory.
#
# File is created in an 'autoload' directory
# and doesn't need to be explicitely loaded with 'use' or 'source'.
#
# File is re-created even if it exist, potentially anytime nushell launches.
def make-autoload [apps: list<string>, activate: closure, filename: string] {
    let filepath = $"($nu.data-dir)" | path join "vendor" "autoload" $filename
    # TODO: call 'error make' if app is missing ?
    if ($apps | any { which $in | is-empty }) { return }
    mkdir ($filepath | path dirname)
    do $activate | save --force $filepath
    print-info "Created:" $"($filepath | path relative-to $nu.data-dir)"
}

print-info "Nushell:" $"v((version).version) \(((version).build_target))"

$env.config.buffer_editor = "nvim"
$env.config.table.mode = "light"
$env.config.show_banner = "short"
$env.PROMPT_COMMAND_RIGHT = ""

alias vim = nvim

const config = (
    if (sys host).hostname == "ANN-WKS-100027" { "config-work.nu" }
    else if (sys host).hostname == "tgambier-macbookpro.local" { "config-macbook.nu" }
    else if (sys host).hostname == "tgambier-macbookpro" { "config-macbook.nu" }
    else { null }
)
print-info "Loading:" ($config | default "no local config")
source $config
unlet $config

make-autoload [mise] { ^mise activate nu } "mise.nu"
source ("vendor" | path join "completion-mise.nu")
use ("vendor" | path join "starship.nu")
use ("vendor" | path join "completion-just.nu") *
use ("vendor" | path join "completion-uv.nu") *

hide print-info
hide make-autoload
