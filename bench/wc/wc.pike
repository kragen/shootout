#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: wc.pike,v 1.1 2004-05-19 18:13:51 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from Per Hedbor, optimized by David Hedbor

enum State { Outside, Inside };

void main() {
    int nl = 0, nw = 0, nc = 0; // line, word and character counters
    int sl; // Size of input

    State state = Outside; // Inside or outside word

    string buf;
    string rest="";
    array l;
    do {
	buf = replace(Stdio.stdin.read( 4196 ), "\t", " ");
	if(strlen(buf)) {
	    nc += sizeof(buf);
	    l = (rest+ buf) / "\n";
	    nl += sizeof(l)-1;
	    foreach(l[..sizeof(l)-2], rest) {
		nw += sizeof(rest / " " - ({""}));
	    }
	    if(sizeof(l)>1) {
		rest = l[-1];
	    } //else rest="";
	} else {
	    nw += sizeof(rest / " " - ({""}));
	    break;
	}
    } while( 1 );
    write("%d %d %d\n", nl, nw, nc);
}
