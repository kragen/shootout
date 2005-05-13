# $Id: ackermann.gawk,v 1.2 2005-05-13 16:24:17 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/ 

function ack(m, n) {
    if (m == 0) return( n + 1 );
    if (n == 0) return( ack(m - 1, 1) );
    return( ack(m - 1, ack(m, (n - 1))) );
}

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    printf("Ack(3,%d): %d\n", n, ack(3, n));
    exit;
}
