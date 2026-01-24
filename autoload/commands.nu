use std/dirs

def v [ file?: path, ...args ] {
  match $file {
    null => { nvim ...(fzf -m | split row "\n") }
    _ => { nvim $file }
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
