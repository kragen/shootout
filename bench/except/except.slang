% Stricly speaking, slang does not have exceptions.  It uses error blocks.
variable HI = 0, LO = 0;
variable  Hi_exception = 1;
variable  Lo_exception = 2;
variable Exception;

()=fclose (stderr);
_traceback=0;
define throw (e)
{
   Exception = e;
   error ("");
}
 
define blowup (n) 
{
   if (n & 1) 
     throw (Lo_exception);

   throw (Hi_exception);
}

define lo_function (n)
{
   ERROR_BLOCK
     {
	if (Exception == Lo_exception)
	  {
	     LO++;
	     _clear_error ();
	  }
     }
   blowup(n);
}

define hi_function (n)
{
   ERROR_BLOCK
     {
	if (Exception == Hi_exception)
	  {
	     HI++;
	     _clear_error ();
	  }
     }
   lo_function(n);
}

define some_function (n)
{
   hi_function(n);
}

define main ()
{
   variable N = 1;
   if (__argc == 2) N = integer (__argv[1]);

   while (N) 
     {
	some_function(N);
	N--;
     }
    fprintf (stdout, "Exceptions: HI=%d / LO=%d\n", HI, LO);
}
main ();
