<?xml version="1.0"?>

<st-source>
<!-- Changes in change set FastDictionaryAccumulation -->
<time-stamp>From VisualWorks®, 7.4.1 of May 30, 2006 on December 1, 2006 at 12:47:57 pm</time-stamp>


<methods>
<class-id>Core.Dictionary</class-id> <category>accessing</category>

<body package="Collections-Unordered" selector="at:putValueOf:ifAbsentPutValueOf:">at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."

	| index element anObject |
	key == nil ifTrue:
		[^self
			subscriptBoundsErrorFor: #at:putValueOf:ifAbsentPutValueOf:
			index: key
			value: absentBlock value].
	index := self findKeyOrNil: key.
	element := self basicAt: index.
	element == nil
		ifTrue: [self atNewIndex: index put: (self createKey: key value: (anObject := absentBlock value))]
		ifFalse: [element value: (anObject := putBlock value: element value)].
	^anObject</body>
</methods>


<methods>
<class-id>Core.IdentityDictionary</class-id> <category>accessing</category>

<body package="Collections-Unordered" selector="at:putValueOf:ifAbsentPutValueOf:">at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."

	| index anObject |
	key == nil ifTrue:
		[^self
			subscriptBoundsErrorFor: #at:putValueOf:ifAbsentPutValueOf:
			index: key
			value: absentBlock value].
	index := self findKeyOrNil: key.
	(self basicAt: index) == nil
		ifTrue:
			["Evaluate absentBlock first in case it does a non-local return"
			anObject := valueArray at: index put: absentBlock value.
			tally := tally + 1.
			self basicAt: index put: key.
			self fullCheck]
		ifFalse: [anObject := valueArray at: index put: (putBlock value: (valueArray at: index))].
	^anObject</body>
</methods>


<methods>
<class-id>Core.Bag</class-id> <category>testing</category>

<body package="Collections-Unordered" selector="occurrencesOf:">occurrencesOf: anObject 
	"Answer how many of the receiver's elements are equal to anObject."

	^contents at: anObject ifAbsent: [0]</body>
</methods>

<methods>
<class-id>Core.Bag</class-id> <category>adding</category>

<body package="Collections-Unordered" selector="add:withOccurrences:">add: newObject withOccurrences: anInteger 
	"Add the element newObject to the elements of the receiver.  Do so as
	though the element were added anInteger number of times.  Answer newObject."

	contents at: newObject putValueOf: [:count| count + 1] ifAbsentPutValueOf: 1.
	^newObject</body>
</methods>

<methods>
<class-id>Core.Bag</class-id> <category>removing</category>

<body package="Collections-Unordered" selector="remove:ifAbsent:">remove: oldObject ifAbsent: exceptionBlock  
	"Remove oldObject as one of the receiver's elements.  If several of the
	elements are equal to oldObject, only one is removed. If no element is equal to
	oldObject, answer the result of evaluating anExceptionBlock.  Otherwise,
	answer the argument, oldObject."

	(contents
		at: oldObject
		putValueOf: [:count| count - 1]
		ifAbsentPutValueOf: [^exceptionBlock value]) = 0
			ifTrue:
				[contents removeKey: oldObject].
	^oldObject</body>
</methods>


<methods>
<class-id>Core.EphemeronDictionary</class-id> <category>accessing</category>

<body package="Collections-Unordered" selector="at:putValueOf:ifAbsentPutValueOf:">at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."

	^self evaluateWithFullProtection: [super at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock]</body>
</methods>


<methods>
<class-id>Core.WeakDictionary</class-id> <category>accessing</category>

<body package="Collections-Unordered" selector="at:putValueOf:ifAbsentPutValueOf:">at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."
 
	^accessLock critical:
		[self unlockedAt: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock]</body>
</methods>

<methods>
<class-id>Core.WeakDictionary</class-id> <category>private</category>

<body package="Collections-Unordered" selector="unlockedAt:putValueOf:ifAbsentPutValueOf:">unlockedAt:  key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."
 
	^super at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock</body>
</methods>


<methods>
<class-id>External.WeakAssociationDictionary</class-id> <category>accessing</category>

<body package="External-Collections" selector="at:putValueOf:ifAbsentPutValueOf:">at: key putValueOf: putBlock ifAbsentPutValueOf: absentBlock
	"Set the value at key to be the value of evaluating putBlock with the existing value.
	 If key is not found, create a new entry for key and set is value to the evaluation of
	 absentBlock. Answer the result of evaluating either block."

	key == nil ifTrue:
		[^self
			subscriptBoundsErrorFor: #at:putValueOf:ifAbsentPutValueOf:
			index: key
			value: absentBlock value].

	^accessLock critical:
		[| index assoc |
		index := self findKeyOrNil: key.
		(self basicAt: index) == nil
			ifTrue:
				["Evaluate absentBlock first in case it does a non-local return"
				assoc := valueArray at: index put: (self createKey: key value: absentBlock value).
				tally := tally + 1.
				self basicAt: index put: key.
				self fullCheck]
			ifFalse: [assoc := valueArray at: index.
					assoc value: (putBlock value: assoc value)].
		executors at: index put: assoc.
		self fullCheck.
		assoc value]</body>
</methods>



</st-source>
