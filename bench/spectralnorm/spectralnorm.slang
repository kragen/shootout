#!/usr/bin/env slsh
% The Great Computer Language Shootout
% http://shootout.alioth.debian.org/
%
% contributed by John E Davis

private define eval_A(i,j) { 1.0/((i+j)*(i+j+1)/2+i+1); }

private define eval_A_times_u (n, u, Au)
{
   variable j = [0:n-1];
   _for (0, n-1, 1)
     {
	variable i = ();
	Au[i] = sum (eval_A(i,j)*u);
     }
}

private define eval_At_times_u (n, u, Au)
{
   variable j = [0:n-1];
   _for (0, n-1, 1)
     {
	variable i = ();
	Au[i] = sum (eval_A (j, i)*u);
     }
}

private define eval_AtA_times_u (n, u, AtAu)
{
   variable v = Double_Type[n];
   eval_A_times_u (n,u,v); eval_At_times_u (n,v,AtAu);
}

define slsh_main ()
{
   variable n = 2000;
   if (__argc == 2) n = integer (__argv[1]);
   variable u = 1+Double_Type[n], v = Double_Type[n];
   loop (10)
     {
	eval_AtA_times_u(n,u,v);
	eval_AtA_times_u(n,v,u);
     }
   variable vBv = sum (u*v), vv = sum(v*v);
   () = fprintf (stdout, "%0.9f\n", sqrt(vBv/vv));
}
