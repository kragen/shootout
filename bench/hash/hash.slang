define main ()
{
   variable n=1;
   if (__argc > 1) n = integer (__argv[1]);
   variable X = Assoc_Type[Int_Type];
   _for (1, n, 1)
     {
	variable i = ();
	X[sprintf("%x", i)] = i;
     }
   variable c = 0;
   _for (n, 1, -1)
     {
	i = string ();
	if (assoc_key_exists (X, i))
	  c++;
     }
   fprintf (stdout, "%d\n", c);
}

main();
