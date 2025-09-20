# setup config
$env.config.buffer_editor = "nvim"
$env.config.table.mode = "compact"
# $env.config.show_banner = false

# setup default vendor directory
mkdir ($nu.data-dir | path join "vendor/autoload")

source (
    if $nu.os-info.family == windows { 'config-ubisoft.nu' }
    else { 'config-home.nu' }
)

# setup starship
if not (which starship | is-empty) {
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

# setup fnm
if not (which fnm | is-empty) {
    # From: https://github.com/Schniz/fnm/issues/463
    ^fnm env --json | from json | load-env

    $env.PATH = $env.PATH | prepend ($env.FNM_MULTISHELL_PATH | path join (if $nu.os-info.name == 'windows' {''} else {'bin'}))
    $env.config.hooks.env_change.PWD = (
        $env.config.hooks.env_change.PWD? | append {
            condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|el| $el | path exists}}
            code: {|| ^fnm use --silent-if-unchanged --install-if-missing}
        }
    )
}

# source ../nu_scripts/custom-completions/git/git-completions.nu

# commands
alias vim = nvim
alias v = nvim
def ll [] { ls -la | select mode user size modified name target }
