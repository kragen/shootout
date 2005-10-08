define  main()
{
   variable count = 0;
   foreach (stdin) using ("line")
     count += atoi ();
   fprintf (stdout, "%d\n", count);
}
main();
