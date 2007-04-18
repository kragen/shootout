"* The Computer Language Shootout
    http://shootout.alioth.debian.org/
    contributed by Paolo Bonzini
    modified by Eliot Miranda *"!

Object subclass: #Chameleon
   instanceVariableNames: 'meetings color semaphore waitingForPair'
   classVariableNames: ''
   poolDictionaries: ''
   category: 'Shootout'!

Object subclass: #MeetingPlace
   instanceVariableNames: 'mutex first total max'
   classVariableNames: ''
   poolDictionaries: ''
   category: 'Shootout'!

!Chameleon methodsFor: 'initialize-release'!
initialize
    meetings := 0.
    waitingForPair := Semaphore new.
    semaphore := Semaphore new! !

!Chameleon methodsFor: 'changing colours'!
color: c
    color := c! !

!Chameleon methodsFor: 'changing colours'!
fade
    color := #faded.
    waitingForPair signal.
    semaphore signal! !

!Chameleon methodsFor: 'changing colours'!
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

!Chameleon methodsFor: 'running'!
fork: meetingPlace
    ^[ self run: meetingPlace ] fork! !

!Chameleon methodsFor: 'running'!
run: meetingPlace
    [ color == #faded ] whileFalse: [
        meetingPlace reachedBy: self.
        waitingForPair wait ]! !

!Chameleon methodsFor: 'accessing'!
color
    ^color! !

!Chameleon methodsFor: 'accessing'!
meetings
    ^meetings! !

!Chameleon methodsFor: 'accessing'!
wait
    semaphore wait! !

!Chameleon class methodsFor: 'instance creation'!
color: c
    ^self new
        initialize;
        color: c! !

!MeetingPlace methodsFor: 'running'!
max: maxMeetings
    max := maxMeetings! !

!MeetingPlace methodsFor: 'running'!
organizeMeetingWith: second
    total >= max
        ifTrue: [
            first fade.
            second fade ]
        ifFalse: [
            first met: second color.
            second met: first color ].
    total := total + 1! !

!MeetingPlace methodsFor: 'running'!
reachedBy: chameleon
    mutex critical: [
        first isNil
            ifTrue: [ first := chameleon ]
            ifFalse: [ self organizeMeetingWith: chameleon. first := nil ] ]! !

!MeetingPlace methodsFor: 'initialize-release'!
initialize
    mutex := Semaphore forMutualExclusion.
    total := 0! !

!MeetingPlace class methodsFor: 'instance creation'!
forMeetings: maxMeetings
    ^super new
        initialize;
        max: maxMeetings;
        yourself! !

!Tests class methodsFor: 'benchmarking'!
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
    ^c1 meetings + c2 meetings + c3 meetings + c4 meetings! !

!Tests class methodsFor: 'benchmark scripts'!
chameneos
    self stdout print: (self chameneos: self arg); nl.
    ^''! !

Tests chameneos!
