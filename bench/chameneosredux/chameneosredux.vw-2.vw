"* The Computer Language Benchmarks Game
    http://shootout.alioth.debian.org/
    contributed by Carlo Teixeira *"!

Object subclass: #Tests
   instanceVariableNames: ''
   classVariableNames: ''
   poolDictionaries: ''
   category: 'Shootout'!

Tests class
   instanceVariableNames: ''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!Tests class methodsFor: 'benchmarking-scripts'!

chameneosredux2
   Mall runBenchMark: self arg on: self stdout.
   ^''! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


Object subclass: #Pair
   instanceVariableNames: 'partner me sema '
   classVariableNames: ''
   poolDictionaries: ''
   category: '(none)'!

Pair class
   instanceVariableNames: ''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!Pair class methodsFor: 'instance creation'!

new
   "Answer a newly created and initialized instance."
   ^super new initialize.!

with: me 
   "Answer a newly created and initialized instance."
self halt.
   ^super new initialize me: me! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


Pair comment:
''!

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
   me := nil.
   sema := Semaphore new.
   ^self!

release
partner:=nil.!

signal
   sema signal!

wait
   sema wait! !

Object subclass: #Mall
   instanceVariableNames: 'guard maxRendezvous open process queue cache pairCache '
   classVariableNames: 'Units '
   poolDictionaries: ''
   category: 'chameleon'!

Mall class
   instanceVariableNames: ''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!Mall class methodsFor: 'printing'!

generateReportFor: creatures printOn: stream 
   | sum |
   sum := creatures inject: 0 into: [:accum :each | accum + each creaturesMet].
   creatures do: 
         [:aCreature | 
         aCreature creaturesMet printOn: stream.
         stream
            space;
            nextPutAll: (self units at: aCreature selfMet + 1);
            nl].
   stream space.
   sum printString 
      do: [:el | stream nextPutAll: (self units at: el digitValue + 1)]
      separatedBy: [stream space].
   ^stream!

generateReportForColours: colours printOn: stream 
   stream space.
   colours do: [:colour | colour printOn: stream] separatedBy: [stream space].
   ^stream! !

!Mall class methodsFor: 'initialize-release'!

createAllowing: maxRendezvous 
   "Private"

   ^self basicNew initialize maxRendezvous: maxRendezvous!

createCreaturesWith: aCollectionOfColours 
   "Private"

   | aName |
   aName := 0.
   ^aCollectionOfColours collect: 
         [:aColour | 
         aName := aName + 1.
         Creature withName: aName colour: aColour]!

initialize
   "self initialize"

   Units := #('zero' 'one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine')!

new
   ^self shouldNotImplement!

openMallWith: aCollectionOfColours forNumberOfMeets: aNumber 
   | mall creatures guard |
   mall := self createAllowing: aNumber.
   mall run.
   creatures := self createCreaturesWith: aCollectionOfColours.
   guard := Semaphore new.
   self 
      openMall: mall
      forCreatures: creatures
      usingGuard: guard.
   self 
      waitForClosingOfMall: mall
      withCreatures: creatures
      usingGuard: guard.
   ^creatures! !

!Mall class methodsFor: 'private'!

openMall: aMall forCreatures: creatures usingGuard: sema 
   | processes |
   processes := creatures 
            collect: [:aCreature | 
               [aCreature visitMall: aMall.
               sema signal] newProcess].
   processes do: 
         [:proc | 
         proc priority: Processor userBackgroundPriority.
         proc resume]!

waitForClosingOfMall: aMall withCreatures: creatures usingGuard: guard 
   creatures size timesRepeat: [guard wait].
   aMall close! !

!Mall class methodsFor: 'accessing'!

units
   ^Units! !

!Mall class methodsFor: 'public'!

runBenchMark: number on: anOutputStream 
   "self runBenchMark: 60000 on: Transcript."

   | firstTestColours secondTestColours blue red yellow creatures |
   blue := ChameneosColour blue.
   red := ChameneosColour red.
   yellow := ChameneosColour yellow.
   firstTestColours := Array 
            with: blue
            with: red
            with: yellow.
   secondTestColours := (OrderedCollection new)
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: yellow;
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: blue;
            yourself.
   (ChameneosColour generateReportOfColoursOn: anOutputStream) nl.
   (self generateReportForColours: firstTestColours printOn: anOutputStream) 
      nl.
   creatures := Mall openMallWith: firstTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      nl;
      nl.
   (self generateReportForColours: secondTestColours printOn: anOutputStream) 
      nl.
   creatures := Mall openMallWith: secondTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      nl;
      nl! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


Mall comment:
''!

!Mall methodsFor: 'accessing'!

maxRendezvous: max 
   maxRendezvous := max! !

!Mall methodsFor: 'private'!

obtainPair
   ^cache removeFirst!

processVisitors
   [open] whileTrue: 
         [1 to: maxRendezvous
            do: 
               [:x | 
               | first second |
               first := queue next.
               second := queue next.
               self setPartnersOn: first and: second.
               first signal.
               second signal].
         [queue isEmpty] whileFalse: [queue next signal]].
   process terminate.
   process := nil!

releasePair: pair 
   pair release.
   cache addFirst: pair!

setPartnersOn: first and: second
   first partner: second me.
   second partner: first me.
!

shutdown
   [queue isEmpty] whileFalse: [queue next signal].
   process terminate.
   process := nil! !

!Mall methodsFor: 'initialize-release'!

initialize
   guard := Semaphore forMutualExclusion.
   queue := SharedQueue new.
   cache := OrderedCollection new.
   1 to: 10 do: [:x | cache add: Pair new]!

run
   open := true.
   process ifNil: 
         [process := [self processVisitors] newProcess.
         process priority: Processor userBackgroundPriority -1 ].
   process resume! !

!Mall methodsFor: 'controlling'!

close
   open := false!

visitWith: aChameneos 
   | pair partner |
   pair := self obtainPair.
   pair me: aChameneos.
   queue nextPut: pair.
   pair wait.
   partner := pair partner.
   self releasePair: pair.
   ^partner! !

Mall initialize!

Object subclass: #Creature
   instanceVariableNames: 'creatureName colour selfMet creaturesMet '
   classVariableNames: ''
   poolDictionaries: ''
   category: 'chameleon'!

Creature class
   instanceVariableNames: ''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!Creature class methodsFor: 'initialize-release'!

withName: aName colour: aColour 
   ^(Creature new initialize)
      name: aName;
      colour: aColour! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!Creature methodsFor: 'accessing'!

colour
   ^colour!

colour: anObject 
   colour := anObject!

creaturesMet
   ^creaturesMet!

creaturesMet: anObject 
   creaturesMet := anObject!

name
   ^creatureName!

name: anObject 
   creatureName := anObject!

selfMet
   ^selfMet!

selfMet: anObject 
   ^selfMet := anObject! !

!Creature methodsFor: 'initialize-release'!

initialize
   selfMet := 0.
   creaturesMet := 0! !

!Creature methodsFor: 'controlling'!

visitMall: mall 
   
   [| partner |
   partner := mall visitWith: self.
   partner ifNotNil: 
         [colour := colour complementaryColourFor: partner colour.
         self == partner ifTrue: [selfMet := selfMet + 1].
         creaturesMet := creaturesMet + 1].
   partner isNil] 
         whileFalse! !

Object subclass: #ChameneosColour
   instanceVariableNames: 'color '
   classVariableNames: 'Blue Red Yellow '
   poolDictionaries: ''
   category: 'chameleon'!

ChameneosColour class
   instanceVariableNames: ''!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!ChameneosColour class methodsFor: 'accessing'!

blue
   ^Blue!

blue: anObject
   Blue := anObject!

red
   ^Red!

red: anObject
   Red := anObject!

yellow
   ^Yellow!

yellow: anObject
   Yellow := anObject! !

!ChameneosColour class methodsFor: 'initialize-release'!

createBlue
   "comment stating purpose of message"

   ^super new color: #blue!

createRed
   "comment stating purpose of message"

   ^super new color: #red!

createYellow
   "comment stating purpose of message"

   ^super new color: #yellow!

initialize
   "self initialize"

   Red := self createRed.
   Blue := self createBlue.
   Yellow := self createYellow! !

!ChameneosColour class methodsFor: 'printing'!

generateReportOfColoursOn: readOut 
   | colours |
   colours := Array 
            with: Blue
            with: Red
            with: Yellow.
   colours do: 
         [:aColour | 
         colours do: 
               [:anotherColour | 
               aColour printOn: readOut.
               readOut nextPutAll: ' + '.
               anotherColour printOn: readOut.
               readOut nextPutAll: ' -> '.
               (aColour complementaryColourFor: anotherColour) printOn: readOut.
               readOut nl]].
   ^readOut! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!


!ChameneosColour methodsFor: 'as yet unclassified'!

complementaryColourFor: aChameneosColour 
   "determine the complementary colour defined as..."

   self == aChameneosColour ifTrue: [^self].
   self isBlue 
      ifTrue: 
         [aChameneosColour isRed 
            ifTrue: [^self class yellow]
            ifFalse: [^self class red]].
   self isRed 
      ifTrue: 
         [aChameneosColour isBlue 
            ifTrue: [^self class yellow]
            ifFalse: [^self class blue]].
   aChameneosColour isBlue 
      ifTrue: [^self class red]
      ifFalse: [^self class blue]! !

!ChameneosColour methodsFor: 'testing'!

hasSameColorAs: aChameneos 
   ^self color == aChameneos color!

isBlue
   ^self == self class blue!

isRed
   ^self == self class red!

isYellow
   ^self == self class yellow! !

!ChameneosColour methodsFor: 'accessing'!

color
   ^color!

color: aColor 
   color := aColor! !

!ChameneosColour methodsFor: 'printing'!

printOn: aStream 
   aStream nextPutAll: self color! !

ChameneosColour initialize!
