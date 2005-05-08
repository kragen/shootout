"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im objinst.st -a 1000000 
"

Object subclass: #Toggle
instanceVariableNames: 'state'
classVariableNames: ''
poolDictionaries: ''
category: nil !

!Toggle class methodsFor: 'instance creation'!

new: aBoolean
   ^self basicNew initialize: aBoolean ! !
   
!Toggle methodsFor: 'private'!

initialize: aBoolean
   state := aBoolean ! !
   
!Toggle methodsFor: 'accessing'!

activate
   state := state not !
   
state
   ^state ! !
   
   
Toggle subclass: #NToggle
instanceVariableNames: 'trigger count'
classVariableNames: ''
poolDictionaries: ''
category: nil !

!NToggle class methodsFor: 'instance creation'!

new: aBoolean withTrigger: anInteger
   ^(super new: aBoolean) withTrigger: anInteger ! !
   
!NToggle methodsFor: 'private'!

withTrigger: anInteger
   trigger := anInteger.
   count := 0 ! !
   
!NToggle methodsFor: 'accessing'!

activate
   "Toggle and answer the receiver"
   (count := count + 1) >= trigger ifTrue: [
      state := state not. 
      count := 0
   ] ! !
   
| n toggle ntoggle |
n := Smalltalk arguments first asInteger.

toggle := Toggle new: true.
5 timesRepeat: [toggle activate state displayNl].
n timesRepeat: [toggle := Toggle new: true].
Transcript nl.

ntoggle := NToggle new: true withTrigger: 3.
8 timesRepeat: [ntoggle activate state displayNl]. 
n timesRepeat: [ntoggle := NToggle new: true withTrigger: 3] ! 
