# config.nu
#
# Installed by:
# version = "0.110.0"

source ~/.config/nushell/themes/catppuccin_mocha.nu

def --env ap-chaos [...rest] {
  cd ~/Applications/Archipelago-chaos
  ~/Applications/Archipelago-chaos/.venv/bin/python Launcher.py ...$rest
}

def --env ap-dev [...rest] {
  cd ~/Applications/Archipelago-dev
  ~/Applications/Archipelago-dev/.venv/bin/python Launcher.py ...$rest
}

def basalt [...rest] {
  if "BASALT_OPAQUE" in $env {
    ^basalt ...$rest
  } else {
    with-env { BASALT_OPAQUE: "1" } {
      ghostty --background-opacity=1 -e basalt ...$rest
    }
  }
}

def --env notes [note?: string] {
  cd ~/notes
  if (which git | is-not-empty) and (".git" | path exists) {
    try {
      git pull --rebase --quiet
    } catch {
      print "notes: pull failed, working offline"
    }
  }
  let target = if ($note | is-empty) {
    "_000 Home_.md"
  } else if ($note | str ends-with ".md") {
    $note
  } else {
    $"($note).md"
  }
  if not ($target | path exists) {
    print $"notes: ($target) does not exist"
    return
  }
  nvim $target
}
