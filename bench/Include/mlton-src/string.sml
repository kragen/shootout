structure String =
   struct
      open String

      type t = string

      fun fold (s, b, f) = CharVector.foldl f b s

      fun hash s =
	 fold (s, 0w0, fn (c, h) =>
	       Word.<< (h, 0w5) + h + 0w720 + Word.fromChar c)
   end	 
