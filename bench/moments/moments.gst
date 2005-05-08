"  The Great Computer Language Shootout
   contributed by Isaac Gouy
   
   To run: gst -QI /usr/share/gnu-smalltalk/gst.im moments.st < input.txt 

"

!Float methodsFor: 'printing'!

printStringRoundedTo: anInteger
   | n s |
   n := 0.5d * (10 raisedToInteger: anInteger negated).
   s := ((self sign < 0) ifTrue: [self - n] ifFalse: [self + n]) printString.
   ^s copyFrom: 1 to: (s indexOf: $.) + anInteger ! !  
   
   
| stream numbers sum n mean dev adev dev2 
  variance skew kurtosis sdev mid median |  
  
stream := FileStream stdin bufferSize: 4096.
numbers := (stream splitAt: Character nl) collect: [:each| each asNumber].

n := numbers size.
sum := numbers inject: 0.0 into: [:i :each| i + each].
dev := adev := variance := skew := kurtosis := 0.0d.         
mean := sum / n. 

numbers do: [:each|
   dev := each - mean.   
   adev := adev + (dev abs).   
   variance := variance + (dev2 := dev * dev). 
   skew := skew + (dev2 * dev).
   kurtosis := kurtosis + (dev2 * dev2).            

].

adev := adev / n.   
variance := variance / (n - 1).     
sdev := variance sqrt.

variance ~= 0 
   ifTrue: 
     [skew := skew / (n * variance * sdev).  
      kurtosis := kurtosis / (n * variance * variance) - 3.0d.
     ]. 
     
numbers := numbers asSortedCollection: [:a :b| a < b].
mid := n // 2.      
median := (n \\ 2) ~= 0
   ifTrue: [numbers at: mid]
   ifFalse: [((numbers at: mid) + (numbers at: mid + 1)) / 2.0d].
   
Transcript
   nextPutAll: 'n:                  '; 
   nextPutAll: n displayString; nl;     
   
   nextPutAll: 'median:             '; 
   nextPutAll: (median printStringRoundedTo: 6) displayString; nl;  
   
   nextPutAll: 'mean:               ';  
   nextPutAll: (mean printStringRoundedTo: 6) displayString; nl; 
   
   nextPutAll: 'average_deviation:  ';   
   nextPutAll: (adev printStringRoundedTo: 6) displayString; nl; 
            
   nextPutAll: 'standard_deviation: ';  
   nextPutAll: (sdev printStringRoundedTo: 6) displayString; nl; 
     
   nextPutAll: 'variance:           ';   
   nextPutAll: (variance printStringRoundedTo: 6) displayString; nl; 
         
   nextPutAll: 'skew:               ';       
   nextPutAll: (skew printStringRoundedTo: 6) displayString; nl;
    
   nextPutAll: 'kurtosis:           '; 
   nextPutAll: (kurtosis printStringRoundedTo: 6) displayString; nl !
      