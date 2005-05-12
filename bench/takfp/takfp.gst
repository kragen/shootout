"  The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   contributed by Isaac Gouy 

   To run: gst -QI /usr/share/gnu-smalltalk/gst.im takfp.st -a 7
"

!Float methodsFor: 'shootout'!

takfp: aFloatY z: aFloatZ
   ^aFloatY < self 
      ifTrue: [ 
         ((self - 1.0) takfp: aFloatY z: aFloatZ)      
            takfp: ((aFloatY - 1.0) takfp: aFloatZ z: self) 
            z: ((aFloatZ - 1.0) takfp: self z: aFloatY)
         ]
      ifFalse: [aFloatZ] ! !


| n |
n := Smalltalk arguments first asInteger.

(((n * 3.0) takfp: (n * 2.0) z: (n * 1.0)) asScaledDecimal: 1) displayNl !




"
  vim: ts=4 ft=st
"
