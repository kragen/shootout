# $Id: nestedloop.gawk,v 1.1 2004-05-19 18:10:56 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];

    for (a=0; a<n; a++)
	for (b=0; b<n; b++)
	    for (c=0; c<n; c++)
		for (d=0; d<n; d++)
		    for (e=0; e<n; e++)
			for (f=0; f<n; f++)
			    x += 1
    print x
}
