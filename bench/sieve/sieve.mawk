# $Id: sieve.mawk,v 1.1 2004-05-19 18:12:27 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    while (n--) {
        count=0;
        for(i=2; i <= 8192; flags[i++]=1);
        for (i=2; i <= 8192; i++) {
	    if (flags[i]) {
		# remove all multiples of prime: i
		for (k=i+i; k <= 8192; k+=i) {
                    flags[k] = 0;
		}
		count++;
	    }
        }
    }
    printf("Count: %d\n", count);
    exit;
}
