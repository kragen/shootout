"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im binarytrees.st -a 12
"

Object subclass: #TreeNode
instanceVariableNames: 'left right item'
classVariableNames: ''
poolDictionaries: ''
category: nil !


!TreeNode class methodsFor: 'instance creation'!

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
   
   
!TreeNode methodsFor: 'initialize-release'! 
  
left: leftChild right: rightChild item: anItem
   left := leftChild.
   right := rightChild.
   item := anItem ! !
      
   
!TreeNode methodsFor: 'accessing'! 

itemCheck
   ^left isNil 
      ifTrue: [item] ifFalse: [item + (left itemCheck - right itemCheck)] ! !
      
      
| minDepth n maxDepth stretchDepth check longLivedTree iterations | 
minDepth := 4.
n := Smalltalk arguments first asInteger.
maxDepth := minDepth + 2 max: n.
stretchDepth := maxDepth + 1.

check := (TreeNode bottomUpTree: 0 depth: stretchDepth) itemCheck.
Transcript 
   show: 'stretch tree of depth '; show: stretchDepth printString; tab;
   show: ' check: '; showCr: check printString.

longLivedTree := TreeNode bottomUpTree: 0 depth: maxDepth.
minDepth to: maxDepth by: 2 do: [:depth|
   iterations := 1 bitShift: maxDepth - depth + minDepth.

   check := 0.
   1 to: iterations do: [:i|
      check := check + (TreeNode bottomUpTree: i depth: depth) itemCheck.
      check := check + (TreeNode bottomUpTree: -1*i depth: depth) itemCheck.
   ].
   Transcript
      show: (2*iterations) printString; tab; 
      show: ' trees of depth '; show: depth printString; tab;
      show: ' check: '; showCr: check printString.
].

Transcript
   show: 'long lived tree of depth '; show: maxDepth printString; tab; 
   show: ' check: '; showCr: longLivedTree itemCheck  printString !

