% takfp.slang
%
% Contributed by John E. Davis
%

static define tak ();
static define tak (x, y, z)
{
	if (y >= x) return z;
	return tak(tak(x-1,y,z), tak(y-1,z,x), tak(z-1,x,y));
}

public define slsh_main ()
{
	variable n = 1;
	if (__argc > 1) n = integer (__argv[1]);

	() = fprintf(stdout, "%.1f\n", tak(n*3.0, n*2.0, n*1.0));
	return 0;
}

% vim: ts=4 ft=slang
