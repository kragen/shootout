


Object subclass: #Tests   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!Tests class methodsFor: 'platform'!arg   ^Smalltalk arguments first asInteger! !!Tests class methodsFor: 'platform'!stdin   ^FileStream stdin! !

!Tests class methodsFor: 'platform'!stdinSpecial   ^self stdin bufferSize: 4096! ! !Tests class methodsFor: 'platform'!stdout   ^Transcript! !

!Tests class methodsFor: 'platform'!stdoutSpecial
   ^self stdout bufferSize: 4096! ! 

!Float methodsFor: 'platform'!asStringWithDecimalPlaces: anInteger   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !

!Float methodsFor: 'platform'!printOn: aStream withName: aString   aStream  nextPutAll: (self asStringWithDecimalPlaces: 9);      nextPut: Character tab; nextPutAll: aString; nextPut: Character lf.! !

!SmallInteger methodsFor: 'platform'!asPaddedString: width
   | s |
   s := self printString.
   ^(String new: (width - s size) withAll: $ ), s ! !!SmallInteger methodsFor: 'platform'!asFloatD   ^self asFloat! !
