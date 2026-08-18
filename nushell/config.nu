$env.config.buffer_editor = "nvim"
$env.config.table.mode = "light"
$env.config.show_banner = "short"

print $"(ansi ($env.config.color_config?.banner_highlight1? | default "green"))(ansi attr_bold)Nushell (ansi reset)v(version | get version)(ansi reset)"

def mkvendor [apps: list<string>, activate: closure, filename: string] {
    let filepath = $"($nu.data-dir)" | path join vendor autoload $filename
    if ($filepath | path exists) { return }
    if ($apps | any {|| which $in | is-empty }) { return }
    mkdir ($filepath | path dirname)
    do $activate | save -f $filepath
}

mkvendor [starship] {|| starship init nu } "starship.nu"
mkvendor [mise] {|| mise activate nu } "mise.nu"
mkvendor [just] {|| just --completions nushell } "completion-just.nu"
mkvendor [uv] {|| uv generate-shell-completion nushell } "completion-uv.nu"
(mkvendor
    [mise, usage]
    {|| mise usage | usage g completion nu mise -f - }
    "completion-mise.nu"
)
hide mkvendor

alias vim = nvim
alias v = nvim
def ll [] { ls -la | select mode? user? size modified name target }

source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)
