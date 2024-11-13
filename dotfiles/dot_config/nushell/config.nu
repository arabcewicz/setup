$env.config = {
  show_banner: false,
  shell_integration: {
    osc133: false
  }
  history: {
    max_size: 0
  }
  edit_mode: vi
}

alias ll = ls -l
alias v = nvim
alias scalanew3 = sbt new scala/scala3.g8
alias chap = chezmoi apply
alias chra = chezmoi re-add

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

use ~/.cache/starship/init.nu
source ~/.cache/carapace/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/atuin/init.nu
