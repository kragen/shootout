variable IM = 139968;
variable IA =   3877;
variable IC =  29573;

variable LAST = 42;
define gen_random(max)
{
   LAST = (LAST * IA + IC) mod IM;
   return (max * LAST) / IM;
}

define heapsort(n, ra)
{
   variable rra = 0, i = 0, j = 0;
   variable l = (n shr 1) + 1;
   variable ir = n;

   forever
     {
        if (l > 1)
	  {
	     l--;
	     rra = ra[l];
	  }
        else
	  {
	     rra = ra[ir];
	     ra[ir] = ra[1];
	     if (ir == 1)
	       {
		  ra[1] = rra;
		  return;
	       }
	     ir--;
	  }
        i = l;
        j = l*2;
	forever 
	  {
	     if (j > ir)
	       break;

	     variable raj = ra[j];
	     if (j < ir)
	       {
		  variable raj1 = ra[j+1];
		  if (raj < raj1)
		    {
		       j++;
		       raj=raj1;
		    }
	       }
	     if (rra >= raj)
	       {
		  j = ir + 1;
		  break;
	       }

	     ra[i] = raj;
	     i = j;
	     j *= 2;
	  }

        ra[i] = rra;
     }
}


define main()
{
   variable N = 1;
   if (__argc > 1) N = integer (__argv[1]);
   if (N < 1)
     N = 1;
   variable ary = array_map (Double_Type, &gen_random, [0:N]*0+1.0);
   heapsort(N, ary);

   fprintf (stdout, "%.10f\n", ary[N]);
}


main();
