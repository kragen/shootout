#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: nestedloop.pike,v 1.1 2004-05-19 18:10:57 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

void main(int argc, array(string) argv) {
  int n = (int)argv[-1];
  if (n < 1) n = 1;
  int x=0;

  for (int a; a<n; a++)
      for (int b; b<n; b++)
	  for (int c; c<n; c++)
	      for (int d; d<n; d++)
		  for (int e; e<n; e++)
		      for (int f; f<n; f++)
			  x++;

  write("%d\n", x);
}
