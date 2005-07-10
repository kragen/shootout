#!/usr/bin/env slsh
% The Computer Language Shootout Benchmarks
% http://shootout.alioth.debian.org/
% 
% contributed by John E. Davis

define slsh_main ()
{
   variable w = 100;
   if (__argc == 2) w = integer (__argv[1]);

   variable h = w, iter = 50;
   variable byte_acc = 0, bit_num = 0;
   variable limit = 2.0;

   () = fprintf (stdout, "P4\n%d %d\n", w, h);

   _for (0, h-1, 1)
     {
	variable y = ();
	variable x = [0:w-1];
	variable z = Complex_Type[w];
	variable c = ((2.0*x)/w + ((2i*y)/h - 1i - 1.5));
	variable i;
	loop (iter)
	  {
	     z = z*z + c;
	     i = where (abs(z) < limit);
	     z = z[i]; c = c[i]; x = x[i];
	  }
	variable bytes = UChar_Type[(w-1)/8+1];
	variable bits = (1 shl (7 - (x mod 8)));
	x /= 8;
	_for (0, length (x)-1, 1)
	  {
	     i = ();
	     bytes[x[i]] |= bits[i];
	  }
	() = fwrite (bytes, stdout);
     }
}
