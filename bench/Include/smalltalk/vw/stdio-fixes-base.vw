<?xml version="1.0"?>

<st-source>
<!-- Changes in change set stdio deficits -->
<time-stamp>From VisualWorks®, 7.4.1 of May 30, 2006 on December 7, 2006 at 4:20:46 pm</time-stamp>


<class>
<name>Stream</name>
<environment>Core</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports>
			private IOConstants.*
			</imports>
<category>Collections-Streams</category>
<attributes>
<package>Collections-Streams</package>
</attributes>
</class>

<class>
<name>StandardIOStream</name>
<environment>OS</environment>
<super>Core.Stream</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars>stream mutex </inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>Standard I/O Streams</category>
<attributes>
<package>Standard IO Streams</package>
</attributes>
</class>

<methods>
<class-id>Core.Stream</class-id> <category>stream modes</category>

<body package="Collections-Streams" selector="lineEndAuto">lineEndAuto

	self lineEndConvention: LineEndAuto</body>

<body package="Collections-Streams" selector="lineEndConvention:">lineEndConvention: aNumber 
	"Subclasses may implement this.  By default streams do not.  raise a suitable error."

	^self shouldNotImplement</body>

<body package="Collections-Streams" selector="lineEndCR">lineEndCR

	self lineEndConvention: LineEndCR</body>

<body package="Collections-Streams" selector="lineEndCRLF">lineEndCRLF

	self lineEndConvention: LineEndCRLF</body>

<body package="Collections-Streams" selector="lineEndLF">lineEndLF

	self lineEndConvention: LineEndLF</body>

<body package="Collections-Streams" selector="lineEndTransparent">lineEndTransparent

	self lineEndConvention: LineEndTransparent</body>
</methods>


<reorganize>
<class-id>Core.Stream</class-id> <organization>('accessing' #contents #flush #next #next: #next:into:startingAt: #next:put: #next:putAll:startingAt: #nextAvailable: #nextAvailable:into:startingAt: #nextMatchFor: #nextPut: #nextPutAll: #policy #skipThrough: #skipThroughAll: #through: #throughAll: #upTo: #upToAndSkipThroughAll: #upToEnd)
('testing' #atEnd #isExternalStream #isReadable #isWritable #needsFileLineEndConversion)
('enumerating' #do:)
('character writing' #cr #crtab #crtab: #emphasis #emphasis: #space #tab #tab:)
('status' #close #commit)
('fileOut' #nextChunkPut: #timeStamp)
('printing' #print: #store:)
('private' #computePrefixFunctionFor: #contentsSpecies #upToAll:returnMatch:includePattern:)
('connection accessing' #ioConnection)
('stream modes' #lineEndAuto #lineEndConvention: #lineEndCR #lineEndCRLF #lineEndLF #lineEndTransparent)
</organization>
</reorganize>


<methods>
<class-id>OS.StandardIOStream</class-id> <category>testing</category>

<body package="Standard IO Streams" selector="closed">closed
	"Answer if the receiver is closed."

	^mutex critical: [stream closed]</body>
</methods>

<methods>
<class-id>OS.StandardIOStream</class-id> <category>stream modes</category>

<body package="Standard IO Streams" selector="binary">binary
	stream binary</body>

<body package="Standard IO Streams" selector="isBinary">isBinary
	^stream isBinary</body>

<body package="Standard IO Streams" selector="isText">isText
	^stream isText</body>

<body package="Standard IO Streams" selector="lineEndConvention">lineEndConvention
	"Answer the numeric constant that corresponds to the current line-end 
	convention (see the line-end constants in the pool of IOConstants for the 
	range of possible values)."

	^stream lineEndConvention</body>

<body package="Standard IO Streams" selector="lineEndConvention:">lineEndConvention: aNumber 
	"Set the line-end convention to that corresponding to aNumber (aNumber should be
	one of the line-end constants from the pool of IOConstants)."


	stream lineEndConvention: aNumber </body>

<body package="Standard IO Streams" selector="text">text
	stream text</body>
</methods>

<methods>
<class-id>OS.StandardIOStream</class-id> <category>positioning</category>

<body package="Standard IO Streams" selector="padTo:">padTo: bsize
	"Pad (skip) to next boundary of bsize characters,
	 and answer how many characters were skipped."
	
	^mutex critical: [stream padTo: bsize]</body>

<body package="Standard IO Streams" selector="padTo:put:">padTo: bsize put: aCharacter
	"Pad using the argument, aCharacter, to next boundary of bsize
	 characters, and answer how many characters were written."
	
	^mutex critical: [stream padTo: bsize put: aCharacter]</body>

<body package="Standard IO Streams" selector="position">position
	"Answer the receiver's position."
	
	^mutex critical: [stream position]</body>

<body package="Standard IO Streams" selector="position:">position: anIndex
	"StandardIOStreams cannot be positioned directly."

	^self shouldNotImplement</body>

<body package="Standard IO Streams" selector="skip:">skip: n 
	"Reposition to the relative number n."

	mutex critical: [stream skip: n]</body>
</methods>

<methods>
<class-id>OS.StandardIOStream</class-id> <category>fileIn</category>

<body package="Standard IO Streams" selector="nextChunk">nextChunk
	"Answer the contents of the receiver, up to the next terminator character, with
	double terminators ignored."
	
	^mutex critical: [stream nextChunk]</body>
</methods>

<methods>
<class-id>OS.StandardIOStream</class-id> <category>accessing</category>

<body package="Standard IO Streams" selector="contents">contents
	"Answer with a copy of the receiver's readable information."

	^mutex critical: [stream contents]</body>

<body package="Standard IO Streams" selector="peekFor:">peekFor: anObject 
	"Answer false and do not move the position if self next ~= anObject or if the
	receiver is at the end. Answer true and increment position if self next = anObject."

	^mutex critical: [stream peekFor: anObject]</body>

<body package="Standard IO Streams" selector="skipToAll:">skipToAll: aCollection
	"Skip forward to the next occurrence (if any) of aCollection.
	If found, leave the stream positioned before the occurrence,
	and answer the receiver; if not found, answer nil,
	and leave the stream positioned at the end."
	
	^mutex critical: [stream skipToAll: aCollection]</body>

<body package="Standard IO Streams" selector="skipUpTo:">skipUpTo: anObject
	"Skip forward to the occurrence (if any, not inclusive) of anObject.
	 If not there, answer nil.  Leaves stream positioned before anObject."
	
	^mutex critical: [stream skipUpTo: anObject]</body>

<body package="Standard IO Streams" selector="upToAll:">upToAll: aCollection
	"Answer a subcollection from the current position
	up to the occurrence (if any, not inclusive) of aCollection,
	and leave the stream positioned before the occurrence.
	If no occurrence is found, answer the entire remaining
	stream contents, and leave the stream positioned at the end."

	^mutex critical: [stream upToAll: aCollection]</body>

<body package="Standard IO Streams" selector="upToSeparator">upToSeparator
	"Answer a subcollection from position to the occurrence (if any, exclusive) of a separator.
	The stream is left positioned after the separator.
	If no separator is found answer everything."

	^mutex critical: [stream upToSeparator].</body>
</methods>

<methods>
<class-id>OS.StandardIOStream</class-id> <category>character reading</category>

<body package="Standard IO Streams" selector="skipSeparators">skipSeparators
	"Move the receiver's position past any separators."
	
	^mutex critical: [stream skipSeparators]</body>
</methods>


<reorganize>
<class-id>OS.StandardIOStream</class-id> <organization>('testing' #atEnd #closed)
('initialize-release' #initialize #stream:)
('private' #flushStream)
('stream modes' #binary #isBinary #isText #lineEndConvention #lineEndConvention: #text)
('positioning' #padTo: #padTo:put: #position #position: #skip:)
('fileIn' #nextChunk)
('accessing' #commit #contents #cr #flush #lockWhile: #next #nextPut: #nextPutAll: #peek #peekFor: #skipToAll: #skipUpTo: #through: #upToAll: #upToSeparator)
('character reading' #skipSeparators)
</organization>
</reorganize>

<reorganize>
<class-id>OS.ExternalConnection</class-id> <organization>('accessing' #dataSize #input #input: #name #output #output:)
('iobuffer creation' #defaultIoBufferInMode: #ioBufferInMode:)
('status' #close #closeInput #closeOutput #invalidate #isActive #releaseHandles)
('testing' #canPersist)
('stream creation' #readAppendStream #readStream #withEncoding: #writeStream)
('stream modes' #lineEndConvention)
</organization>
</reorganize>


<remove-selector>
<class-id>OS.BufferedExternalStream</class-id> <selector>lineEndAuto</selector>
</remove-selector>

<remove-selector>
<class-id>OS.BufferedExternalStream</class-id> <selector>lineEndTransparent</selector>
</remove-selector>

<remove-selector>
<class-id>OS.BufferedExternalStream</class-id> <selector>lineEndLF</selector>
</remove-selector>

<remove-selector>
<class-id>OS.BufferedExternalStream</class-id> <selector>lineEndCR</selector>
</remove-selector>

<remove-selector>
<class-id>OS.BufferedExternalStream</class-id> <selector>lineEndCRLF</selector>
</remove-selector>

<reorganize>
<class-id>OS.BufferedExternalStream</class-id> <organization>('accessing' #commit #contents #contentsLineEndConvention #next:into:startingAt: #next:putAll:startingAt: #size)
('status' #close #closed #releaseHandles)
('positioning' #position #position: #readPosition #reset #setToEnd #writePosition)
('testing' #atEnd #atEndOfData)
('connection accessing' #fileName #ioConnection #logicalName #name)
('printing' #displayString #printOn:)
('private' #basicAtEnd #closeConnection #crlfNext:into:startingAt: #crlfNext:putAll:startingAt: #crlfSkip: #endTest #getIoBuffer #nextBuffer #on: #openIfClosed #pastEnd #removeDependency #reopen #setBinary: #setConnection: #setDependency #setLineEndCharacter #setPosition: #setupBufferAndLimits)
('stream modes' #binary #isBinary #isText #lineEndConvention #lineEndConvention: #text #textOfClass:)
</organization>
</reorganize>

<reorganize>
<class-id>OS.ExternalReadAppendStream</class-id> <organization>('accessing' #commit #flush #next:putAll:startingAt: #nextPut: #nextPutAll: #size)
('character/binary')
('status' #close #releaseHandles)
('testing' #isWritable)
('nonhomogeneous positioning' #padTo:put:)
('positioning' #position: #writePosition)
('fileOut' #nextChunkPut:)
('printing' #print: #store:)
('private' #on:)
('stream modes' #binary #lineEndConvention: #text #textOfClass:)
</organization>
</reorganize>

<remove-selector>
<class-id>Core.EncodedStream</class-id> <selector>lineEndAuto</selector>
</remove-selector>

<remove-selector>
<class-id>Core.EncodedStream</class-id> <selector>lineEndTransparent</selector>
</remove-selector>

<remove-selector>
<class-id>Core.EncodedStream</class-id> <selector>lineEndLF</selector>
</remove-selector>

<remove-selector>
<class-id>Core.EncodedStream</class-id> <selector>lineEndCR</selector>
</remove-selector>

<remove-selector>
<class-id>Core.EncodedStream</class-id> <selector>lineEndCRLF</selector>
</remove-selector>

<reorganize>
<class-id>Core.EncodedStream</class-id> <organization>('initialize' #on:encodedBy:)
('character/binary')
('positioning' #position #position: #readPosition #reset #setToEnd #withPosition:do: #writePosition)
('accessing' #commit #contents #encodedContents #encoder #encoder: #encoding #flush #next #nextPut: #peek #peekFor: #policy #policy: #size #skip: #skipToAll: #stream #stream: #throughAll: #upToAll:)
('status' #close #closed)
('testing' #atEnd #isEmpty #isExternalStream #isReadable #isWritable #notEmpty)
('connection accessing' #fileName #ioConnection #logicalName #name)
('printing' #displayString #printOn:)
('nonhomogeneous positioning' #padTo: #padTo:put:)
('private' #contentsSpecies #setBinary: #setLineEndCharacter)
('stream modes' #binary #isBinary #isText #lineEndConvention #lineEndConvention: #text)
</organization>
</reorganize>


</st-source>
