define main()
{
   variable NUM;
   if (__argc > 1) NUM = integer (__argv[1]); else NUM = 1;
   variable flags = Int_Type[8192 + 1];
   loop (NUM)
     {
        flags[*] = 1;
        variable count = 0;
	_for (2, 8192, 1)
	  {
	     variable i = ();
	     if (flags[i])
	       {
		  flags[[i+i:8192:i]] = 0;
		  count++;
	       }
	  }
     }
   
   fprintf (stdout, "Count: %d\n", count);
}
main();
