"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q matrix.st -a 300
"

Object subclass: #Matrix
instanceVariableNames: 'contents rows columns '
classVariableNames: ''
poolDictionaries: ''
category: nil !

!Matrix class methodsFor: 'instance creation'!

new: nRows by: nColumns
   ^(self basicNew) rows: nRows columns: nColumns ! !


!Matrix methodsFor: 'private'!

rows: nRows columns: nColumns
   contents := WordArray new: nRows * nColumns withAll: 0.
   rows := nRows.
   columns := nColumns ! !


!Matrix methodsFor: 'arithmetic'!

atAllPut: aMatrix1 dotProduct: aMatrix2
   1 to: aMatrix1 rows do: [ :i | 
      1 to: aMatrix2 columns do: [ :j | | sum |
         sum := (aMatrix1 at: i at: j) zero.
         1 to: aMatrix1 columns do: [:k | 
            sum := sum + ((aMatrix1 at: i at: k) * (aMatrix2 at: k at: j))].
         self at: i at: j put: sum.
      ].
   ] ! !


!Matrix methodsFor: 'accessing'!

at: aRowIndex at: aColumnIndex
   ^contents at: ((columns * (aRowIndex - 1)) + aColumnIndex) ! 

at: aRowIndex at: aColumnIndex put: value
   ^contents at: ((columns * (aRowIndex - 1)) + aColumnIndex) put: value ! 

atAllPutSequence
   | count |
   count := 1.
   1 to: rows do: [:i| 
      1 to: columns do: [:j|
         self at: i at: j put: count. 
         count := count + 1
      ]
   ] ! 

columns
   ^columns ! 

rows
   ^rows ! !



| n nRows nCols m1 m2 mm |
n := (Smalltalk arguments at: 1) asInteger.

nRows := 30. nCols := 30.
m1 := Matrix new: nRows by: nCols.
m1 atAllPutSequence.
m2 := m1 copy.

mm := Matrix new: nRows by: nCols.
n timesRepeat: [mm atAllPut: m1 dotProduct: m2].

(mm at: 1 at: 1) display. ' ' display.
(mm at: 3 at: 4) display. ' ' display.
(mm at: 4 at: 3) display. ' ' display.
(mm at: 5 at: 5) displayNl !