"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Carlo Teixeira *"!

Smalltalk defineClass: #ChameneosColour
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'color '
   classInstanceVariableNames: 'red yellow blue '
   imports: ''
   category: 'chameleon'!


!ChameneosColour class methodsFor: 'as yet unclassified'!

createBlue
   ^(super new) color: #blue.!

createRed
   ^(super new) color: #red.!

createYellow
   ^(super new) color: #yellow.!

generateReportOfColours
   | readOut colours |
   colours:=Array with: blue with: red with: yellow.
   readOut := WriteStream on: String new.

   colours do:[:aColour| 
      colours do:[:anotherColour| 
         aColour printOn: readOut.
         readOut nextPutAll: ' + '.
         anotherColour printOn: readOut.
         readOut nextPutAll: ' -> '.
         (aColour complementaryColourFor: anotherColour) printOn: readOut.
         readOut cr
         ]
      ].
   ^readOut.!

initialize
   "self initialize"
   red:=self createRed.
   blue:=self createBlue.
   yellow:=self createYellow.! !

!ChameneosColour class methodsFor: 'accessing'!

blue
   ^blue!

blue: anObject
   blue := anObject!

red
   ^red!

red: anObject
   red := anObject!

yellow
   ^yellow!

yellow: anObject
   yellow := anObject! !


!ChameneosColour methodsFor: 'as yet unclassified'!

color
   ^color!

color: aColor
   color:=aColor .!

complementaryColourFor: aChameneosColour
   "determine the complementary colour defined as..."
   (self==aChameneosColour) ifTrue:[^self].
   self isBlue 
      ifTrue: [
         aChameneosColour isRed 
            ifTrue: [^self class yellow] 
            ifFalse: [^self class red.]
         ].
   self isRed 
      ifTrue: [
         aChameneosColour isBlue 
            ifTrue: [^self class yellow] 
            ifFalse: [^self class blue.]
         ].
   aChameneosColour isBlue 
      ifTrue: [^self class red] 
      ifFalse: [^self class blue.].!

hasSameColorAs: aChameneos
   ^self color==aChameneos color.!

isBlue
   ^self==self class blue.!

isRed
   ^self==self class red.!

isYellow
   ^self==self class yellow.!

printOn: aStream
   aStream nextPutAll: self color.! !

#{ChameneosColour} initialize!

Smalltalk defineClass: #Creature
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'creatureName colour selfMet creaturesMet '
   classInstanceVariableNames: ''
   imports: ''
   category: 'chameleon'!



!Creature class methodsFor: 'as yet unclassified'!

withName: aName colour: aColour
   |creature|
   creature:=Creature new initialize.
   creature name: aName.
   creature colour: aColour .
   ^creature.! !



!Creature methodsFor: 'as yet unclassified'!

initialize
   selfMet := 0.
   creaturesMet := 0.!

visitMall: mall 
      [   | partner | 
      partner := mall visitWith: self.
      partner ifNotNil: 
         [ colour:= (colour complementaryColourFor: partner colour).
         self == partner
            ifTrue: [ selfMet := selfMet + 1 ].
            creaturesMet := creaturesMet + 1.
          ] . 
      partner isNil. ] whileFalse! !

!Creature methodsFor: 'accessing'!

colour
   ^ colour!

colour: anObject
   colour := anObject!

creaturesMet
   ^ creaturesMet!

creaturesMet: anObject
   creaturesMet := anObject!

name
   ^ creatureName !

name: anObject
   creatureName := anObject!

selfMet
   ^ selfMet!

selfMet: anObject
   ^ selfMet := anObject! !

Smalltalk defineClass: #Mall
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'guard maxRendezvous open process queue cache pairCache '
   classInstanceVariableNames: ''
   imports: ''
   category: 'chameleon'!

Smalltalk.Mall defineSharedVariable: #Units
   private: false
   constant: false
   category: 'As yet unclassified'
   initializer: nil!



!Mall class methodsFor: 'as yet unclassified'!

closeMall: aMall forCreatures: creatures usingGuard: guard
   creatures size timesRepeat: [ guard wait ].
!

createCreaturesWith: aCollectionOfColours
   | aName |
   aName := 0.
   ^ aCollectionOfColours collect: [:aColour| 
      aName := aName + 1.
      Creature 
         withName: aName
         colour: aColour ].
!

generateReportFor: creatures 
   | sum readOut |
   readOut := WriteStream on: String new.
   creatures do: [:aCreature| 
      aCreature creaturesMet printOn: readOut.
      readOut space.
      aCreature selfMet printOn: readOut.
      readOut cr.
      ].
   sum := creatures inject: 0 into: [:accum :each| accum + each creaturesMet].
   readOut space.
   sum printString do: [ : el | 
      readOut
         nextPutAll: (self units at: el digitValue + 1) ;
         space ].
   ^ readOut!

generateReportForColours: colours
   | readOut |
   readOut := WriteStream on: String new.
   colours do: 
      [ :colour | 
         colour printOn: readOut.
         readOut space ].
   ^ readOut!

initialize
   "self initialize"
   Units := #(
      'zero'
      'one'
      'two'
      'three'
      'four'
      'five'
      'six'
      'seven'
      'eight'
      'nine'
   ).!

new
   ^super new initialize.!

openMall: aMall forCreatures: creatures usingGuard: sema 
   |processes|
   processes:=creatures collect: [ :aCreature | 
         [ aCreature visitMall: aMall. sema signal ] newProcess
      ].
   processes do: [:proc| proc resume.].!

openMallWith: aCollectionOfColours forNumberOfMeets: aNumber 
   | mall creatures guard readOut |
   readOut := WriteStream on: String new.
   guard := Semaphore new.
   mall := Mall new.
   mall maxRendezvous: aNumber.
   mall run.

   readOut nextPutAll: 
      (self generateReportForColours: aCollectionOfColours) contents; 
      cr.
      
   creatures := self createCreaturesWith: aCollectionOfColours.
   self openMall: mall forCreatures:  creatures usingGuard: guard.
   self waitForClosingOfMall: mall withCreatures:  creatures usingGuard: guard.
   
   readOut nextPutAll: (self generateReportFor: creatures) contents; cr.
   ^readOut.!

runBenchMark: number on: anOutputStream
   |firstTestColours secondTestColours |

   anOutputStream nextPutAll: 
      (ChameneosColour generateReportOfColours contents); cr.

   firstTestColours := 
      Array 
         with: ChameneosColour createBlue 
         with: ChameneosColour createRed
         with: ChameneosColour createYellow.

   secondTestColours :=(OrderedCollection new) 
      add: ChameneosColour createBlue; 
      add: ChameneosColour createRed; 
      add: ChameneosColour createYellow;
      add: ChameneosColour createRed;
      add: ChameneosColour createYellow;
      add: ChameneosColour createBlue;
      add: ChameneosColour createRed;
      add: ChameneosColour createYellow;  
      add: ChameneosColour createRed;
      add: ChameneosColour createBlue;
      yourself.

   anOutputStream nextPutAll: 
      (Mall openMallWith: firstTestColours forNumberOfMeets: number) contents.
   anOutputStream cr.
   anOutputStream nextPutAll:
      (Mall openMallWith: secondTestColours  forNumberOfMeets: number) contents.
   anOutputStream flush.
!

units
   ^Units.!

waitForClosingOfMall: aMall withCreatures: creatures usingGuard: guard
   creatures size timesRepeat: [ guard wait ].
   aMall close.! !


!Mall methodsFor: 'accessing'!

maxRendezvous: max
    maxRendezvous:=max.! !

!Mall methodsFor: 'as yet unclassified'!

close
   open:=false.
!

initialize
   guard := Semaphore forMutualExclusion.
   queue:=SharedQueue new.
   cache:=OrderedCollection new.
   1 to: 11 do: [:x| cache add: Pair new].!

obtainPair
   ^cache removeFirst.
!

processVisitors
   [open] whileTrue: [
      1 to: maxRendezvous do: [ :x| |first second| 
         first:=queue next. second:=queue next.
         self setPartnersOn: first and: second.
      first signal.
      second signal.
      ].
      [queue isEmpty] whileFalse: [queue next signal].
   ].
   process terminate.
   process:=nil.!

releasePair: pair
   pair partner: nil. 
   cache addFirst: pair.
!

run
   open:=true.
   process ifNil:[
      process := [self processVisitors] newProcess. 
      process priority: Processor userBackgroundPriority.
      ].
   process resume.!

setPartnersOn: first and: second
   first partner: second me.
   second partner: first me.
!

visitWith: aChameneos 
   |pair partner|
   pair := self obtainPair.

   pair me: aChameneos.
   queue nextPut: pair.
   pair wait.

   partner := pair partner.
   self releasePair: pair.
   ^ partner.! !

#{Mall} initialize!

Smalltalk defineClass: #Pair
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'partner me sema '
   classInstanceVariableNames: ''
   imports: ''
   category: '(none)'!



!Pair class methodsFor: 'instance creation'!

new
   ^super new initialize!

with: me   ^super new initialize me: me.! !


!Pair methodsFor: 'accessing'!

me
   ^me!

me: anObject
   me := anObject!

partner
   ^partner!

partner: anObject
   partner := anObject! !

!Pair methodsFor: 'initialize-release'!

initialize
   "Initialize a newly created instance. This method must answer the receiver."
   partner := nil.
   me:=nil.
   sema:=Semaphore new.
   ^self!

signal
   sema signal.!

wait
   sema wait.! !


!Tests class methodsFor: 'benchmark scripts'!

chameneosredux2
   Mall runBenchMark: self arg on: self stdout.
   ^''! !
