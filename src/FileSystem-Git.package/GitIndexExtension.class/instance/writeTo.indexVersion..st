as yet unclassified
writeTo: aStream indexVersion: versionNumber
	aStream
		nextPutAll: signature;
		nextInt32Put: data size;
		nextPutAll: data.