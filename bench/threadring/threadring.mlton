(* 
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * contributed by kaustuv Chaudhuri
 *)

fun setup nThreads N =
    let
      val res = CML.channel ()

      fun ringT ((inn, inc), (oun, ouc)) =
          let
            fun loop () =
                (case CML.recv inc of
                   0 => CML.send (res, inn)
                 | n => (CML.send (ouc, n - 1);
                         loop ()))
          in
            CML.spawn loop
          end

      val chans as c0 :: c1s =
            List.tabulate (nThreads, fn n => (n + 1, CML.channel ()))

      val threads = ListPair.map ringT (chans, c1s @ [c0])
    in
      CML.send (#2 c0, N);
      TextIO.print (Int.toString (CML.recv res) ^ "\n")
    end

fun doit N = RunCML.doit (fn () => setup 503 N, NONE)

val _ = (doit o Option.valOf o Int.fromString o List.hd o CommandLine.arguments) ()
