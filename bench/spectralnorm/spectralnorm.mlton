(*
 *
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Sebastien Loisel
 * Cleanup by Troestler Christophe
 * Translated to SML by sweeks@sweeks.com
 *)

val sub = Array.sub
val update = Array.update

fun eval_A (i, j) = 1.0 / Real.fromInt ((i+j)*(i+j+1) div 2+i+1)
   
fun eval_A_times_u (u, v) =
  let
     val n = Array.length v
  in
     for (0, n, fn i =>
	  (update (v, i, 0.0)
	   ; for (0, n, fn j =>
		  update (v, i, sub (v, i) + eval_A (i, j) * sub (u, j)))))
  end

fun eval_At_times_u (u, v) =
   let
      val n = Array.length v
   in
      for (0, n, fn i =>
	   (update (v, i, 0.0)
	    ; for (0, n, fn j =>
		   update (v, i, sub (v, i) + eval_A (j, i) * sub (u, j)))))
   end

fun eval_AtA_times_u (u, v) =
   let
      val w = Array.array (Array.length u, 0.0)
   in
      eval_A_times_u (u, w)
      ; eval_At_times_u (w, v)
   end

val n = valOf (Int.fromString (hd (CommandLine.arguments ()))) handle _ => 1
val u = Array.array (n, 1.0)
val v = Array.array (n, 0.0)
val () = for (0, 10, fn _ => (eval_AtA_times_u (u, v); eval_AtA_times_u (v, u)))

val vv = ref 0.0
val vBv = ref 0.0
val () =
   for (0, n, fn i =>
	(vv := !vv + sub (v, i) * sub (v, i)
	; vBv := !vBv + sub (u, i) * sub (v, i)))

val () = print (concat [Real.fmt (StringCvt.FIX (SOME 9))
			(Real.Math.sqrt (!vBv / !vv)),
			"\n"])
