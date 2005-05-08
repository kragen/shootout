"  The Great Computer Language Shootout
   contributed by Paolo Bonzini
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im except.st -a 20000
"

Notification subclass: #MyException
   instanceVariableNames: ''
   classVariableNames: ''
   poolDictionaries: ''
   category: 'testing'!
   
MyException class instanceVariableNames: 'count'!


!MyException class methodsFor: 'counting'!

count
   ^count!
   
increment
   count := count + 1!
   
initialize
   count := 0! !
   
MyException subclass: #LoException
   instanceVariableNames: ''
   classVariableNames: ''
   poolDictionaries: ''
   category: 'testing'!
   
MyException subclass: #HiException
   instanceVariableNames: ''
   classVariableNames: ''
   poolDictionaries: ''
   category: 'testing'!
   
LoException initialize.
HiException initialize!


!SmallInteger methodsFor: 'testing'!

someFunction
   ^self hiFunction!
   
hiFunction
   ^[ self loFunction ] on: HiException do: [ :ex | ex class increment ]!
   
loFunction
   ^[ self blowup ] on: LoException do: [ :ex | ex class increment ]!
   
blowup
   ^(self odd ifTrue: [ HiException ] ifFalse: [ LoException ]) signal: self! !
   
| n |
n := Smalltalk arguments isEmpty
   ifTrue: [ 20000 ]
   ifFalse: [ 1 max: Smalltalk arguments first asInteger ].
   
1 to: n do: [ :each | each someFunction ].

('Exceptions: HI=%1 / LO=%2'
   bindWith: HiException count with: LoException count) displayNl !
   