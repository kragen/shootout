"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im process.st -a 10
"


Object subclass: #LinkedProcess
instanceVariableNames: 'message next sum'
classVariableNames: ''
poolDictionaries: ''
category: nil !

!LinkedProcess class methodsFor: 'instance creation'!

with: aLinkedProcess
   ^self new initializeWith: aLinkedProcess ! !
   
   
!LinkedProcess methodsFor: 'initialize-release'!   
   
initializeWith: aLinkedProcess
   next := aLinkedProcess.
   message := SharedQueue new.
   sum := 0 ! !
   
!LinkedProcess methodsFor: 'accessing'!        

put: aValue
   message nextPut: aValue !

take
   ^message next + 1 !

sum
   ^sum ! !
   
!LinkedProcess methodsFor: 'run'!    

runUntil: anInteger then: aSemaphore
   [ 
      next==nil "the last process checks if we're finished"
         ifTrue: [
            sum := sum + self take.
            (sum < anInteger) ifFalse: [aSemaphore signal] ] 

         ifFalse: [
            next put: self take]. 

      Processor yield "give other processes a chance to run"
   ] repeat ! !


| n join last p |
n := Smalltalk arguments first asInteger.
join := Semaphore new.

n timesRepeat: [
   p := LinkedProcess with: p.
   last isNil ifTrue: [last := p].
   [p runUntil: n then: join] fork.
].
p put: 0.

join wait.
last sum displayNl!
