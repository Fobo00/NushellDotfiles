def --wrapped ll [...rest] {
	# ls -la | explore
	ls -la |
	if (
		$in |
		all {|l| $el.target == null}
	) { reject target } |
	if (
		$in |
		all {|l| $el.readonly == false}
	) { reject readonly } |
	explore
}
alias la = ls -a

alias sshhome = ssh 192.168.1.182
