$env.EDITOR = "nvim"

 $env.PATH = (
  match $nu.os-info.name {
    "macos" => {
      $env.PATH
      | split row (char esep)
      # | append ($env.CARGO_HOME | path join bin)
      | prepend ('/opt/homebrew/bin')
      | prepend ($env.HOME | path join bin)
      | uniq
      }
    "linux" => {
      $env.PATH
      | split row (char esep)
      # | append ($env.CARGO_HOME | path join bin)
      | prepend ($env.HOME | path join bin)
      | uniq
      }
    "windows" => {
      $env.PATH
      | split row (char esep)
      # | append ($env.CARGO_HOME | path join bin)
      | prepend ($env.HOME | path join bin)
      | uniq
    }
  }
)

 $env.OS_ICON = (
  match $nu.os-info.name {
    "macos" => { "" }
    "linux" => { " " }
    "windows" => { "" }
  }
)


mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/zoxide
zoxide init nushell | save -f ~/.cache/zoxide/init.nu


$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/atuin/
atuin init nu | save -f ~/.cache/atuin/init.nu
