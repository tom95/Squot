ui
branchSelection
	self branchIndex > 1 ifFalse: [^ nil].
	^ self branchList at: self branchIndex ifAbsent: [nil]