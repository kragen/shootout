"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im prodcons.st -a 100000 
"


!RecursionLock methodsFor: 'accessing'!

waitWhile: aBlock onLock: aSemaphore
    [aBlock value] whileTrue: [self waitOnLock: aSemaphore]!

waitOnLock: aSemaphore
    self exit.
    aSemaphore wait.
    self enter! !


| n mutex control produced consumed count producer data consumer |

n := (Smalltalk arguments at: 1) asInteger.

mutex := RecursionLock new.
control := Semaphore new.
count := 0.
produced := Promise new. 
consumed := Promise new. 

producer := [ | p | 
   p := 0.
   1 to: n do: [:i|
      mutex critical: [
         mutex waitWhile: [count = 1] onLock: control.
         data := i.
         count := 1.
         control signal.
      ].
      p := p + 1.
   ].
   produced value: p.
]. 

consumer := [ | i c |  
   c := 0.
   [
      mutex critical: [
         mutex waitWhile: [count = 0] onLock: control.
         i := data.
         count := 0.
         control signal.
      ].
      c := c + 1.
      i = n
   ] whileFalse.

   consumed value: c.
]. 

consumer fork.
producer fork.
produced value display. ' ' display. consumed value displayNl !
