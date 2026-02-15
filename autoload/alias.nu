def --wrapped ll [...rest] {
	# ls -la | explore
	ls -la |
	if (
		$in |
		all {|l| $l.target == null}
	) { reject target } |
	if (
		$in |
		all {|l| $l.readonly == false}
	) { reject readonly } |
	explore
}
alias la = ls -a

alias sshhome = ssh fobo@192.168.1.182
