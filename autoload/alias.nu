def --wrapped ll [...rest] {
	# ls -la | explore
	ls -la |
	if (
		$in |
		all {|l| $l.target == null}
	) { reject target } else $in |
    if (
		$in |
		all {|l| $l.readonly == false}
	) { reject readonly } else $in |
	explore
}
alias la = ls -a

alias sshhome = ssh fobo@192.168.1.183
