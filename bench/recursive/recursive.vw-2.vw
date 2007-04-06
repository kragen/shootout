"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
   modified by Eliot Miranda *"!


Smalltalk.Shootout defineClass: #Tests
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: ''
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'benchmark scripts'!

recursive2
   self recursive: CEnvironment argv first asNumber to: Stdout.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

recursive: nArg to: output 
   | n |
   n := nArg.
   output
      nextPutAll: 'Ack(3,'; print: n; nextPutAll: '): '; 
      print: (3 ack: n); cr;
      nextPutAll: 'Fib(' , (27.0d + n asStringWith: 1) , '): ', 
         ((27.0d + n) fib asStringWith: 1); cr.
   n := n - 1.
   output
      nextPutAll: 'Tak('; print: 3 * n; nextPut: $,; print: 2 * n; 
      nextPut: $,; print: n; nextPutAll: '): '; 
      print: (3 * n tak: 2 * n z: n); cr;
      nextPutAll: 'Fib(3): '; print: 3 fib; cr;
      nextPutAll: 'Tak(3.0,2.0,1.0): ', 
         ((3.0d tak: 2.0d z: 1.0d) asStringWith: 1); cr ! !

!Core.SmallInteger methodsFor: 'computer language shootout'!

ack: aSmallInteger
   ^self == 0
      ifTrue: [aSmallInteger + 1]
      ifFalse: [
         aSmallInteger == 0
            ifTrue: [self - 1 ack:  1]
            ifFalse: [self - 1 ack: (self ack: aSmallInteger - 1)] ] ! 

fib
   ^self < 2 ifTrue: [1] ifFalse: [(self - 2) fib + (self - 1) fib] ! 

tak: y z: z
   ^y < self 
      ifTrue: [((self - 1) tak: y z: z) tak: 
         ((y - 1) tak: z z: self) z: ((z - 1) tak: self z: y)]
      ifFalse: [z] ! !


!Core.Double methodsFor: 'computer language shootout'!

fib
   ^self < 2.0d ifTrue: [1.0d] ifFalse: [(self - 2.0d) fib + (self - 1.0d) fib] !

tak: y z: z
   ^y < self 
      ifTrue: [((self - 1.0d) tak: y z: z) tak: 
         ((y - 1.0d) tak: z z: self) z: ((z - 1.0d) tak: self z: y)]
      ifFalse: [z] ! !


!Core.LimitedPrecisionReal methodsFor: 'converting'!

asStringWith: anInteger
   ^(self asFixedPoint: anInteger) printString copyWithout: $s ! !




