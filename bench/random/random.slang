variable IM = 139968;
variable IA = 3877;
variable IC = 29573;
variable LAST = 42;

define gen_random(max)
{
    LAST = (LAST * IA + IC) mod IM;
    (max * LAST) / IM;
}

define main()
{
   variable N=1;
   if (__argc > 1) N = integer (__argv[1]); 
   if (N < 1)
     N = 1;

   loop (N-1)
     () = gen_random (100.0);

   fprintf (stdout, "%.9f\n", gen_random(100.0));
}

main();
