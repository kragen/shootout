#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: ary.pike,v 1.1 2004-05-19 18:09:16 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Martin Nilsson

void main(int argc, array(string) argv)
{
  int n = (int)argv[-1];
  if (n < 1) n = 1;

  array(int) x = allocate(n);
  array(int) y = allocate(n);

  for (int i; i<n; i++) {
    x[i] = i;
  }
  for (int i=n-1; i>=0; i--) {
    y[i] = x[i];
  }
  write("%d\n", y[-1]);
}
