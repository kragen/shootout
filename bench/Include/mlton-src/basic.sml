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
   end

structure Array =
   struct
      open Array

      fun foldi (a, b, f) =
	 let
	    val n = length a
	    fun loop (i, b) =
	       if i = n
		  then b
	       else loop (i + 1, f (i, sub (a, i), b))
	 in
	    loop (0, b)
	 end
   end
