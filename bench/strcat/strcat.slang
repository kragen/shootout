define main_slow()
{
   variable n = integer (__argv[1]);
   variable str = typecast ("", BString_Type);
   variable hello = typecast ("hello\n", BString_Type);
   loop (n)
     str += hello;
   fprintf (stdout, "%S\n", strlen (str));
}

variable Buffer = struct
{
   size, data, len
};

define new_buffer (s)
{
   variable b = @Buffer;
   s = typecast (s, BString_Type);
   b.data = bstring_to_array (s);
   b.len = bstrlen (s);
   b.size = b.len;
   return b;
}

define append (b, b1)
{
   variable len = b.len;
   variable len1 = b1.len;
   variable new_len = len + len1;
   variable data = b.data;
   variable i;

   if (b.size < new_len)
     {
	b.size = new_len * 2;
	variable new_data = UChar_Type[2*new_len];
	if (len)
	  {
	     i = [0:len-1];
	     new_data[i] = data[i];
	  }

	data = new_data;
	b.data = data;
     }
   
   i = [len:new_len-1];
   data[i] = b1.data[[0:len1-1]];
   b.len = new_len;
}


define main_faster ()
{
   variable n;
   if (__argc > 1) n = integer (__argv[1]); else n = 1;

   variable hello = new_buffer ("hello\n");
   variable str = new_buffer ("");
   loop (n)
     append (str, hello);
   fprintf (stdout, "%S\n", str.len);
}

main_faster ();
