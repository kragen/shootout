# $Id: heapsort.gawk,v 1.1 2004-05-19 18:10:08 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

function gen_random(n) { return( (n * (LAST = (LAST * IA + IC) % IM)) / IM ); }

function heapsort (n, ra) {
    l = int(0.5+n/2) + 1
    ir = n;
    for (;;) {
        if (l > 1) {
            rra = ra[--l];
        } else {
            rra = ra[ir];
            ra[ir] = ra[1];
            if (--ir == 1) {
                ra[1] = rra;
                return;
            }
        }
        i = l;
        j = l * 2;
        while (j <= ir) {
            if (j < ir && ra[j] < ra[j+1]) { ++j; }
            if (rra < ra[j]) {
                ra[i] = ra[j];
                j += (i = j);
            } else {
                j = ir + 1;
            }
        }
        ra[i] = rra;
    }
}

BEGIN {
    IM = 139968;
    IA = 3877;
    IC = 29573;
    LAST = 42;

    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    ary[0] = 0;
    for (i=1; i<=n; i++) {
	ary[i] = gen_random(1.0);
    }

    heapsort(n, ary);

    printf("%.10f\n", ary[n]);

    exit;
}
