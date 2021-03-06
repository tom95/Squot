ui
diffRoots
	| original proposed |
	diffRootNodes ifNotNil: [^ diffRootNodes].
	diffRootNodes := OrderedCollection new.
	diffs := Dictionary new.
	original := originalSnapshot artifacts.
	proposed := proposedSnapshot artifacts.
	'Diffing snapshots' displaySequentialProgress:
	[| progress progressStep | progress := 0.
	progressStep := 1 / (1 max: original size + proposed size).
	original keysAndValuesDo: [:path :originalArtifact |
		proposed at: path
			ifPresent: [:proposedArtifact | | diff |
				diff := originalArtifact diffAgainst: proposedArtifact.
				diffs at: path put: diff.
				diff topNodes ifNotEmpty: [:nodes |
					diffRootNodes add:
						(SquotDiffNode title: path content: nil children: nodes)]]
			ifAbsent: [ | diff |
				diff := originalArtifact diffAgainst: (SquotAbsentArtifact newFrom: originalArtifact).
				diffs at: path put: diff.
				diff topNodes ifNotEmpty: [:nodes |
					diffRootNodes add:
						(SquotDiffNode title: path content: nil children: nodes)]].
		ProgressNotification signal: (progress := progress + progressStep) extra: nil].
	(proposed keys reject: [:each | original includesKey: each]) do: [:path | | proposedArtifact diff |
		proposedArtifact := proposed at: path.
		diff := proposedArtifact absentCopy diffAgainst: proposedArtifact.
		diffs at: path put: diff.
		diff topNodes ifNotEmpty: [:nodes |
			diffRootNodes add:
				(SquotDiffNode title: path content: nil children: nodes)].
		ProgressNotification signal: (progress := progress + progressStep) extra: nil]].
	^ diffRootNodes