# Print info during startup in the same style as nushell 'banner'
def print-info [title: string, message: string] {
    print $"(ansi ($env.config.color_config?.banner_highlight1? | default "green"))(ansi attr_bold)($title) (ansi reset)($message)(ansi reset)"
}
print-info "Nushell:" $"v((version).version) \(((version).build_target))"

$env.config.buffer_editor = "nvim"
$env.config.table.mode = "light"
$env.config.show_banner = "short"
$env.PROMPT_COMMAND_RIGHT = ""

alias vim = nvim

const config = (
    if (sys host).hostname == "ANN-WKS-100027" { "config-work.nu" }
    else if (sys host).hostname == "macbookpro.home" { "config-macbook.nu" }
    else if (sys host).hostname == "tgambier-macbookpro.local" { "config-macbook.nu" }
    else { null }
)
print-info "Loading:" ($config | default "no local config")
source $config
unlet $config

use ("vendor" | path join "mise.nu") *
source ("vendor" | path join "completion-mise.nu")
use ("vendor" | path join "starship.nu") *
use ("vendor" | path join "completion-just.nu") *
use ("vendor" | path join "completion-uv.nu") *

hide print-info
