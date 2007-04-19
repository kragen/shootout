


Object subclass: #Tests   instanceVariableNames: ''   classVariableNames: ''   poolDictionaries: ''   category: 'Shootout'!


!Tests class methodsFor: 'platform'!arg   ^CEnvironment commandLine last asNumber! !

!Tests class methodsFor: 'platform'!stdin   ^Stdin! !


!Tests class methodsFor: 'platform'!stdinSpecial   ^ExternalReadStream on:
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 0))! !

!Tests class methodsFor: 'platform'!stdout   ^Stdout! !


!Tests class methodsFor: 'platform'!stdoutSpecial   ^ExternalWriteStream on:
      (ExternalConnection ioAccessor: (UnixDiskFileAccessor new handle: 1))! !


!Stream methodsFor: 'platform'!nl   self nextPut: Character lf! !


!Stream methodsFor: 'platform'!print: number digits: decimalPlaces   self nextPutAll: 
      ((number asFixedPoint: decimalPlaces) printString copyWithout: $s)! !


!Stream methodsFor: 'platform'!print: number paddedTo: width   number printOn: self paddedWith: $  to: width base: 10! !


!Integer methodsFor: 'platform'!asFloatD   ^self asDouble! !

