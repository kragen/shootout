/* The Great Computer Language Shootout
   http://shootout.alioth.debian.org/

   http://www.bagley.org/~doug/shootout/

   converted to D by Dave Fladebo
   compile: dmd -O -inline -release fibo.d
*/

import std.stdio, std.string;

void main(char[][] args)
{
    int n = args.length > 1 ? atoi(args[1]) : 1;

    writefln(fib(n));
}

uint fib(uint n)
{
    if(n < 2)
    {
        return(n);
    }
    else
    {
        return(fib(n-2) + fib(n-1));
    }
}
