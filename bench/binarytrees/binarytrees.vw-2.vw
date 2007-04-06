"*  The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Isaac Gouy
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

binarytrees2
   self binarytrees: CEnvironment argv first asNumber to: Stdout.
   ^'' ! !

!Shootout.Tests class methodsFor: 'benchmarks'!

binarytrees: n to: output
   | minDepth maxDepth stretchDepth check longLivedTree iterations | 
   minDepth := 4.
   maxDepth := minDepth + 2 max: n.
   stretchDepth := maxDepth + 1.

   check := (TreeNode bottomUpTree: 0 depth: stretchDepth) itemCheck.
   output
      nextPutAll: 'stretch tree of depth '; print: stretchDepth; tab;
      nextPutAll: ' check: '; print: check; cr.

   longLivedTree := TreeNode bottomUpTree: 0 depth: maxDepth.
   minDepth to: maxDepth by: 2 do: [:depth|
      iterations := 1 bitShift: maxDepth - depth + minDepth.

      check := 0.
      1 to: iterations do: [:i|
         check := check + (TreeNode bottomUpTree: i depth: depth) itemCheck.
         check := check + (TreeNode bottomUpTree: -1*i depth: depth) itemCheck].
      output
         print:  (2*iterations); tab; 
         nextPutAll: ' trees of depth '; print: depth; tab;
         nextPutAll: ' check: '; print: check; cr].

   output
      nextPutAll: 'long lived tree of depth '; print: maxDepth; tab;
      nextPutAll: ' check: '; print: longLivedTree itemCheck; cr ! !


Smalltalk.Shootout defineClass: #TreeNode
   superclass: #{Core.Object}
   indexedType: #none
   private: false
   instanceVariableNames: 'left right item '
   classInstanceVariableNames: ''
   imports: ''
   category: 'ComputerLanguageShootout' !

!Shootout.Tests class methodsFor: 'instance creation'!

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
   ^(super new) left: leftChild right: rightChild item: anItem ! !

!Shootout.Tests methodsFor: 'initialize-release'!

left: leftChild right: rightChild item: anItem
   left := leftChild.
   right := rightChild.
   item := anItem ! !

!Shootout.Tests methodsFor: 'accessing'!

itemCheck
   ^left isNil 
      ifTrue: [item] ifFalse: [item + (left itemCheck - right itemCheck)] ! !




