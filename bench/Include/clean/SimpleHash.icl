implementation module SimpleHash
import StdEnv
   
primes =: [
   53,         97,         193,       389,       769,
   1543,       3079,       6151,      12289,     24593,
   49157,      98317,      196613,    93241,     786433,
   1572869,    3145739,    6291469,   12582917,  25165843,
   50331653,   100663319,  201326611, 402653189, 805306457
   ]

:: Item a = { key::!String
            , val::a 
            }

:: HashTable a = { nBuckets::Int 
                 , table::!.{[Item a]}
                 , nItems::Int 
                 }


hash :: !{#.Char} !(HashTable .a) -> Int
hash key ht=:{nBuckets} 
   = (abs (loop key (size key - 1) 0)) rem nBuckets  
   where
   loop k n h
      | n>(-1) = loop k (n-1) (5*h + toInt k.[n])         
      = h


htNew :: .Int -> .(HashTable a)
htNew n = { nBuckets = nprime
        , table = {[] \\ i <- [1..nprime]}
        , nItems = 0
        }
   where    
   nprime = hd (dropWhile (\x = x < n) primes)         
      
    
htHasKey :: !{#.Char} !.(HashTable a) -> .Bool               
htHasKey k ht=:{table}= findIn k table.[hash k ht]    


htAdd :: !{#.Char} a !*(HashTable a) -> .(HashTable a)
htAdd k v ht=:{table,nItems} 
   #! i = hash k ht
   #! (b,table) = uselect table i
   = if (findIn k b) 
      {ht & table = update ht.table i (addItem k v b [])}
      {ht & table = update ht.table i [{key=k,val=v}:b], nItems = nItems+1}
         
      
findIn k [] = False
findIn k [item:ls] 
   | item.key == k   = True
   = findIn k ls   
   
   
addItem k v [] ls` = ls`
addItem k v [item:ls] ls`
   | item.key == k    = [{item & val=v}:ls] ++ ls`
   = addItem k v ls [item:ls`]   