use std/util "path add"

# cd to dev directories
module cdd {
    const dev = 'D:\dev'
    def completion [] {
        ls -s $dev | where type != file | get name
    }
    export def --env main [dir?: string@completion] {
        cd ($dev | path join $'($dir)')
    }
}
use cdd

alias cat = open -r
