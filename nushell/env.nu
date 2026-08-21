# Create vendor file.
#
# File is **not** created in an 'autoload' directory
# and must be explicitely loaded in 'configu.nu' with 'use' or 'source'.
def make-vendor [apps: list<string>, activate: closure, filename: string] {
    let filepath = $"($nu.data-dir)" | path join "vendor" $filename
    if ($apps | any { which $in | is-empty }) { return }
    if ($filepath | path exists) { return }
    mkdir ($filepath | path dirname)
    do $activate | save -f $filepath
    print $"Created '($filepath)'"
}

make-vendor [mise] { ^mise activate nu } "mise.nu"
(make-vendor
    [mise, usage]
    { ^mise usage | ^usage g completion nu mise -f - }
    "completion-mise.nu"
)
make-vendor [starship] { ^starship init nu } "starship.nu"
make-vendor [just] { ^just --completions nushell } "completion-just.nu"
make-vendor [uv] { ^uv generate-shell-completion nushell } "completion-uv.nu"

hide make-vendor
