define  main()
{
   variable count = 0;
   foreach (stdin) using ("line")
     count += integer ();
   fprintf (stdout, "%d\n", count);
}
main();
