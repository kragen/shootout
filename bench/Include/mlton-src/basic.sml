structure Int =
   struct
      open Int

      type t = int

      fun for (start, stop, f) =
	 let
	    fun loop i =
	       if i = stop
		  then ()
	       else (f i; loop (i + 1))
	 in
	    loop start
	 end
      
      fun forDown (lo, hi, f) =
	 let
	    fun loop i =
	       let
		  val i = i - 1
	       in
		  if i < lo
		     then ()
		  else (f i; loop i)
	       end
	 in
	    loop hi
	 end

      fun dec r = r := !r - 1
      fun inc r = r := !r + 1
   end

structure Word =
   struct
      open Word
	 
      type t = word

      val fromChar = fromInt o Char.ord

      fun log2 (w: t): t =
	 if w = 0w0
	    then raise Fail "Word.log2 0"
	 else
	    let
	       fun loop (n, s, ac): word =
		  if n = 0w1
		     then ac
		  else
		     let
			val (n, ac) =
			   if n >= << (0w1, s)
			      then (>> (n, s), ac + s)
			   else (n, ac)
		     in
			loop (n, >> (s, 0w1), ac)
		     end
	    in
	       loop (w, 0w16, 0w0)
	    end

      fun roundDownToPowerOfTwo (w: t) = << (0w1, log2 w)

      fun roundUpToPowerOfTwo w =
	 let
	    val w' = roundDownToPowerOfTwo w
	 in
	    if w = w'
	       then w
	    else w' * 0w2
	 end
   end

structure Array =
   struct
      open Array

      fun foldi (a, b, f) = Array.foldli f b a

      fun fold (a, b, f) = Array.foldl f b a

      fun foreach (a, f) = Array.app f a

      fun forall (a, f) = Array.all f a

      val new = array

      fun modify (a, f) = Array.modify f a
   end

structure List =
   struct
      open List

      type 'a t = 'a list

      fun peek (l, f) = List.find f l
	 
      fun fold (l, b, f) = List.foldl f b l

      fun foreach (l, f) = List.app f l

      fun forall (l, f) = List.all f l

      fun appendRev (l1, l2) = fold (l1, l2, op ::)
	 
      fun removeFirst (l, f) =
	 let
	    fun loop (l, ac) =
	       case l of
		  [] => raise Fail "removeFirst"
		| x :: l =>
		     if f x
			then appendRev (ac, l)
		     else loop (l, x :: ac)
	 in
	    loop (l, [])
	 end
   end

structure String =
   struct
      open String

      type t = string

      fun fold (s, b, f) = CharVector.foldl f b s

      fun hash s =
	 fold (s, 0w0, fn (c, h) =>
	       Word.<< (h, 0w5) + h + 0w720 + Word.fromChar c)
   end	 
