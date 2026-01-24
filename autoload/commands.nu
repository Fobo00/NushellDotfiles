use std/dirs

def --wrapped v [ file?: path, ...args ] {
  match $file {
    null => { nvim ...(fzf -m | split row "\n") ...$args }
    _ => { nvim $file ...$args }
  }
}

def fd [] {
	do -i {ls -a **/*} |
		where type == dir |
		get name |
		to text |
		fzf |
		cd $in
}

use ../psub.nu
