module type SCALAR = sig
  type f
  val (++) : f -> f -> f
  val (--) : f -> f -> f
  val ( ** ) : f -> f -> f
  val (//) : f -> f -> f
  val mk : int -> f
  val mf : float -> f
  val pr : f -> string
end;;

module FL64 : SCALAR = struct
  type f = float
  let (++) x y = x +. y
  let (--) x y = x -. y
  let ( ** ) x y = x *. y
  let (//) x y = x /. y
  let mk = float
  let mf x = x
  let pr = Printf.sprintf "%.14e"
end;;

module FL : SCALAR = struct
  type f = float
  let mf x =
    if x=0.0 then 0.0 else
    let k = truncate (log (abs_float x)) in
    let fk = float k in
    (floor (x*.exp(6.0-.fk)+.0.5))*.exp(fk-.6.0)
  let mk x = mf (float x)
  let (++) x y = mf (x +. y)
  let (--) x y = mf (x -. y)
  let ( ** ) x y = mf (x *. y)
  let (//) x y = mf (x /. y)
  let pr = Printf.sprintf "%.14e"
end;;

module C =
  functor (F : SCALAR) -> struct
    type f = {x:F.f;y:F.f}
    let mk a = {x=F.mk a;y=F.mk 0}
    let mf a = {x=F.mf a;y=F.mk 0}
    let mc a b = {x=a;y=b}
    let (++) a b = {x=F.(++) a.x b.x;y=F.(++) a.y b.y}
    let (--) a b = {x=F.(--) a.x b.x;y=F.(--) a.y b.y}
    let ( ** ) a b =
      { x=F.(--) (F.( ** ) a.x b.x) (F.( ** ) a.y b.y);
	y=F.(++) (F.( ** ) a.x b.y) (F.( ** ) a.y b.x) }
    let (//) a b =
      let mag = F.(++) (F.( ** ) b.x b.x) (F.( ** ) b.y b.y) in
      { x=F.(//) (F.(++) (F.( ** ) a.x b.x) (F.( ** ) a.y b.y)) mag ;
	y=F.(//) (F.(--) (F.( ** ) a.y b.x) (F.( ** ) a.x b.y)) mag }
    let pr a = (F.pr a.x) ^ " " ^ (F.pr a.y)
end;;

module Functions =
  functor (F : SCALAR) -> struct
    open F
    let sqr x = x ** x
    let rec pwr x k =
      if k = 0 then F.mk 1 else
      if (k mod 2) = 0 then sqr (pwr x (k/2)) else x ** (pwr x (k-1))
    let rat x =
      (((((x**(mk 2)++(pwr x 2)**(mk 3))++(pwr x 6)**(mk 7))++(pwr x 11)**(mk 5))++(mk 1))//
       (((x**(mk 5)--(pwr x 3)**(mk 6))--(pwr x 7)**(mk 3))++(mk 2)))

    module AD = struct
      type f = { x : F.f; dx : F.f }
      let mk y = { x=mk y; dx=mk 0 }
      let vr y dy = { x=y; dx=dy }
      let (++) a b = { x=F.(++) a.x b.x;dx=F.(++) a.dx b.dx }
      let (--) a b = { x=F.(--) a.x b.x;dx=F.(--) a.dx b.dx }
      let ( ** ) a b = { x=F.( ** ) a.x b.x;
			 dx=F.(++) (F.( ** ) a.dx b.x) (F.( ** ) a.x b.dx) }
      let ( // ) (a:f) (b:f) =
	{ x=F.(//) a.x b.x ;
	  dx=(F.(//) (F.(--) (F.( ** ) a.dx b.x) (F.( ** ) a.x b.dx))
	             (F.( ** ) b.x b.x) ) }
      let pr y = (pr y.x) ^ " " ^ (pr y.dx)
      let mf y = { x=F.mf y; dx=F.mk 0 }

      let newton x0 n g =
	let x = ref x0 in
	for i = 1 to n do
	  let v=g (vr !x (F.mk 1)) in
	  x:=F.(--) !x (F.(//) v.x v.dx)
	done; !x
      let trapezoid_method_rooter g y0 t0 t1 =
	let z0=F.mk 0 in
	let vt0=vr t0 z0 and
	    vt1=vr t1 z0 and
	    vy0=vr y0 z0 in
	let g0 = g vt0 vy0 in
	let foo y1 = ((g vt1 y1)++g0)**(vt1--vt0)//(mk 2)++vy0--y1 in
	foo
      let trapezoid_method t0 dt y0 g numsteps =
	let y = ref y0 and
	    t = ref t0 in
	for i = 1 to numsteps do
	  y:=newton !y 10 (trapezoid_method_rooter g !y !t (F.(++) !t dt));
	  t:=F.(++) !t dt;
	done; !y
    end;;
  end;;

module Integrate_functions =
  functor (F : SCALAR) -> struct
    module Funs = Functions(F)
    module AD = Funs.AD
    module ADFuns = Functions(AD)
    open F
    let sqrintegrand t y = ADFuns.sqr y
    let ratintegrand t y = AD.(--) (ADFuns.rat y) t
    let integrate_functions x0 n =
      let dt = (mk 1) // (mk n) in
      print_string ("i1 "^(pr (AD.trapezoid_method (mk 1) dt x0 sqrintegrand n))^"\n");
      print_string ("i2 "^(pr (AD.trapezoid_method (mk 1) dt x0 ratintegrand n))^"\n")
  end;;

module Funs = Functions(FL64);;
module AD = Funs.AD;;
module ADFuns = Functions(AD);;
open FL64;;
let mysqrt x = AD.(--) (ADFuns.sqr x) (AD.mk 2);;
let _ = print_string ("rational_taylor_series: "^
		      (AD.pr (ADFuns.rat (AD.vr (mf 0.25) (mk 1))))^"\n");;
let _ = print_string ("newton-sqrt_2: "^
		      (pr (AD.newton (mk 1) 10 mysqrt))^"\n");;
let _ = print_string ("newton-rat: "^
		      (pr (AD.newton (mk (-1)) 6 ADFuns.rat))^"\n");;

let pfl64 = FL64.mf 0.02;;
let pfl = FL.mf 0.02;;
module I1 = Integrate_functions(FL64);;
let _ = I1.integrate_functions pfl64 200;;
module I2 = Integrate_functions(FL);;
let _ = I2.integrate_functions pfl 50;;
module CFL64=C(FL64);;
module CFL=C(FL);;
module I3 = Integrate_functions(CFL64);;
let _ = I3.integrate_functions (CFL64.mc pfl64 pfl64) 50;;
module I4 = Integrate_functions(CFL);;
let _ = I4.integrate_functions (CFL.mc pfl pfl) 50;;
