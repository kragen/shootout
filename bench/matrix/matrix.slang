variable size = 30;

define mkmatrix(rows, cols)
{
   variable mx = [1:rows*cols];
   reshape (mx, [rows, cols]);
   return mx;
}

define main()
{
   variable iter = 1;
   if (__argc > 1) iter = integer (__argv[1]);
   variable m1 = mkmatrix(size, size);
   variable m2 = mkmatrix(size, size);
   
   loop (iter)
     variable mm = m1 # m2;

   fprintf (stdout, "%.10g %.10g %.10g %.10g\n", mm[0,0], mm[2,3], mm[3,2], mm[4,4]);
}

main ();
