%!/usr/bin/slsh
%
% Contributed by John E. Davis
%
static define fannkuch (n)
{
	variable m = n-1;
	variable perm1 = [0:m];
	variable r = n;
	variable count = Int_Type[n];
	variable max_flipcounts = 0;
	variable maxperm;
	forever
	{
		count[[1:r-1]] = [2:r];
		r = 1;
		!if ((perm1[0] == 0) or (perm1[m] == m))
		{
			variable perm = @perm1;
			variable flipcounts = 0;
			forever 
			{
				variable k = perm[0];
				!if (k)
					break;
				perm[[0:k]] = perm[[k:0:-1]];
				flipcounts++;
			}
			if (flipcounts > max_flipcounts)
			{
				max_flipcounts = flipcounts;
				maxperm = @perm1;
			}
		}
		forever
		{
			if (r == n)
				return max_flipcounts;
			variable perm0 = perm1[0];
			perm1[[0:r-1]] = perm1[[1:r]];
			perm1[r] = perm0;
			variable cr = count[r]; cr--; count[r] = cr;
			if (cr > 0)
				break;
			r++;
		}
	}
}

static define main ()
{
	variable num = 1;
	if (__argc > 1) num = integer (__argv[1]);
	fprintf (stdout, "Pfannkuchen(%d) = %d\n", (num, fannkuch (num)));
}
main ();

% vim: ts=4 ft=slang
