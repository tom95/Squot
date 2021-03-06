private
lookupTreeAt: aPath
	aPath withParents reverseDo: [:each |
		(treeMap includesKey: each)
			ifTrue: [(self lookupTreeAt: (aPath relativeTo: each)
					startingFrom: (treeMap at: each))
						ifNil: [^ nil]
						ifNotNil: [:tree | ^ tree]]].
	^ nil