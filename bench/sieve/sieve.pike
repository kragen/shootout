#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: sieve.pike,v 1.1 2004-05-19 18:12:27 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Per Hedbor

void main(int argc, array(string) argv)
{
    array(int) flags;
    int i, k, count, num;
  
    num = (int)argv[-1];
    if (num < 1)
	num = 1;
      
    while (num--) {
	count = 0;
	flags = ({ 1 })*8193;
	for (i=2; i <= 8192; i++) {
	    if (flags[i]) {
		for (k=i+i; k <= 8192; k+=i)
		    flags[k] = 0;
		count++;
	    }
	}
    }
    write("Count: %d\n", count);
}
