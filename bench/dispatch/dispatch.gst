"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im dispatch.gst -a 1000 
"

Object subclass: #BottleState
instanceVariableNames: 'tag'
classVariableNames: 'Empty Full Sealed'
poolDictionaries: ''
category: nil !


!BottleState class methodsFor: 'class initialization'!

initialize
   Empty := EmptyState new tag: 1.  
   Full := FullState new tag: 2.
   Sealed := SealedState new tag: 3 ! !
   
!BottleState class methodsFor: 'accessing'!

initialState
   ^Empty ! !   
   
!BottleState methodsFor: 'accessing'!      

tag
   ^tag !
   
tag: anInteger
   "only exists for checksum"
   tag := anInteger ! !

!BottleState methodsFor: 'controlling'!      

next: aBottle
   self subclassResponsibility ! !


BottleState subclass: #EmptyState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!EmptyState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: Full ! !  



BottleState subclass: #FullState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!FullState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: Sealed ! !



BottleState subclass: #SealedState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!SealedState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: Empty ! !
   


BottleState subclass: #PressurizedBottleState
instanceVariableNames: ''
classVariableNames: 'UnpressurizedEmpty UnpressurizedFull PressurizedUnsealed PressurizedSealed'
poolDictionaries: ''
category: nil !

!PressurizedBottleState class methodsFor: 'class initialization'!

initialize
   UnpressurizedEmpty := UnpressurizedEmptyState new tag: 4.   
   UnpressurizedFull := UnpressurizedFullState new tag: 5.
   PressurizedUnsealed := PressurizedUnsealedState new tag: 6.   
   PressurizedSealed := PressurizedSealedState new tag: 7 ! !

!PressurizedBottleState class methodsFor: 'accessing'!   

initialState
   ^UnpressurizedEmpty ! !



PressurizedBottleState subclass: #UnpressurizedEmptyState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!UnpressurizedEmptyState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: UnpressurizedFull ! !



PressurizedBottleState subclass: #UnpressurizedFullState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!UnpressurizedFullState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: PressurizedUnsealed ! !



PressurizedBottleState subclass: #PressurizedUnsealedState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!PressurizedUnsealedState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: PressurizedSealed ! !



PressurizedBottleState subclass: #PressurizedSealedState
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !

!PressurizedSealedState methodsFor: 'controlling'!      

next: aBottle
   aBottle state: UnpressurizedEmpty ! !



Object subclass: #Bottle
instanceVariableNames: 'state id'
classVariableNames: ''
poolDictionaries: ''
category: nil !

!Bottle class methodsFor: 'instance creation'!      

new: anInteger
   ^super new initialize: anInteger ! !
   
!Bottle class methodsFor: 'private'!    

initialState
   ^BottleState initialState! !   

!Bottle methodsFor: 'controlling'!      

empty
   state next: self !

fill
   state next: self !

seal
   state next: self !
   
cycle
   self fill; seal; empty ! !      
   
   
!Bottle methodsFor: 'accessing'!      

check: anInteger
   ^state tag + id + anInteger !

checkWith: aBottle2 with: aBottle3 with: aBottle4 with: aBottle5 with: anInteger
   | c |
   self cycle.
   aBottle2 cycle.
   aBottle3 cycle.
   aBottle4 cycle.
   aBottle5 cycle.

   c := anInteger rem: 2. 
   ^(self check: c) + (aBottle2 check: c) + (aBottle3 check: c) + 
      (aBottle4 check: c) + (aBottle5 check: c) !
   
state: aBottleState
   state := aBottleState ! !
   
!Bottle methodsFor: 'initialize-release'!              

initialize: anInteger
   state := self class initialState.
   id := anInteger ! !
   
   
   
Bottle subclass: #PressurizedBottle
instanceVariableNames: ''
classVariableNames: ''
poolDictionaries: ''
category: nil !   

!PressurizedBottle class methodsFor: 'private'!    

initialState
   ^PressurizedBottleState initialState! !
   
!PressurizedBottle methodsFor: 'controlling'!     

cycle
   self fill; pressurize; seal; empty ! 

pressurize
   state next: self ! !

                     
   
| n b1 b2 b3 b4 b5 b6 b7 b8 b9 b0 p1 p2 p3 p4 p5 p6 p7 p8 p9 p0 check |

BottleState initialize.
PressurizedBottleState initialize.

n := Smalltalk arguments first asInteger.

b1 := Bottle new: 1. b2 := Bottle new: 2. 
b3 := Bottle new: 3. b4 := Bottle new: 4.
b5 := Bottle new: 5. b6 := Bottle new: 6. 
b7 := Bottle new: 7. b8 := Bottle new: 8.
b9 := Bottle new: 9. b0 := Bottle new: 0.

p1 := PressurizedBottle new: 1. p2 := PressurizedBottle new: 2. 
p3 := PressurizedBottle new: 3. p4 := PressurizedBottle new: 4.
p5 := PressurizedBottle new: 5. p6 := PressurizedBottle new: 6. 
p7 := PressurizedBottle new: 7. p8 := PressurizedBottle new: 8.
p9 := PressurizedBottle new: 9. p0 := PressurizedBottle new: 0.

check := 0.
1 to: n do: [:i|
   check := check + (b1 checkWith: b2 with: b3 with: b4 with: b5 with: i).
   check := check + (b6 checkWith: b7 with: b8 with: b9 with: b0 with: i).  
   
   check := check + (p1 checkWith: p2 with: p3 with: p4 with: p5 with: i).   
   check := check - (p6 checkWith: p7 with: p8 with: p9 with: p0 with: i).         
].

check printString displayNl!

