actions
actionBranchRemoveUpstream
	| localHistorian remoteBranchName remoteName |
	self branchSelection ifNil: [^ self].
	localHistorian := self branchSelection historian.
	remoteName := localHistorian upstreamRemoteName.
	remoteBranchName := localHistorian upstreamHistorianName.
	(self isUpstreamRemoteSupported: localHistorian)
		ifFalse: [^ self inform: 'The remote is unsupported, therefore the upstream branch cannot be removed from the remote.'].
	(UIManager confirm: 'Really delete branch ', remoteBranchName, ' at the remote ', remoteName, '?')
		ifFalse: [^ self].
	self handlingCredentialsOf: localHistorian
		do: [self projectSelection repository
			removeRemoteRef: remoteBranchName from: remoteName]
		ifCanceled: [^ self].
	self refresh.