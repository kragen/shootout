#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: ackermann.pike-2.pike,v 1.1 2004-11-10 06:09:46 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Marcus Comstedt

// this version uses memoization

mapping _ack = ([]);
int ack( int m, int n )
{
    if(m==0) return n+1;
    [int i, int a] = _ack[m]||({-1,1});
    for(i++; i<=n; i++)
	a = ack(m-1, a);
    _ack[m] = ({n,a});
    return a;
}

void main( int argc, array(string) argv )
{
    int n = (int)argv[-1];
    if( n < 1 )
	n = 1;
    write( "Ack(3,%d): %d\n", n, ack( 3, n ) );
}
