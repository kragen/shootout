# $Id: random.mawk,v 1.1 2004-05-19 18:11:16 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

function gen_random(max) { return( (max * (LAST = (LAST * IA + IC) % IM)) / IM ); }

BEGIN {
    IM = 139968;
    IA = 3877;
    IC = 29573;
    LAST = 42;

    n = ((ARGV[1] < 1) ? 1 : ARGV[1]) - 1;
    while (n--) {
	gen_random(100);
    }
    printf("%.9f\n", gen_random(100));
    exit;
}
