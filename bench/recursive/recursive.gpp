// The Computer Language Shootout
// http://shootout.alioth.debian.org/
// by bearophile, Jan 24 2006
// converted to C++ by Greg Buchholz
// Compile with: -O3 -fomit-frame-pointer

#include<cstdio>
#include<cstdlib>

template<class N> N Ack(N x, N y) {
   return (x == 0) ? y+1 : ((y == 0) ? Ack(x-1, 1) : Ack(x-1, Ack(x, y-1)));
}

template<class N> N Fib(N n) { return (n < 2) ? 1 : Fib(n-2) + Fib(n-1); }

template<class N> N Tak(N x, N y, N z) { 
    return (y < x) ? Tak(Tak(x-1, y, z), Tak(y-1, z, x), Tak(z-1, x, y)) : z;
}

int main(int argc, char **argv) 
{
    int n = atoi(argv[1]) - 1;
    printf("Ack(3,%d): %d\n", n+1, Ack(3, n+1));
    printf("Fib(%.1f): %.1f\n", 28.0+n, Fib(28.0+n));
    printf("Tak(%d,%d,%d): %d\n", 3*n, 2*n, n, Tak(3*n, 2*n, n));
    printf("Fib(3): %d\n", Fib(3));
    printf("Tak(3.0,2.0,1.0): %.1f\n", Tak(3.0, 2.0, 1.0));
    return 0;
}

