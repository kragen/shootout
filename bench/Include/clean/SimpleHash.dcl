definition  module SimpleHash

:: .HashTable a

htNew :: .Int -> .(HashTable a)
htHasKey :: !{#.Char} !.(HashTable a) -> .Bool 
htAdd :: !{#.Char} a !*(HashTable a) -> .(HashTable a)