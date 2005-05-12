#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: sumcol.pike,v 1.2 2005-05-12 06:21:24 igouy-guest Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring  

void
main() {
   int sum = 0;
   while(string line = Stdio.stdin.gets())
      sum += (int)line;
   write("%d\n", sum);
}
