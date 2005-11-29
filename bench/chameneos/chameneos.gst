"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Paolo Bonzini"

Object subclass: #Chameleon
	instanceVariableNames: 'meetings color semaphore waitingForPair'
	classVariableNames: ''
	poolDictionaries: ''
	category: ''!

Object subclass: #MeetingPlace
	instanceVariableNames: 'mutex first total max'
	classVariableNames: ''
	poolDictionaries: ''
	category: ''!

!Chameleon class methodsFor: 'initialize'!

color: c
    ^self new
	initialize;
	color: c! !

!Chameleon methodsFor: 'initialize'!

initialize
    meetings := 0.
    waitingForPair := Semaphore new.
    semaphore := Semaphore new! !

!Chameleon methodsFor: 'accessing'!

color
    ^color!

wait
    semaphore wait!

meetings
    ^meetings!

!Chameleon methodsFor: 'running'!

run: meetingPlace
    [ color == #faded ] whileFalse: [
	meetingPlace reachedBy: self.
	waitingForPair wait ]!

fork: meetingPlace
    ^[ self run: meetingPlace ] fork! !

!Chameleon methodsFor: 'changing colors'!

fade
    color := #faded.
    waitingForPair signal.
    semaphore signal!

color: c
    color := c!

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
    waitingForPair signal! !

!MeetingPlace class methodsFor: 'instance creation'!

forMeetings: maxMeetings
    ^super new
	initialize;
	max: maxMeetings;
	yourself!

!MeetingPlace methodsFor: 'instance creation'!

initialize
    mutex := Semaphore forMutualExclusion.
    total := 0!

!MeetingPlace methodsFor: 'running'!

max: maxMeetings
    max := maxMeetings!

reachedBy: chameleon
    mutex critical: [
	first isNil
	    ifTrue: [ first := chameleon ]
	    ifFalse: [ self organizeMeetingWith: chameleon. first := nil ] ]!
	
organizeMeetingWith: second
    total >= max
	ifTrue: [
	    first fade.
	    second fade ]
	ifFalse: [
	    first met: second color.
	    second met: first color ].
    total := total + 1! !

| c1 c2 c3 c4 mp |
c1 := Chameleon color: #blue.
c2 := Chameleon color: #red.
c3 := Chameleon color: #yellow.
c4 := Chameleon color: #blue.
mp := MeetingPlace forMeetings: Smalltalk arguments first asInteger.
c1 fork: mp.
c2 fork: mp.
c3 fork: mp.
c4 fork: mp.
c1 wait.
c2 wait.
c3 wait.
c4 wait.
(c1 meetings + c2 meetings + c3 meetings + c4 meetings) printNl!
