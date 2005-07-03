// The Great Computer Language Shootout 
// contributed by Isaac Gouy (Clean novice)


implementation module Heapsort
import StdEnv //, StdArrayExtensions


// Heapsort implementation adapted from:
//
// "The Implementation and Efficiency of Arrays in Clean 1.1"
// John H. G. van Groningen
// volume 1268 of Lecture Notes in Computer Science, 
// pages 105--124. Springer-Verlag, 1997
// http://www.cs.kun.nl/~clean/publications.html#1997

heapsort :: !*{#Real} -> .{#Real}
heapsort a0
   | n<2 = a
   = sort_heap (n-1) (mkheap (n>>1) (n-1) a)
   
   where
   (n,a) = usize a0
      
   mkheap (-1) m a = a
   mkheap i m a=:{[i]=ai} 
      = mkheap (i-1) m (add_to_heap i ((i<<1)+1) m ai a)
      
   sort_heap i a=:{[i]=ai, [0]=a0}
      | i==1 = {a & [0]=ai, [i]=a0}
      # b = (add_to_heap 0 1 deci ai {a & [i]=a0})
      = sort_heap deci ( b)
      with deci = i-1

   add_to_heap i j m ai a
      | j >= m 
         = if (j>m)
            {a & [i] = ai}
            (if (ai<aj)
               {a` & [i] = aj, [j]=ai}
               {a` & [i] = ai}
            )
      with (aj, a`) = uselect a j
      
   add_to_heap i j m ai a=:{[j]=aj}
      # j1 = j+1
      #! aj1 = a.[j1]
      | aj<aj1
         = if (ai<aj1)
            (add_to_heap j1 ((j1<<1)+1) m ai {a & [i]=aj1})
            {a & [i]=ai}
      = if (ai<aj)
         (add_to_heap j ((j<<1)+1) m ai {a & [i]=aj})
         {a & [i]=ai}
