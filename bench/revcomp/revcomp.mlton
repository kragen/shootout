(* reverse-complement.mlton
 *
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * contributed by Troestler Christophe
 * translated by sweeks@sweeks.com for MLton/SML from the OCaml version
 *)

val complement =
  let
     val cplt = Array.tabulate (256, chr)
     fun u (c, c') = Array.update (cplt, ord c, c')
     val () =
	List.app
	(fn (c1, c2) =>
	 (u (c1, c2); u (c2, c1)
	  ; u (Char.toLower c1, c2); u (Char.toLower c2, c1)))
	[(#"A",#"T"), (#"C",#"G"), (#"B",#"V"), (#"D",#"H"), (#"K",#"M"),
	 (#"R",#"Y")]
  in
     fn c => Array.sub (cplt, ord c)
  end

(* [reverse s] reverse-complement the string [s] in place. *)
fun reverse (s: char array): unit =
  let
     fun rev (i, j) =
	if i >= j
	   then ()
	else
	   let
	      val si = Array.sub (s, i)
	      val () = Array.update (s, i, complement (Array.sub (s, j)))
	      val () = Array.update (s, j, complement si)
	   in
	      rev (i + 1, j - 1)
	   end
  in
     rev (0, Array.length s - 1)
  end

fun printFasta (dna: char array): unit =
  let
     fun output1 c = TextIO.output1 (TextIO.stdOut, c)
     val n = Array.length dna
     fun grab i =
	if i = n
	   then ()
	else
	   let 
	      fun loop (i, count) =
		 if 0 = count 
		    then (output1 #"\n"; grab i)
		 else (output1 (Array.sub (dna, i)); loop (i + 1, count - 1))
	   in
	      loop (i, Int.min (n - i, 60))
	   end
  in
     grab 0
  end

structure Buffer:
   sig
      type t

      val addLine: t * string -> t
      val contents: t -> char array
      val empty: t
   end =
   struct
      datatype t = T of string list

      val empty: t = T []

      fun addLine (T xs, x) = T (x :: xs)

      fun contents (T lines) =
	 let
	    val n = foldl (fn (s, n) => n + size s - 1) 0 lines
	    val a = Array.array (n, #"\000")
	    val _ =
	       foldl (fn (s, i) =>
		      let
			 fun loop (i, j)  =
			    if j < 0
			       then i
			    else (Array.update (a, i, String.sub (s, j))
				  ; loop (i - 1, j - 1))
		      in
			 loop (i, String.size s - 2)
		      end)
	       (n - 1) lines
	 in
	    a
	 end
   end

fun one (b: Buffer.t): unit =
   let
      val a = Buffer.contents b
      val () = reverse a
   in
      printFasta a
   end
   
fun loop (b: Buffer.t) =
   case TextIO.inputLine TextIO.stdIn of
      NONE => one b
    | SOME line => 
	 if size line > 0 andalso String.sub (line, 0) = #">"
	    then (one b; print line; loop Buffer.empty)
	 else loop (Buffer.addLine (b, line))

val () = loop Buffer.empty


