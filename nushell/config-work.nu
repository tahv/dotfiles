alias cat = open -r

export def ll [] {
    ls -la | select size modified name target
}

def completion_cdd [] {
    ls --short-names 'D:\dev' | where type == dir | get name
}

# Change to a dev directory
export def --env cdd [dir?: string@completion_cdd] {
    cd ('D:\dev' | path join $"($dir)")
}
