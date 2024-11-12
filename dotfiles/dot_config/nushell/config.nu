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

use ~/.cache/starship/init.nu
source ~/.cache/carapace/init.nu
source ~/.cache/zoxide/init.nu
source ~/.cache/atuin/init.nu
