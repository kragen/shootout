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
	     !if (assoc_key_exists (hash2, k))
	       continue;
	     hash2[k] += v;
	  }
     }

   fprintf (stdout, "%u %u %u %u\n",
	     hash1["foo_1"], hash1["foo_9999"], 
	     hash2["foo_1"], hash2["foo_9999"]);
}

main();


