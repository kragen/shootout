# $Id: hash2.mawk,v 1.1 2004-05-19 18:10:02 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];

    for (i=0; i<10000; i++)
	hash1[sprintf("foo_%d", i)] = i
    for (i=0; i<n; i++)
	for (k in hash1)
	    hash2[k] += hash1[k]
    print hash1["foo_1"], hash1["foo_9999"], hash2["foo_1"], hash2["foo_9999"]
}
