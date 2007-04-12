<?xml version="1.0"?>

<st-source>
<!-- Changes in change set Regex -->
<time-stamp>From VisualWorks®, 7.4.1 of May 30, 2006 on December 6, 2006 at 10:04:10 pm</time-stamp>


<methods>
<class-id>RxMatcher</class-id> <category>match enumeration</category>

<body package="Regex11" selector="matchesInStream:">matchesInStream: aStream
	"Answer the number of matches in aStream."

	| count |
	stream := aStream.
	count := 0.
	lastChar := nil.
	[self proceedSearchingStream: aStream] whileTrue:
		[count := count + 1].
	^count</body>
</methods>


<methods>
<class-id>Core.CharacterArray</class-id> <category>VB-regex</category>

<body package="Regex11" selector="occurrencesOfRegex:">occurrencesOfRegex: rxString

	^rxString asRegex matchesInStream: self readStream</body>
</methods>


<methods>
<class-id>RxsPredicate class</class-id> <category>instance creation</category>

<body package="Regex11" selector="forEscapedLetter:">forEscapedLetter: aCharacter

	| selector |
	selector := EscapedLetterSelectors
				at: aCharacter
				ifAbsent: [| esc |
						 esc := RxParser backslashConstants
									at: aCharacter
									ifAbsent: [RxParser signalSyntaxException: 'bad backslash escape'].
						^RxsCharacter with: esc].
	^self new perform: selector</body>
</methods>


<methods>
<class-id>RxParser class</class-id> <category>accessing</category>

<body package="Regex11" selector="backslashConstants">backslashConstants
	^BackslashConstants</body>
</methods>


<reorganize>
<class-id>RxParser class</class-id> <organization>('test suite' #compileRegex:into: #runProtocolTestsForMatcher: #runRegexTestsForMatcher: #runTestsForMatcher: #test:with:expect:withSubexpressions: #testSuite)
('utilities' #parse: #safelyParse:)
('Signal constants' #compilationErrorSignal #initializeExceptions #matchErrorSignal #regexErrorSignal #syntaxErrorSignal)
('DOCUMENTATION' #a:introduction: #b:whatsNewInThisRelease: #c:syntax: #d:usage: #e:implementationNotes: #f:boringStuff:)
('class initialization' #initialize #initializeBackslashConstants #initializeBackslashSpecials)
('profiling' #bigHonkingStream #frequentMatchProfile #rareMatchProfile #singleCharPrefixMatchProfile)
('preferences' #preferredMatcherClass)
('exception signaling' #doHandlingMessageNotUnderstood: #signalCompilationException: #signalMatchException: #signalSyntaxException:)
('accessing' #backslashConstants)
</organization>
</reorganize>


</st-source>
