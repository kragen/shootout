"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q objinst.st -a 1000000
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
   "Toggle and answer the receiver"
   state := state not !

state
   "Answer a Boolean"
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
   count := count + 1.
   count >= trigger ifTrue: [
      state := state not. 
      count := 0
   ] ! !


| n toggle ntoggle |
n := (Smalltalk arguments at: 1) asInteger.

toggle := Toggle new: true.
5 timesRepeat: [toggle activate state displayNl].
n timesRepeat: [Toggle new: true].
Transcript cr.

ntoggle := NToggle new: true withTrigger: 3.
8 timesRepeat: [ntoggle activate state displayNl]. 
n timesRepeat: [NToggle new: true withTrigger: 3] !