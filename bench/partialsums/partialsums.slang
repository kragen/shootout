#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
%
% contributed by John E. Davis

define slsh_main ()
{
   variable n = 25000; if (__argc > 1) n = integer (__argv[1]);
   variable s0=1.0,s1=0.0,s2=0.0,s3=0.0,s4=0.0,s5=0.0,s6=0.0,s7=0.0,s8=0.0;
   variable k = 1, dn = 4096;
   variable sgn = 1[Int_Type[dn]]; sgn[[1::2]] = -1;
   while (k <= n)
     {
	variable k1 = k + dn;
	if (k1 > n) 
	  {
	     k1 = n + 1;
	     sgn = sgn[[:n-k]];
	  }
	variable kd = [k:k1-1]*1.0, kd2 = kd*kd, kd3 = kd*kd2;
	s0 += sum ((2.0/3.0)^kd);
	s1 += sum (1.0/sqrt(kd));
	s2 += sum (1.0/(kd2+kd));
	variable sk = sin(kd);
	s3 += sum (1.0/(kd3*sk*sk));
	variable ck = cos(kd);
	s4 += sum (1.0/(kd3*ck*ck));
	s5 += sum (1.0/kd);
	s6 += sum (1.0/kd2);
	s7 += sum (sgn/kd);
	s8 += sum (sgn/(2.0*__tmp(kd)-1.0));
	k = k1;
     }
   () = printf("%.9f\t(2/3)^k\n", s0);
   () = printf("%.9f\tk^-0.5\n", s1);
   () = printf("%.9f\t1/k(k+1)\n", s2);
   () = printf("%.9f\tFlint Hills\n", s3);
   () = printf("%.9f\tCookson Hills\n", s4);
   () = printf("%.9f\tHarmonic\n", s5);
   () = printf("%.9f\tRiemann Zeta\n", s6);
   () = printf("%.9f\tAlternating Harmonic\n", s7);
   () = printf("%.9f\tGregory\n", s8);
}

