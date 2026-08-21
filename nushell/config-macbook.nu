export-env {
  $env.PATH ++= [
      "~/.local/bin",
      "~/.cargo/bin",
      "/opt/homebrew/bin",
      "~/.orbstack/bin",
  ]
}

alias yrs = yabai --restart-service
alias fg = job unfreeze

export def ll [] {
    ls -la | select mode user size modified name target
}

# Print MacBook battery health information
export def battery [] {
    system_profiler SPPowerDataType -json
    | from json
    | get SPPowerDataType
    | where {|x| $x._name == spbattery_information }
    | get 0.sppower_battery_health_info
    | rename --block { str title-case | split words | slice 2.. | str join " "}
}

# Update homebrew and upgrade all formulaes
export def brew_up [] {
    brew update
    brew upgrade
    brew cleanup
}

def completion_cdd [] {
    ls --short-names ("~/dev" | path expand) | where type == dir | get name
}

# Change to a dev directory
export def --env cdd [dir?: string@completion_cdd] {
    cd ("~/dev" | path join $"($dir)")
}
