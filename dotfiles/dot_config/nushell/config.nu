$env.config = {
  show_banner: false,
  edit_mode: vi
  cursor_shape: {
    vi_normal: block
    vi_insert: line
  }
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  table: {
    mode: rounded
    padding: { left: 1, right: 1 }
  }
  completions: {
    use_ls_colors: true
  #   algorithm: "fuzzy",
  }
  explore: {
    status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" },
    command_bar_text: { fg: "#C4C9C6" },
    highlight: { fg: "black", bg: "yellow" },
    status: {
      error: { fg: "white", bg: "red" },
      warn: {}
      info: {}
    },
    selected_cell: { bg: light_blue },
  }
  use_ansi_coloring: true
  shell_integration: {
    osc133: false
  }
  history: {
    max_size: 20
  }
  keybindings: [
     {
      name: delete_one_word_backward
      modifier: alt
      keycode: backspace
      mode: [emacs, vi_normal, vi_insert]
      event: {edit: backspaceword}
    }
    {
      name: change_dir_with_fzf
      modifier: CONTROL
      keycode: Char_t
      mode: [emacs, vi_normal, vi_insert]
      event:[
        { edit: Clear }
        { edit: InsertString,
          value: 'cd (ls **/* | where type == dir | each { |row| $row.name} | str join (char nl) | fzf --height 40% --layout=reverse --prompt="Select dir to cd: " | decode utf-8 | str trim)'
        }
        { send: Enter }
      ]
    }
    {
      name: open_file_in_nvim
      modifier: CONTROL
      keycode: Char_f
      mode: [emacs, vi_normal, vi_insert]
      event:[
        { edit: Clear }
        { edit: InsertString,
          value: 'nvim (ls **/* | where type == file | each { |row| $row.name} | str join (char nl) | fzf --height 40% --layout=reverse --prompt="Select file to edit: " | decode utf-8 | str trim)'
        }
        { send: Enter }
      ]
    }
  ]
}
$env.PROMPT_INDICATOR_VI_INSERT = "󰰃  "
$env.PROMPT_INDICATOR_VI_NORMAL = "󰰒  "
# $env.LS_COLORS = "di=0;35:"

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

def mvim [...args] = { with-env { NVIM_APPNAME: "mvim" } { nvim ...$args } }
def ovim [...args] = { with-env { NVIM_APPNAME: "ovim" } { nvim ...$args } }
def svim [...args] = { with-env { NVIM_APPNAME: "svim" } { nvim ...$args } }
def lvim [...args] = { with-env { NVIM_APPNAME: "lvim" } { nvim ...$args } }

def killjps [] { jps | detect columns --no-headers | where column1 != Jps | get column0 |into int | each { |it| kill -f $it } }
def killps [] { ps | input list --fuzzy | get pid | kill -f $in }

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

source catppuccin-mocha.nu

$env.config = {
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
#      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
#        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
#      }
    }]
  }
}



