define ack (); 
define ack (M, N)
{
   !if (M)
     return( N + 1 );
   !if (N)
     return ( ack(M-1, 1) );
   return( ack(M-1, ack(M, N-1)) );
}


define main()
{
   variable NUM = 1;
   if (__argc > 1) NUM = integer (__argv[1]);
   fprintf (stdout, "Ack(3,%d): %d\n", (NUM, ack(3, NUM)));
}

main()
