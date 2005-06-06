(* fasta.sml
 *
 *   Generate and write random "DNA" sequences.
 *
 * Copyright (c) 2004 by The Fellowship of SML/NJ
 *
 * Author: Matthias Blume (blume@tti-c.org)
 *
 *)

structure Test:sig val main:string*string list->OS.Process.status end = struct

    val len = 60

    infix 8 $ % val (op $, op %) = (Unsafe.Array.sub, Unsafe.CharVector.sub)
    infix 3 <-  fun (a, i) <- x = Unsafe.Array.update (a, i, x)
    fun x - y = Word.toIntX (Word.- (Word.fromInt x, Word.fromInt y))
    fun succ x = Word.toIntX (Word.fromInt x + 0w1)

    fun out s = TextIO.output (TextIO.stdOut, s)
    fun out1 c = TextIO.output1 (TextIO.stdOut, c)
    fun ssl(s,i,j) =
	(TextIO.outputSubstr(TextIO.stdOut,Substring.substring(s,i,j));
	 out1 #"\n")

    (* word->real conversion *)
    val wreal = real o Word.toIntX
    (* the constants for the random number generator *)
    val (M, A, C) = (0w139968, 0w3877, 0w29573)     val M' = 1.0 / wreal M

    (* the random number generator *)
    val random = let val l = ref 0w42
		 in fn m=>let val c = (!l*A+C) mod M in l:=c; m*M'*wreal c end
		 end

    fun stretch s = if size s < len then stretch (s^s) else (s^s, size s)

    (* calculate cumulative probabilities *)
    fun mkCumul l =
	let val (cl, pl) = ListPair.unzip l
	    val (s, a) = (CharVector.fromList cl, Array.fromList pl)
	    fun upd (i, p, s) = let val s = s+p in (a,i)<-s; s end
	in ignore (Array.foldli upd 0.0 a); (s, a, Array.length a - 1) end

    (* fixed sequence to be repeated *)
    val alu = stretch "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG\
		      \GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA\
		      \CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT\
		      \ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA\
		      \GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG\
		      \AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC\
		      \AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

    (* the bases with their probabilities *)
    val homosapiens = mkCumul [(#"a", 0.3029549426680), (#"c", 0.1979883004921),
			       (#"g", 0.1975473066391), (#"t", 0.3015094502008)]

    val iub = mkCumul [(#"a",0.27), (#"c",0.12), (#"g",0.12), (#"t",0.27),
		       (#"B",0.02), (#"D",0.02), (#"H",0.02), (#"K",0.02),
		       (#"M",0.02), (#"N",0.02), (#"R",0.02), (#"S",0.02),
		       (#"V",0.02), (#"W",0.02), (#"Y",0.02)]

    (* select a random base *)
    fun selRandom (s, a, n') =
	let val r = random 1.0
	    fun l i = if i >= n' orelse a$i > r then s%i else l (succ i)
	in l 0 end

    (* make a sequence by repeating a template *)
    fun rptff (id, desc, (s, l), n) =
	let fun lp (0, _) = ()
	      | lp (n, k) =
		  if n<len then ssl(s,k,n)
		  else let val k' = k+len
		       in ssl(s,k,len); lp(n-len, if k'>=l then k'-l else k')
		       end
	in app out [">", id, " ", desc, "\n"]; lp (n, 0) end

    (* make random fasta fragment *)
    fun rndff (id, desc, sa, n) =
	let fun loop n = let val m = Int.min(n,len) in loop' (n-m,m) end
	    and loop' (n, 0) = (out1 #"\n"; if n>0 then loop n else ())
	      | loop' (n, m) = (out1 (selRandom sa); loop' (n,m-1))
	in app out [">", id, " ", desc, "\n"]; loop n end

    (* test harness *)
    fun make' n = (rptff("ONE", "Homo sapiens alu", alu, n*2);
		   rndff("TWO", "IUB ambiguity codes", iub, n*3);
		   rndff("THREE", "Homo sapiens frequency", homosapiens, n*5);
		   OS.Process.success)

    (* driver *)
    fun main (_, []) = make' 1
      | main (_, arg :: _) = make' (getOpt (Int.fromString arg, 1))
end

val _ = Test.main (CommandLine.name (), CommandLine.arguments ())
