#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: lists.pike,v 1.2 2004-11-23 08:08:43 bfulgham Exp $
// http://shootout.alioth.debian.org/
// from: Per Hedbor
// Optimized by Marcus Agehall

#define SIZE 10000

#define TB(X) werror( "%s: %.2f\n", X, gauge {
#define TE()  })

int test_lists()
{
    mixed Li1, Li2, Li3;
    // create a list of integers from 1 to SIZE.
    Li1 = indices(allocate(SIZE+1))[1..];
    // copy the list to Li2.
    Li2 = copy_value( Li1 );
    // remove each element from left side of Li2 and append to
    // the right side of Li3 (preserving order)
  
    Li3 = ({});

    while( sizeof( Li2 ) )
    {
	Li3 += Li2[..0];
	Li2 = Li2[1..];
    }
    // Li2 is now empty.
    // Remove each element from right side of Li3 and append to right
    // side of Li2
    while( sizeof( Li3 ) )
    {
	Li2 += Li3[sizeof( Li3 )-1..];
	Li3 = Li3[..sizeof( Li3 )-2];
    }
    // Li2 is now reversed, and Li3 empty.
    // Reverse Li1 in place.
    Li1 = reverse( Li1 );
    if( Li1[0] != SIZE )
	return 0;
    // compare Li1 and Li2 for equality, and return the length of the list.
    if( equal( Li1, Li2 ) )
	return sizeof( Li1 );
    return 0;
}

void main(int argc, array argv)
{
    int result, num = (int)argv[-1];
    if( num <=  0 )
	num = 1;
    while( num-- )
	result = test_lists();
    write("%d\n", result );
}
