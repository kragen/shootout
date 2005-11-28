"  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy"!

!ComputerLanguageShootout.Benchmarks class methodsFor: 'benchmarking'!

binarytrees: argvString
   | minDepth n maxDepth stretchDepth check longLivedTree iterations | 
   minDepth := 4.
   n := argvString asNumber.
   maxDepth := minDepth + 2 max: n.
   stretchDepth := maxDepth + 1.

   check := (TreeNode bottomUpTree: 0 depth: stretchDepth) itemCheck.
   OS.Stdout 
      nextPutAll: 'stretch tree of depth '; nextPutAll: stretchDepth printString; nextPut: Character tab;
      nextPutAll: ' check: '; nextPutAll: check printString; cr.

   longLivedTree := TreeNode bottomUpTree: 0 depth: maxDepth.
   minDepth to: maxDepth by: 2 do: [:depth|
      iterations := 1 bitShift: maxDepth - depth + minDepth.

      check := 0.
      1 to: iterations do: [:i|
         check := check + (TreeNode bottomUpTree: i depth: depth) itemCheck.
         check := check + (TreeNode bottomUpTree: -1*i depth: depth) itemCheck.
      ].
      OS.Stdout
         nextPutAll:  (2*iterations) printString; nextPut: Character tab; 
         nextPutAll: ' trees of depth '; nextPutAll: depth printString; nextPut: Character tab;
         nextPutAll: ' check: '; nextPutAll: check printString; cr.
   ].

   OS.Stdout
      nextPutAll: 'long lived tree of depth '; nextPutAll: maxDepth printString; nextPut: Character tab;
      nextPutAll: ' check: '; nextPutAll: longLivedTree itemCheck printString; cr.! !


Smalltalk.ComputerLanguageShootout defineClass: #TreeNode
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'left right item '
	classInstanceVariableNames: ''
	imports: ''
	category: 'ComputerLanguageShootout'!


!ComputerLanguageShootout.TreeNode class methodsFor: 'instance creation'!

bottomUpTree: anItem depth: anInteger
   ^(anInteger > 0) 
      ifTrue: [
         self 
            left: (self bottomUpTree: 2*anItem - 1 depth: anInteger - 1) 
            right: (self bottomUpTree: 2*anItem depth: anInteger - 1)  
            item: anItem
         ]
      ifFalse: [self left: nil right: nil item: anItem] !

left: leftChild right: rightChild item: anItem      
   ^(super new) left: leftChild right: rightChild item: anItem! !


!ComputerLanguageShootout.TreeNode methodsFor: 'initialize-release'!

left: leftChild right: rightChild item: anItem
   left := leftChild.
   right := rightChild.
   item := anItem! !

!ComputerLanguageShootout.TreeNode methodsFor: 'accessing'!

itemCheck
   ^left isNil 
      ifTrue: [item] ifFalse: [item + (left itemCheck - right itemCheck)]! !
