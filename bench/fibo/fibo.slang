define fib ();
define fib(n)
{
   if (n < 2)
     return 1;
   fib(n-2) + fib(n-1);
}
define main ()
{
   variable n = 1;
   if (__argc > 1) n = integer (__argv[1]);
   fprintf (stdout, "%d\n", fib(n));
}
main ();
