define main ()
{
   variable n = 1;
   if (__argc > 1) n = integer (__argv[1]);
   variable x = [1:n];
   variable y = Int_Type[n];

   loop (1000)
     y += x;

   fprintf(stdout, "%u %u\n", y[0], y[-1], 2);
}
main ();
