# config.nu
#
# Installed by:
# version = "0.104.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# editor for `config nu`
$env.config.buffer_editor = "nvim"

# def ll [] { ls -la | select name type size modified mode target | sort-by type name -i }
def ll [] { ls -la | select mode user size modified name target }

# setup default vendor directory
mkdir ($nu.data-dir | path join "vendor/autoload")

# setup starship prompt
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# quickly cd to dev directory
module cdd {
    def get_dev_dir [] {
        let isubi =  ((sys host).hostname | str downcase) == "ann-wks-100027"
        if $isubi { 'D:\dev' } else { '~/dev' } | path expand
    }
	def completion [] {
        let dev = get_dev_dir
        ls -s $dev | where type != file | get name
    }
	export def --env main [dir?: string@completion] {
        cd (get_dev_dir | path join $'($dir)')
    }
}
use cdd
