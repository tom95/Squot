testing
testSimple
	| version1 version2 list |
	version1 := self newVersion: '1' withParents: #().
	version2 := self newVersion: '2' withParents: {version1}.
	"when"
	list := walker startingFrom: version2.
	"then"
	self assert: (list includesAllOf: {version1. version2})