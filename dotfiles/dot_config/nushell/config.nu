$env.config = {
  show_banner: false,
  shell_integration: {
    osc133: false
  }
  history: {
    max_size: 20
  }
  edit_mode: vi
}

alias npen = open
alias open = ^open

alias ll = ls -l
alias v = nvim
alias g = lazygit
alias scalanew3 = sbt new scala/scala3.g8
alias chap = chezmoi apply
alias chad = chezmoi add
alias chra = chezmoi re-add
alias chst = chezmoi status
alias chdf = chezmoi diff
alias chcd = chezmoi cd

def killjps [] { jps | detect columns --no-headers | where column1 != Jps | get column0 |into int | each { |it| kill -f $it } }

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (npen $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

use ~/.cache/starship/init.nu
source ~/.cache/carapace/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/atuin/init.nu

def "from env" []: string -> record {
  lines
    | split column '#' # remove comments
    | get column1
    | parse "{key}={value}"
    | str replace "export" "" key
    | str trim value -c '"' # unquote values
    | str trim value -c "'" # unquote values
    | str trim value -r -c ";"
    | str trim key
    | str trim value
    | transpose -r -d
}

