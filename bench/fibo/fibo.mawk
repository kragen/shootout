# $Id: fibo.mawk,v 1.2 2005-03-19 00:32:56 igouy-guest Exp $
# http://www.bagley.org/~doug/shootout/

function fib(n) {
    if (n < 2) return(n);
    return(fib(n-2) + fib(n-1));
}

BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    printf("%d\n", fib(n));
    exit;
}
