(* fannkuch.ml
 *
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Troestler Christophe
 * Translated to SML by sweeks@sweeks.com.
 * Modified for new output requirements based on C# solution by
 *   sweeks@sweeks.com.
 *)

val sub = Array.sub
val update = Array.update

fun countFlips perm =
   let
      fun loop c =
	 let
	    val k = sub (perm, 0)
	 in
	    if k = 0 then c
	    else
	       let
		  val () = 
		     for (0, k div 2 + 1, fn i =>
			  let
			     val k_i = k - i
			     val perm_i = sub (perm, i)
			  in
			     update (perm, i, sub (perm, k_i))
			     ; update (perm, k_i, perm_i)
			  end)
	       in
		  loop (c + 1)
	       end
	 end
   in
      loop 0
   end

fun pfannkuchen n =
  let
     val perm = Array.array (n, 0)
     val perm1 = Array.tabulate (n, fn i => i)
     val count = Array.array (n, 0)
     val maxFlips = ref 0
     val m = n - 1
     val check = ref 30
     fun loop r =
        let
           val () =
              if 0 = !check then ()
              else
                 (for (0, n, fn i =>
                       print (Int.toString (sub (perm1, i) + 1)));
                  print "\n";
                  Int.dec check)
           val () = for (0, r, fn i => update (count, i, i + 1))
           val () =
              if sub (perm1, 0) = 0 orelse sub (perm1, m) = m then ()
              else
                 let
                    val () =
                       for (0, n, fn i => update (perm, i, sub (perm1, i)))
                    val flips = countFlips perm
                 in
                    if flips > !maxFlips then maxFlips := flips else ()
                 end
           fun loop' r =
              if r = n then ()
              else
                 let
                    val perm0 = sub (perm1, 0)
                    val () = for (0, r, fn i =>
                                  update (perm1, i, sub (perm1, i + 1)))
                    val () = update (perm1, r, perm0)
                    val () = update (count, r, sub (count, r) - 1)
                 in
                    if 0 < sub (count, r) then loop r else loop' (r + 1)
                 end
        in
           loop' 1
        end
     val () = loop n
  in
     !maxFlips
  end

val n = valOf (Int.fromString (hd (CommandLine.arguments ()))) handle _ => 1

val () = print (concat ["Pfannkuchen(", Int.toString n, ") = ",
			Int.toString (pfannkuchen n), "\n"])
