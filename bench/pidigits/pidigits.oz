% The Computer Language Benchmarks Game  
% http://shootout.alioth.debian.org/
%                                                                   
% Contributed by YANG Shouxun


functor
import
   System(showInfo printInfo) Application(exit getArgs)

define
   fun {Next Z}
      case Z of [Q R S T] then (3*Q + R) div (3*S + T)
      else raise invalidArg(Z) end
      end
   end

   fun {Safe Z N}
      case Z of [Q R S T] then N == ((4*Q + R) div (4*S + T))
      else raise invalidArg(Z) end
      end
   end

   fun {Comp Z1 Z2}
      case Z1#Z2
      of [Q1 R1 S1 T1]#[Q2 R2 S2 T2] then
	 [(Q1*Q2+R1*S2) (Q1*R2+R1*T2) (S1*Q2+T1*S2) (S1*R2+T1*T2)]
      else raise invalidArg(Z1#Z2) end
      end
   end

   fun {Prod Z N} {Comp [10 ~10*N 0 1] Z} end

   fun {Cons Z K} {Comp Z [K 4*K+2 0 2*K+1]} end

   proc {PrintNSpace N}
      proc {Aux _} {System.printInfo " "} end
   in {For 1 N 1 Aux} end

   proc {Digit K Z N Row Col}
      if N > 0 then Y in
	 Y = {Next Z}
	 if {Safe Z Y} then
	    if Col == 10 then
	       {System.printInfo "\t:"#(10+Row)#"\n"#Y}
	       {Digit K {Prod Z Y} N-1 10+Row 1}
	    else
	       {System.printInfo Y}
	       {Digit K {Prod Z Y} N-1 Row Col+1}
	    end
	 else
	    {Digit K+1 {Cons Z K} N Row Col}
	 end
      else
	 {PrintNSpace 10-Col}
	 {System.showInfo "\t:"#(Row+Col)}
      end
   end

   proc {Digits N} {Digit 1 [1 0 0 1] N 0 0} end

in
   {Digits {String.toInt {Application.getArgs plain}.1}}
   {Application.exit 0}
end
