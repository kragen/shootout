define main()
{
   variable count = Assoc_Type[Int_Type, 0];
   foreach (stdin) using ("line")
     {
	variable line = ();
	foreach (strtok (strlow (line), "^a-z"))
	  {
	     variable word = ();
	     count [word] += 1;
	  }
     }
   
   variable words = assoc_get_keys (count);
   variable freqs = assoc_get_values (count);

   variable i = array_sort (array_map (String_Type, &sprintf, "%12d", freqs)
			    + words);
   i = i[[-1:0:-1]];
   
   foreach (i)
     {
	i = ();
	()=fprintf (stdout, "%7d %s\n", freqs[i], words[i]);
     }
}

main();
