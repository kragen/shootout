% -*- mode: slang -*-
% $Id: hash2.slang,v 1.2 2004-11-23 08:08:43 bfulgham Exp $
% http://shootout.alioth.debian.org/
%
% Provided by John E. Davis
%

define main ()
{
   variable n = 1;
   if (__argc > 1) n = integer(__argv[1]);
   variable hash1 = Assoc_Type[Int_Type];
   _for (1, 10000, 1)
     {
	variable i = ();
	hash1[strcat ("foo_", string(i))] = i;
     }

   variable hash2 = Assoc_Type[Int_Type, 0];
   loop (n)
     {
	foreach (hash1) using ("keys", "values")
	  {
	     variable k, v;
	     (k,v) = ();
	     hash2[k] += v;
	  }
     }

   fprintf (stdout, "%u %u %u %u\n",
	     hash1["foo_1"], hash1["foo_9999"], 
	     hash2["foo_1"], hash2["foo_9999"]);
}

main();


