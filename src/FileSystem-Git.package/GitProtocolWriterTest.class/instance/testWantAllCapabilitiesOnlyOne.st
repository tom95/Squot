tests
testWantAllCapabilitiesOnlyOne
	| gitSignatures capabilities |
	
	gitSignatures := Array with: '003ac70f1e4ab9f7226e908d27b7ed24651527589a6a'.
	capabilities := GitProtocolCapabilities multiAck thinPack sideBand.
	
	self
		withWriterAssert: [ :writer | writer writeWantAll: gitSignatures capabilities: capabilities shallowLines: nil depth: nil]
		equals: '0054want 003ac70f1e4ab9f7226e908d27b7ed24651527589a6a thin-pack side-band multi_ack', String lf