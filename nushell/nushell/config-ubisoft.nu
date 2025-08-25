use std/util "path add"

# Quickly cd to dev directory
module cdd {
    const dev = 'D:\dev' | path expand
    def completion [] { 
        ls -s $dev | where type != file | get name 
    }
    export def --env main [dir?: string@completion] {
        cd ($dev | path join $'($dir)')
    }
}
use cdd
