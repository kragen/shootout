


Object subclass: #Tests   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!

!Tests class methodsFor: 'platform'!arg   ^CEnvironment commandLine last asNumber! !
!Tests class methodsFor: 'platform'!stdin   ^Stdin! !

!Tests class methodsFor: 'platform'!stdinSpecial   ^ExternalReadStream on:
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0))! !
!Tests class methodsFor: 'platform'!stdout   ^Stdout! !

!Tests class methodsFor: 'platform'!stdoutSpecial   ^ExternalWriteStream on:
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 1))! !

!LimitedPrecisionReal methodsFor: 'platform'!asStringWithDecimalPlaces: anInteger   ^(self asFixedPoint: anInteger) printString copyWithout: $s! !

!LimitedPrecisionReal methodsFor: 'platform'!printOn: aStream withName: aString   aStream  nextPutAll: (self asStringWithDecimalPlaces: 9);      nextPut: Character tab; nextPutAll: aString; nextPut: Character lf.! !

!Integer methodsFor: 'platform'!asPaddedString: aWidth   | s |
   s := WriteStream on: (String new: 10).
   self printOn: s paddedWith: $  to: aWidth base: 10.
   ^s contents ! !

!Integer methodsFor: 'platform'!asFloatD   ^self Double! !
