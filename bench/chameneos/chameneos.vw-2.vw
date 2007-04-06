"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini
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

chameneos2
	^(self chameneos: CEnvironment argv first asNumber) printString withNl ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

chameneos: n
   | c1 c2 c3 c4 mp |
   c1 := Chameleon color: #blue.
   c2 := Chameleon color: #red.
   c3 := Chameleon color: #yellow.
   c4 := Chameleon color: #blue.
   mp := MeetingPlace forMeetings: n.
   c1 fork: mp.
   c2 fork: mp.
   c3 fork: mp.
   c4 fork: mp.
   c1 wait.
   c2 wait.
   c3 wait.
   c4 wait.
   ^c1 meetings + c2 meetings + c3 meetings + c4 meetings ! !



Smalltalk.Shootout defineClass: #Chameleon
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'meetings color semaphore waitingForPair '
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!


!Shootout.Chameleon class methodsFor: 'initialize-release'!

color: c
    ^self new
	initialize;
	color: c ! !


!Shootout.Chameleon methodsFor: 'initialize-release'!

initialize
    meetings := 0.
    waitingForPair := Semaphore new.
    semaphore := Semaphore new ! !

!Shootout.Chameleon methodsFor: 'accessing'!

color
    ^color !

meetings
    ^meetings !

wait
    semaphore wait ! !

!Shootout.Chameleon methodsFor: 'running'!

fork: meetingPlace
    ^[ self run: meetingPlace ] fork !

run: meetingPlace
    [ color == #faded ] whileFalse: [
	meetingPlace reachedBy: self.
	waitingForPair wait ] ! !

!Shootout.Chameleon methodsFor: 'changing colors'!

color: c
    color := c !

fade
    color := #faded.
    waitingForPair signal.
    semaphore signal !

met: other
    | newColor |
    meetings := meetings + 1.
    color == #red ifTrue: [
	newColor := other == #yellow ifTrue: [ #blue ] ifFalse: [ #yellow ] ].
    color == #yellow ifTrue: [
	newColor := other == #red ifTrue: [ #blue ] ifFalse: [ #red ] ].
    color == #blue ifTrue: [
	newColor := other == #red ifTrue: [ #yellow ] ifFalse: [ #red ] ].
    color := newColor.
    waitingForPair signal ! !


Smalltalk.Shootout defineClass: #MeetingPlace
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'mutex first total max '
	classInstanceVariableNames: ''
	imports: ''
	category: 'Shootout'!


!Shootout.MeetingPlace class methodsFor: 'instance creation'!

forMeetings: maxMeetings
    ^super new
	initialize;
	max: maxMeetings;
	yourself ! !


!Shootout.MeetingPlace methodsFor: 'initialize-release'!

initialize
    mutex := Semaphore forMutualExclusion.
    total := 0 ! !

!Shootout.MeetingPlace methodsFor: 'running'!

max: maxMeetings
    max := maxMeetings !

organizeMeetingWith: second
    total >= max
	ifTrue: [
	    first fade.
	    second fade ]
	ifFalse: [
	    first met: second color.
	    second met: first color ].
    total := total + 1 !

reachedBy: chameleon
    mutex critical: [
	first isNil
	    ifTrue: [ first := chameleon ]
	    ifFalse: [ self organizeMeetingWith: chameleon. first := nil ] ] ! !

