use std/util "path add"

path add "~/.local/bin"
path add "~/.cargo/bin"
path add "/opt/homebrew/bin"
path add "~/.orbstack/bin"

# print MacBook battery health information
export def battery [] {
    system_profiler SPPowerDataType -json
    | from json
    | get SPPowerDataType
    | where {|x| $x._name == spbattery_information }
    | get 0.sppower_battery_health_info
    | rename --block { str title-case | split words | slice 2.. | str join " "}
}

# cd to dev directories
module cdd {
    const dev = '~/dev' | path expand
    def completion [] {
        ls -s $dev | where type != file | get name
    }
    export def --env main [dir?: string@completion] {
        cd ($dev | path join $'($dir)')
    }
}
use cdd

# update homebrew and upgrade all formulaes
export def brew_up [] {
    brew update
    brew upgrade
    brew cleanup
}

alias yrs = yabai --restart-service
alias fg = job unfreeze
