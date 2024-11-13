$env.EDITOR = "nvim"

 $env.PATH = (
  match $nu.os-info.name {
    "macos" => {
      $env.PATH
      | split row (char esep)
      # | append ($env.CARGO_HOME | path join bin)
      | prepend ('/opt/homebrew/bin')
# >>> coursier install directory >>>
      | prepend ($env.HOME | path join 'Library/Application Support/Coursier/bin')
      | prepend ($env.HOME | path join 'evolution/dex-login')
# <<< coursier install directory <<<
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

$env.JAVA_HOME = (
  match $nu.os-info.name {
    "macos" =>  ($env.HOME | path join "Library/Caches/Coursier/arc/https/github.com/adoptium/temurin21-binaries/releases/download/jdk-21%252B35/OpenJDK21U-jdk_aarch64_mac_hotspot_21_35.tar.gz/jdk-21+35/Contents/Home")
    "linux" => "todo"
    "windows" => ($env.HOME | path join "scoop/apps/graalvm-jdk17/current")
  }
)

$env.BAT_CONFIG_DIR = ($env.HOME | path join .config bat)
$env.BAT_THEME = "Catppuccin-Mocha"

$env.OS_ICON = (
  match $nu.os-info.name {
    "macos" => { "" }
    "linux" => { " " }
    "windows" => { "" }
  }
)

$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.cache/zoxide
zoxide init nushell | save -f ~/.cache/zoxide/init.nu


$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

mkdir ~/.cache/atuin/
atuin init nu | save -f ~/.cache/atuin/init.nu
