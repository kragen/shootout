"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy

   To run: gst -QI /usr/local/share/smalltalk/gst.im fannkuch.st -a 7
"

!Integer methodsFor: 'arithmetic'!

fannkuch
   "adjust for 1-indexed-arrays"
   | perm perm1 count maxPerm maxFlipsCount check m n r  |
   check := 0.
   perm := Array new: self withAll: 1.
   perm1 := (1 to: self) asArray.
   count := Array new: self withAll: 1.
   maxPerm := Array new: self withAll: 1.
   maxFlipsCount := 0. 
   m := self.
   n := self + 1.
   r := n. 

   [	| flipsCount k k2  |

      "write-out the first 30 permutations"
      (check < 30) ifTrue: [
         1 to: self do: [:i| Transcript show: (perm1 at: i) printString].
         Transcript nl.
         check := check + 1
      ].     

      [r ~=2] whileTrue: [ 
         count at: r - 1 put: r. 
         r := r - 1
      ].

      ((perm1 at: 1) = 1 or: [(perm1 at: m) = m]) ifFalse: [
         1 to: self do: [:i| perm at: i put: (perm1 at: i)].
         flipsCount := 0.

         [(k := perm at: 1) = 1] whileFalse: [
            k2 := k+1 bitShift: -1. 
            1 to: k2 do: [:i| | temp ki | 
               ki := k - i + 1.  "adjust for 1-indexed-arrays"
               temp := perm at: i.  
               perm at: i put: (perm at: ki). 
               perm at: ki put: temp
            ].
            flipsCount := flipsCount + 1.
         ].

         (flipsCount > maxFlipsCount) ifTrue: [
            maxFlipsCount := flipsCount.
            1 to: self do: [:i| maxPerm at: i put: (perm1 at: i)].
         ].
      ].

      [	|  perm0 i break | 
         (r = n) ifTrue: [
            ^'Pfannkuchen(', m printString, ') = ', maxFlipsCount printString
         ].

         perm0 := perm1 at: 1.
         i := 1.
         [i < r] whileTrue: [ | j | 
            j := i + 1. 
            perm1 at: i put: (perm1 at: j). 
            i := j
         ].
         perm1 at: r put: perm0.

         count at: r put: (count at: r) - 1.
         (break := (count at: r) > 1) ifFalse: [r := r + 1]. 
         break
      ] whileFalse.
   ] repeat ! !
   

Smalltalk arguments first asInteger fannkuch displayNl !
   
