(* Interpreting uJava, a class-based OO language like Java, but no
   static fields or methods, no method overloading, no interfaces, no
   packages.  sestoft@dina.kvl.dk * 1999-04-17, 2001-04-18 *)

app load ["Absyn", "Env", "Sto"];

open Absyn Env Sto;

(* ------------------------------------------------------------ *)

(* Semantic values used in the interpreter *)

type location = int                     (* locations in the store sto *)
type href = int                         (* locations in the heap h    *)

datatype value =
    Int of int
  | Null
  | Ref of href

and hvalue = 
    Object of object
  | String of string

and method = Method of
    { args : (typ * string) list,
      res  : typ option,
      body : stmt }

and class = Class of
    { name    : string, 
      super   : string option, 
      fields  : (typ * string) list,
      methods : (string, method) env } 

withtype object = 
    { class  : string, 
      fields : (string, location) env }

type env = (string, location) Env.env 

type sto = value Sto.sto                (* indexed by int locations  *)

type heap = hvalue Sto.sto              (* indexed by int references *)

type prog = (string, class) Env.env

(* ------------------------------------------------------------ *)

exception Type of string                (* evaluation type failure *)

exception NullPointer                   (* evaluation null deref   *)

(* ------------------------------------------------------------ *)

local 
    val nextloc = ref 0
in
    fun newloc () = !nextloc before nextloc := !nextloc + 1
end

fun bindvar (env : env) (sto : sto) (x : string) (v : value) : env * sto =
    let val loc = newloc ()
    in (bind1 env (x, loc), setsto sto loc v) end;

fun allocvar env sto (typ, x) : env * sto =
    bindvar env sto x (case typ of 
                           TypI   => Int 0
                         | TypO _ => Null)

fun allocvars sto (txs : (typ * string) list) : env * sto =
    let fun loop []           (env0, sto0) = (env0, sto0)
          | loop (tx1 :: txr) (env0, sto0) = 
            loop txr (allocvar env0 sto0 tx1)
    in loop txs (Env.empty, sto) end;

fun bindpars sto (txs : (typ * string) list) (vs : value list) : env * sto =
    let fun loop []              []         (env0, sto0) = (env0, sto0)
          | loop ((_,x1) :: txr) (v1 :: vr) (env0, sto0) = 
            loop txr vr (bindvar env0 sto0 x1 v1)
          | loop _ _ _ = raise Type "argument length mismatch"
    in loop txs vs (Env.empty, sto) end;

fun getobj (h : heap) (obj : value) : object =
    case obj of 
        Ref loc => 
            (case getsto h loc of
                 Object object => object 
               | _ => raise Type "attempt to use string as object")
      | Null  => raise NullPointer
      | Int i => raise Type "attempt to use integer as reference";
    
fun getobjenv (h : heap) (obj : value) : env = 
    #fields (getobj h obj)

fun getfieldloc h obj fld : location = 
    lookup (getobjenv h obj) fld

fun setfield sto h obj fld v : sto = 
    setsto sto (getfieldloc h obj fld) v

fun lookupmethod (prog : prog) h (obj : value) mname : method =
    let fun search (Class { super = NONE, methods, ... }) = 
            (lookup methods mname
             handle Subscript => raise Fail ("No such method: " ^ mname))
          | search (Class { super = SOME super, methods, ... }) =
            (lookup methods mname
             handle Subscript => search (lookup prog super))
        val { class, ... } = getobj h obj
    in search (lookup prog class) end;

(* ------------------------------------------------------------ *)

exception ReturnNONE of sto * heap

exception ReturnSOME of value * sto * heap

(* Decide whether c1 is a subclass of c2 *)

fun subclass prog c1 c2 =
    c1 = c2 orelse 
    case lookup prog c1 of 
        Class { super = SOME cls, ... } => subclass prog cls c2
      | _ => false;

(* Allocate a new string in the heap *)

fun newstring sto h s : value * sto * heap =
    let val strref = newloc ()
        val h1 = setsto h strref (String s)
    in (Ref strref, sto, h1) end

(* Allocate a new object in the heap *)

fun newobj prog sto h cname : value * sto * heap =
    let val Class { fields, ... } = lookup prog cname
        val (env1, sto1) = allocvars sto fields
        val objref = newloc ()
        val h1 = setsto h objref (Object { fields = env1, class = cname })
    in (Ref objref, sto1, h1) end

(* Create string from value *)

fun tostring h (Int i)   = Int.toString i
  | tostring h Null      = "null"
  | tostring h (Ref loc) = 
    case getsto h loc of
        String s              => s
      | Object { class, ... } => class ^ "@" ^ Int.fmt StringCvt.HEX loc;

(* Create a truth value from a value *)

fun valistrue (Int 0) = false
  | valistrue (Int _) = true
  | valistrue _       = raise Type "attempt to use reference as truth value";


(* ------------------------------------------------------------ *)
    
(* Execute statement, producing new store and heap *)

fun exec stmt prog (env : env) (sto : sto) (h : heap) : sto * heap = 
    case stmt of
        SetLocal(x, e) => 
            let val (v, sto1, h1) = eval e prog env sto h
            in (setsto sto1 (lookup env x) v, h1) end
      | SetField(eobj, fld, e) => 
            let val (obj, sto1, h1) = eval eobj prog env sto  h
                val (v,   sto2, h2) = eval e    prog env sto1 h1
            in (setfield sto2 h2 obj fld v, h2) end
      | If(e, stmt1, stmt2) => 
        let val (v, sto1, h1) = eval e prog env sto h 
        in 
            if valistrue v then 
                exec stmt1 prog env sto1 h1 
            else 
                exec stmt2 prog env sto1 h1 
        end
      | While(e, body) =>
        let fun loop (sto0, h0) = 
                let val (v, sto1, h1) = eval e prog env sto0 h0 
                in 
                    if valistrue v then 
                        loop (exec body prog env sto1 h1)
                    else 
                        (sto1, h1)
                end
        in loop (sto, h) end
      | Expr e => 
        let val (v, sto1, h1) = eval e prog env sto h
        in (sto1, h1) end
      | Block stmts => 
        let fun loop []       env sto h = (sto, h)
              | loop (s1::sr) env sto h = 
                let val (env1, (sto1, h1)) = stmtordec s1 prog env sto h 
                in loop sr env1 sto1 h1 end
        in loop stmts env sto h end  
      | Return NONE     => 
        raise ReturnNONE (sto, h) 
      | Return (SOME e) => 
        raise ReturnSOME (eval e prog env sto h)

and stmtordec (Stmt stmt) prog env sto h = 
    (env, exec stmt prog env sto h)
  | stmtordec (Dec xt)    prog env sto h = 
    let val (env1, sto1) = allocvar env sto xt
    in (env1, (sto1, h)) end

and eval e prog (env : env) (sto : sto) (h : heap) : value * sto * heap = 
    case e of
        GetLocal name       => 
            (getsto sto (lookup env name), sto, h)
      | GetField(eobj, fld) => 
            let val (obj, sto1, h1) = eval eobj prog env sto h
            in (getsto sto1 (getfieldloc h1 obj fld), sto1, h1) end
      | Cst cst =>
        (case cst of
             CstI i => (Int i, sto, h)
           | CstS s => newstring sto h s
           | CstN   => (Null, sto, h))
      | New cname => 
            newobj prog sto h cname
      | Prim1(ope, e1) => 
        let val (v1, sto1, h1) = eval e1 prog env sto h
        in 
            case (ope, v1) of
                ("!", Int i) => (Int(if i=0 then 1 else 0), sto1, h1)
              | _            => raise Fail ("no such primitive (1): " ^ ope)
             end
      | Prim2(ope, e1, e2) => 
        let val (v1, sto1, h1) = eval e1 prog env sto  h
            val (v2, sto2, h2) = eval e2 prog env sto1 h1
        in 
            case (ope, v1, v2) of
                ("+",  Int i1, Int i2) => (Int (i1+i2),     sto2, h2)
              | ("-",  Int i1, Int i2) => (Int (i1-i2),     sto2, h2)
              | ("*",  Int i1, Int i2) => (Int (i1*i2),     sto2, h2)
              | ("/",  Int i1, Int i2) => (Int (i1 div i2), sto2, h2)
              | ("%",  Int i1, Int i2) => (Int (i1 mod i2), sto2, h2)
              | ("==", _,      _     ) => (if v1 = v2 then Int 1 else Int 0, 
                                           sto2, h2)
              | ("!=", _,      _     ) => (if v1 = v2 then Int 0 else Int 1, 
                                           sto2, h2)
              | ("<",  Int i1, Int i2) => (if i1 < i2 then Int 1 else Int 0, 
                                           sto2, h2)
              | ("<=", Int i1, Int i2) => (if i1 <= i2 then Int 1 else Int 0, 
                                           sto2, h2)
              | (">",  Int i1, Int i2) => (if i1 > i2 then Int 1 else Int 0, 
                                           sto2, h2)
              | (">=", Int i1, Int i2) => (if i1 >= i2 then Int 1 else Int 0, 
                                           sto2, h2)
              | ("+",  Ref r1, Ref r2) => 
                    (case (getsto h2 r1, getsto h2 r2) of
                         (String s1, String s2) => newstring sto2 h2 (s1 ^ s2)
                       | _ => raise Fail "Prim2: + on illegal types")
              | _ => raise Fail ("no such primitive (2): " ^ ope)
        end
      | PrimC(ope, es) => 
        let val (vs, sto1, h1) = evals es prog env sto h
        in 
            case (ope, vs) of
                ("tostring", [v1]) => 
                    newstring sto1 h1 (tostring h1 v1)
              | ("print",    [v1]) => 
                    (print (tostring h1 v1); print "\n"; (v1, sto1, h1))
              | _ => raise Fail ("no such primitive (C): " ^ ope)
        end
      | Andalso(e1, e2) => 
        let val res as (v1, sto1, h1) = eval e1 prog env sto h
        in 
            if valistrue v1 then eval e2 prog env sto1 h1
            else res
        end
      | Orelse(e1, e2) => 
        let val res as (v1, sto1, h1) = eval e1 prog env sto h
        in 
            if valistrue v1 then res 
            else eval e2 prog env sto1 h1
        end
      | Call(eobj, mname, es) =>
        let val (obj, sto1, h1) = eval  eobj prog env sto  h
            val (vs,  sto2, h2) = evals es   prog env sto1 h1
            val (sto3, h3) = callmethod prog sto2 h2 obj mname vs
        in 
            (Null, sto3, h3)
        end
        handle ReturnSOME (v, sto, h) => (v, sto, h)
             | ReturnNONE (sto, h) => (Null, sto, h)

and evals []       prog env sto h = ([], sto, h)
  | evals (e1::er) prog env sto h = 
    let val (v1, sto1, h1) = eval  e1 prog env sto h 
        val (vr, stor, hr) = evals er prog env sto1 h1
    in (v1::vr, stor, hr) end

and callmethod prog sto h obj mname vals : sto * heap =
    let val Method { body, args, ... } = lookupmethod prog h obj mname
        val (menv1, sto1) = bindpars sto args vals
        val (menv2, sto2) = bindvar menv1 sto1 "this" obj
    in exec body prog menv2 sto2 h end;

(* ------------------------------------------------------------ *)

(* Transform a uJava program in abstract syntax into the
   representation required by the interpreter: *)

fun initialize (cdecs : classdec list) : prog =
    let (* Separate field declarations from method declarations *)
        fun fieldsmethods [] (flds, mths) = (flds, mths)
          | fieldsmethods (Fielddec(typ, name)::r) (flds,mths) =
            fieldsmethods r ((typ, name)::flds, mths)
          | fieldsmethods (Methoddec(res, name, args, body)::r) (flds,mths) =
            let val mth = Method{args=args, res=res, body=body}
            in fieldsmethods r (flds, bind1 mths (name, mth)) end
        fun class (Classdec(name, super, members)) = 
            let val (fields, methods) = fieldsmethods members ([], Env.empty)
            in 
                (name, 
                 Class {name=name, super=SOME super, 
                        fields=fields, methods=methods})
            end
        (* Class Object has one method: String toString() *)
        val object = 
            Class {name    = "Object", 
                   super   = NONE,
                   fields  = [], 
                   methods = Env.fromList
                       [("toString", 
                         Method{args = [],
                                res  = SOME(TypO "String"),
                                body =
                                Return(SOME (PrimC("tostring", 
                                                   [GetLocal "this"])))})]}
        val plainclasses = ("Object", object) :: List.map class cdecs
        val cenv0 = Env.fromList plainclasses

        (* Add all superclass fields to the field list (NB: this function 
           enters an infinite loop if the class hierarchy is cyclic): *)
        fun allfields NONE = []
          | allfields (SOME cname) = 
            let val Class {super, fields, ...} = lookup cenv0 cname
            in fields @ allfields super end
        fun completefields (_, Class {name, super, fields, methods}) =
            (name, Class {name    = name, 
                          super   = super, 
                          fields  = fields @ allfields super, 
                          methods = methods})
        val completedclasses = List.map completefields plainclasses
    in 
        Env.fromList completedclasses 
    end;

fun run (cdecs : classdec list) (vals : int list) = 
    let val prog = initialize cdecs
        val sto0 = Sto.empty () 
        val h0   = Sto.empty ()
        val (obj, sto1, h1) = newobj prog sto0 h0 "Main"
    in 
        callmethod prog sto1 h1 obj "main" (List.map Int vals)
    end;
