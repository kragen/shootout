(* The Computer Language Shootout
   http://shootout.alioth.debian.org/
   contributed by Scott Cruzen
*)

fun floor_ev (q,r,s,t) x:IntInf.int = IntInf.div ((q * x + r),(s * x + t))

fun comp (q,r,s,t) (q',r',s',t') : (IntInf.int * IntInf.int * IntInf.int * IntInf.int) =
   (q * q' + r * s',  q * r' + r * t',
    s * q' + t * s',  s * r' + t * t')

fun next z = floor_ev z 3
fun safe z n = n = floor_ev z 4
fun prod z n = comp (10, ~10 * n, 0, 1) z
fun cons z k =
   comp z (IntInf.fromInt k, IntInf.fromInt (2*(2*k+1)), 0, IntInf.fromInt (2*k+1))

fun digit k z n row col =
   if n > 0 then
      let val y = next z in
         if safe z y then
            if col = 10 then 
               let val row = row + 10 in
                  print("\t:" ^ IntInf.toString row ^ "\n" ^ IntInf.toString y);
                  digit k (prod z y) (n-1) row 1
               end
            else
               ( print (IntInf.toString y)
               ; digit k (prod z y) (n-1) row (col+1))
         else digit (k+1) (cons z k) n row col
      end
   else
      print(String.implode(List.tabulate((10 - IntInf.toInt col), fn x => #" "))
           ^ "\t:" ^ IntInf.toString (row + col) ^ "\n")

fun digits n = digit 1 (1,0,0,1) n 0 0

val () = digits (valOf (Int.fromString (hd (CommandLine.arguments()))))
