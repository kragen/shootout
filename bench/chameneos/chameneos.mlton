(* The Computer Language Shootout
 * http://shootout.alioth.debian.org/
 *
 * Contributed by Vesa Karvonen.
 *)

(* abbreviations *)
structure A=CommandLine and C=CML and I=Int and R=RunCML

(* color manipulation *)
datatype color = R | B | Y

val compl = fn (B,B) => B | (B,R) => Y | (B,Y) => R | (R,B) => Y | (R,R) => R
             | (R,Y) => B | (Y,B) => R | (Y,R) => B | (Y,Y) => Y

(* creates the meeting place *)
fun place n =
   let val p = C.channel ()
       fun lp 0 = (C.send (#1 (C.recv p), NONE) ; lp 0)
         | lp n = let val ((a1, c1), (a2, c2)) = (C.recv p, C.recv p)
                  in C.send (a1, SOME c2) ; C.send (a2, SOME c1) ; lp (n-1) end
   in ignore (C.spawn (fn () => lp n)) ; p end

(* creates an animal *)
fun animal p m c = let val a = C.channel ()
                       fun lp (n, c) = (C.send (p, (a, c))
                                      ; case C.recv a of
                                            NONE => C.send (m, n)
                                          | SOME oc => lp (n+1, compl (c, oc)))
                   in ignore (C.spawn (fn () => lp (0, c))) end

(* driver *)
fun go n () = let val (p, m) = (place n, C.channel ())
              in foldl (fn (c, f) => (animal p m c ; f o (fn s => s+C.recv m)))
                       (fn s => print (I.toString s^"\n")) [B, R, Y, B] 0 end

val _ = R.doit (go(valOf(I.fromString(hd(A.arguments()))) handle _ => 1), NONE)
