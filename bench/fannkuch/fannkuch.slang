%!/usr/bin/slsh
%
% Contributed by John E. Davis
%
static define fannkuch (n)
{
	variable i, m = n-1;
	variable perm1 = [0:m];
	variable r = n;
	variable count = Int_Type[n];
	variable max_flipcounts = 0;
	variable maxperm;
	forever
	{
		while (r != 1)
		{
			count[r-1] = r;
			r--;
		}

		!if ((perm1[0] == 0) or (perm1[m] == m))
		{
			variable perm = @perm1;
			variable flipcounts = 0;
			forever 
			{
				variable k = perm[0];
				!if (k)
					break;
				_for (0, (k+1)/2 - 1, 1)
				{
					i=();
					(perm[i], perm[k-i]) = (perm[k-i], perm[i]);
				}
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
			_for (0,r-1,1)
			{
				i = ();
				perm1[i] = perm1[i+1];
			}
			
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
