define main()
{
   variable x = 0;
   variable iter = 1;
   if (__argc > 1) iter = integer (__argv[1]);
   
   loop (iter)
     loop (iter)
       loop (iter)
	 loop (iter)
	   loop (iter)
	     loop (iter)
	       x += 1;
   
   fprintf (stdout, "%d\n", x);
}
main();
