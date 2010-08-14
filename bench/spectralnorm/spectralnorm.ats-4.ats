(*
** The Computer Language Benchmarks Game
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi
** contributed by Zhiqiang Ren
**
** compilation command:
**   atscc -D_GNU_SOURCE -D_ATS_MULTITHREAD -O3 -msse2 spectral-norm2_smp.dats -o spectral-norm2_smp -lm -lpthread
**
*)

(* ****** ****** *)

staload M = "libc/SATS/math.sats"

(* ****** ****** *)

staload "libc/SATS/SIMD_v2df.sats"

(* ****** ****** *)

%{^
#include <malloc.h>
static inline ats_ptr_type
darr_make (ats_int_type n, ats_double_type f) {
  int i; double *p0, *p ;
  // proper alignment is needed of v2df-processing
  p0 = (double*)memalign(64, n * sizeof(double)) ;
  p = p0; for (i = 0; i < n; ++i) *p++ = f ;
  return p0 ;
} // end of [darr_make]
static inline ats_void_type
darr_free (ats_ptr_type A) { free (A) ; return ; }
%} // end of [%{^]

(* ****** ****** *)

typedef dbl = double
typedef darr (n:int) = @[dbl][n] and v2dfarr (n:int) = @[v2df][n]

extern
fun darr_make {n:nat} (n: int n, ini: double)
  : [l:addr] (darr n @ l | ptr l) = "darr_make"

extern fun darr_free {n:nat}
  {l:addr} (pf: darr n @ l | p: ptr l): void = "darr_free"

(* ****** ****** *)

macdef denom (i, j) =
  (,(i) + ,(j)) * (,(i) + ,(j) + 1) / 2 + ,(i) + 1
macdef eval_A (i,j) = 1.0 / denom (,(i), ,(j))

fn eval_A_0 (i: int, j: int): v2df = let // two divisions at a time
  val k1 = denom(i,j); val k2 = denom (i,j+1) in v2df_1_1 / v2df_make_int_int (k1, k2)
end // end of [eval_A_0]

fn eval_A_1 (i: int, j: int): v2df = let // two divisions at a time
  val k1 = denom(i,j); val k2 = denom (i+1,j) in v2df_1_1 / v2df_make_int_int (k1, k2)
end // end of [eval_A_1]

(* ****** ****** *)

staload "libats/SATS/parworkshop.sats"
staload _ = "libats/DATS/parworkshop.dats"

(* ****** ****** *)

viewtypedef work = () -<lincloptr1> void
viewtypedef WSptr (l:addr) = WORKSHOPptr (work, l)

(* ****** ****** *)

fun fwork {lws:agz}
  (ws: !WSptr lws, wk: &work >> work?): int = let
  val wk = wk
  val pfun = __cast (wk) where {
    extern castfn __cast
      (wk: !work >> opt (work, i >= 1)): #[i:nat] uintptr i
  } // end of [val]
in
  if pfun >= (uintptr1_of_uint1)1U then let
    prval () = opt_unsome {work} (wk)
    val () = wk ()
    val () = cloptr_free (wk)
  in
    1 // the worker is to continue
  end else let
    val u = uint1_of_uintptr1 (pfun)
    val i = int_of_uint (u)
    prval () = opt_unnone {work} (wk)
    prval () = cleanup_top {work} (wk)
  in
    ~i // the worker is to pause or quit
  end // end of [if]
end // end of [fwork]

(* ****** ****** *)

infix 0 +=; macdef += (x, d) = (,(x) := ,(x) + ,(d))

(* ****** ****** *)

fn eval_A_times_u {lws:agz} {N:nat} {l:addr} (
    ws: !WSptr lws, flag: int, N: int N, u: &darr N, tmp: &darr N
  ) : void = let
  val N2 = N / 2; stadef N2 = N / 2
  fun loop2_0
    {i,j:nat | j <= N2} {l:addr} .<N2-j>. (
      pf: !v2dfarr (N2-j) @ l
    | p_dd: ptr l, sum: &v2df, i: int i, j: int j
    ) :<cloref1> void =
    if j < N2 then let
      prval (pf1, pf2) = array_v_uncons {v2df} (pf)
      val () = sum += !p_dd * eval_A_0 (i, 2*j)
      val () = loop2_0 (pf2 | p_dd + sizeof<v2df>, sum, i, j+1)
    in
      pf := array_v_cons {v2df} (pf1, pf2)
    end // end of [if]
  // end of [loop2_0]
  fun loop2_1
    {i,j:nat | j <= N2} {l:addr} .<N2-j>. (
      pf: !v2dfarr (N2-j) @ l
    | p_dd: ptr l, sum: &v2df, i: int i, j: int j
    ) :<cloref1> void =
    if j < N2 then let
      prval (pf1, pf2) = array_v_uncons {v2df} (pf)
      val () = sum += !p_dd * eval_A_1 (2*j, i)
      val () = loop2_1 (pf2 | p_dd + sizeof<v2df>, sum, i, j+1)
    in
      pf := array_v_cons {v2df} (pf1, pf2)
    end // end of [if]
  // end of [loop2_1]
//
  fun loop1
    {i,i1:nat| i <= i1; i1 <= N} {l:addr} .<i1-i>. (
      pf: !darr N @ l | i:int i, i1: int i1, p_u: ptr l, tmp: &darr N
    ) :<cloref1> void = let
    viewdef V1 = darr N @ l; viewdef V2 = v2dfarr (N2) @ l
  in
    if i < i1 then let
      prval (pf1, fpf2) = __cast (pf) where {
        extern prfun __cast (pf: darr N @ l): (V2, V2 -<lin,prf> V1)
      }
      var sum: v2df = v2df_0_0
      val () = if flag = 0 then
        loop2_0 (pf1 | p_u, sum, i, 0) else loop2_1 (pf1 | p_u, sum, i, 0)
      // end of [if]
      prval () = pf := fpf2 (pf1)
      val () = tmp.[i] := v2df_get_fst(sum) + v2df_get_snd(sum)
      val () = if N > N2+N2 then tmp.[i] += eval_A(i,N-1) * p_u->[N-1]
    in
      loop1 (pf | i+1, i1, p_u, tmp)
    end // end of [if]
  end // end of [loop1]
  fun loop1_ {i,i1:nat| i <= i1; i1 <= N} {l,l_tmp:addr}
    (i: int i, i1: int i1, p_u: ptr l, p_tmp: ptr l_tmp):<cloref1> void = let
    extern prfun __vintr {v:view} (): v
    extern prfun __velim {v:view} (pf: v): void
    prval pf = __vintr {darr N @ l} ()
    prval pf_tmp = __vintr {darr N @ l_tmp} ()
    val () = loop1 (pf | i, i1, p_u, !p_tmp)
    prval () = __velim (pf) and () = __velim (pf_tmp)
  in
    // nothing
  end // end of [loop1_]
//
  val nworker = workshop_get_nworker (ws)
  val () = assert_errmsg (nworker > 0, #LOCATION)
  val INC = (N+nworker-1)/nworker/64
  val INC = max (1, (int1_of_int)INC)
  val () = assert_errmsg (INC > 0, #LOCATION)
  fun split {lws:agz} {i:nat | i <= N} {l,l_tmp:addr}
    (ws: !WSptr lws, i: int i, p_u: ptr l, p_tmp: ptr l_tmp):<cloref1> void =
    if i < N then let
      val i1 = min (i + INC, N)
      val f = lam (): void =<lincloptr1> loop1_ (i, i1, p_u, p_tmp)
      val () = workshop_insert_work (ws, f)
    in
      split (ws, i1, p_u, p_tmp)
    end // end of [if]
  // end of [split]
  val () = split (ws, 0, &u, &tmp)
  val () = workshop_wait_blocked_all (ws)
in
  // nothing
end // end of [eval_A_times_u]

(* ****** ****** *)

fn eval_AtA_times_u {lws:agz} {N:nat} (
  ws: !WSptr lws, N: int N, u: &darr N, v: &darr N, tmp: &darr N
) : void = () where {
  val () = eval_A_times_u (ws, 0, N, u, tmp); val () = eval_A_times_u (ws, 1, N, tmp, v)
} // end of [eval_AtA_times_u]

(* ****** ****** *)

staload "libc/SATS/sched.sats"
staload TYPES = "libc/sys/SATS/types.sats"
macdef pid_t = $TYPES.pid_of_int

extern fun ncore_get (): int
implement ncore_get () = let
  var cs: cpu_set0_t // uninitialized
  prval () = cpusetinit (cs) // not a real initialization
  stavar nset: int
  val nset = cpusetsize_get (cs)
  val () = assert_errmsg (nset >= 2, #LOCATION)
  val err = sched_getaffinity ((pid_t)0, nset, cs)
  var count: Nat = 0
  var i: natLte 16 // uninitialized
  val () = for* (cs: cpu_set_t nset) =>
    (i := 0; i < 16; i := i + 1)
    if (CPU_ISSET (i, cs) > 0) then count := count + 1
  // end of [val]
in
  count
end // end of [ncore_get]

(* ****** ****** *)

#define QSZ 1024

(* ****** ****** *)

implement main (argc, argv) = let
  val () = assert_errmsg
    (argc >= 2, "Exit: wrong command format!\n")
  val [N:int] N = int1_of_string argv.[1]
  val () = assert_errmsg (
    N >= 0, "The input integer needs to be a natural number.\n"
  )
//
  val NCORE = ncore_get ()
  // val () = (print "NCORE = "; print NCORE; print_newline ())
//
  val nworker =
    (if (argc >= 3) then int_of argv.[2] else NCORE): int
  val nworker = int1_of_int (nworker)
  val () = assert_errmsg (nworker > 0, #LOCATION)  
//
  val ws = workshop_make<work> (QSZ, fwork)
  val _err = workshop_add_nworker (ws, nworker)
  val () = assert_errmsg (_err = 0, #LOCATION)
//
  val (pf_u | p_u) = darr_make (N, 1.0)
  val (pf_v | p_v) = darr_make (N, 0.0)
  val (pf_tmp | p_tmp) = darr_make (N, 0.0)
//  
  #define TIMES 10
  var i: Nat // uninitialized
  val () = for
    (i := 0; i < TIMES; i := i+1) let
    val () = eval_AtA_times_u (ws, N, !p_u, !p_v, !p_tmp)
    val () = eval_AtA_times_u (ws, N, !p_v, !p_u, !p_tmp)
  in (*nothing*) end
//
  var vBv: double = 0.0 and vv: double = 0.0
  val () = for (i := 0; i < N; i := i+1) let
    val ui = p_u->[i] and vi = p_v->[i] in vBv += ui*vi; vv += vi*vi
  end // end of [val]
//
  // val () = printf ("vBv = %f and vv = %f\n", @(vBv, vv))
  val () = darr_free (pf_u | p_u)
  val () = darr_free (pf_v | p_v)
  val () = darr_free (pf_tmp | p_tmp)
//
  var i: Nat = 0
  val nworker = workshop_get_nworker (ws)
  val () = while (i < nworker) let
    val _quit = $extval (work, "(void*)0")
    val () = workshop_insert_work (ws, _quit) in i := i + 1
  end // end of [val]
  val () = workshop_wait_quit_all (ws)
  val () = workshop_free_vt_exn (ws)
//
in
  printf("%0.9f\n", @($M.sqrt (vBv/vv)))
end // end of [main]

(* ****** ****** *)

(* end of [spectral-norm3.dats] *)
