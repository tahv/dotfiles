use std/util "path add"

path add "~/.local/bin"
path add "~/.cargo/bin"
path add "/opt/homebrew/bin"
path add "~/.orbstack/bin"

# Display macbook battery health info
export def battery [] {
    system_profiler SPPowerDataType -json
    | from json
    | get SPPowerDataType
    | where {|x| $x._name == spbattery_information }
    | get 0.sppower_battery_health_info
}

# Quickly cd to dev directory
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

# Update homebrew packages
export def update_all_formulae [] {
    brew update   # update homebrew
    brew upgrade  # update packages
    brew cleanup  # remove old versions
}

alias yrs = yabai --restart-service
