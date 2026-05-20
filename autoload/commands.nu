use std/dirs

def --wrapped v [ file?: path, ...args ] {
  match $file {
    null => { nvim ...(fzf -m | split row "\n") ...$args }
    _ => { nvim $file ...$args }
  }
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	^yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != $env.PWD and ($cwd | path exists) {
		^cd $cwd
	}
	rm -fp $tmp
}
