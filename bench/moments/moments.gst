"  The Great Computer Language Shootout
   contributed by Isaac Gouy

   To run: gst -Q moments.st < input.txt 
"

| stream numbers sum n mean dev adev dev2 
  variance skew kurtosis sdev mid median |  

stream := FileStream stdin bufferSize: 4096.
numbers := (stream splitAt: Character nl) collect: [:each| each asNumber].

n := numbers size.
sum := numbers inject: 0.0 into: [:i :each| i + each].
dev := adev := variance := skew := kurtosis := 0.0.         
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
      kurtosis := kurtosis / (n * variance * variance) - 3.0.
     ]. 

numbers := numbers asSortedCollection: [:a :b| a < b].
mid := n // 2.      
median := (n \\ 2) ~= 0
   ifTrue: [numbers at: mid]
   ifFalse: [((numbers at: mid) + (numbers at: mid + 1)) / 2.0].

Transcript
   nextPutAll: 'n:                  '; 
   nextPutAll: n displayString; cr;     

   nextPutAll: 'median:             '; 
   nextPutAll: (median asScaledDecimal: 6) displayString; cr;  
       
   nextPutAll: 'mean:               ';  
   nextPutAll: (mean asScaledDecimal: 6) displayString; cr; 
      
   nextPutAll: 'average_deviation:  ';  
   nextPutAll: (adev asScaledDecimal: 6) displayString; cr; 
           
   nextPutAll: 'standard_deviation: ';  
   nextPutAll: (sdev asScaledDecimal: 6) displayString; cr;   
    
   nextPutAll: 'variance:           ';   
   nextPutAll: (variance asScaledDecimal: 6) displayString; cr; 
      
   nextPutAll: 'skew:               ';       
   nextPutAll: (skew asScaledDecimal: 6) displayString; cr; 
 
   nextPutAll: 'kurtosis:           '; 
   nextPutAll: (kurtosis asScaledDecimal: 6) displayString; cr ! 
