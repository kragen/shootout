#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: sumcol.pike,v 1.1 2004-05-19 18:13:44 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Fredrik Noring

void
main() {
    int sum = 0;
    while(string line = Stdio.stdin.gets())
	sum += (int)line;
    write("%d\n", sum);
}
