// -*- mode: c++ -*-
// $Id: wc.gpp,v 1.1 2004-11-10 06:42:03 bfulgham Exp $
// http://shootout.alioth.debian.org/
// with help from Tom Widmer

#include <iostream>
#include <vector>

using namespace std;

enum {
    OUT,			/* outside a word */
    IN				/* inside a word */
};

int
main(int argc, char *argv[]) {
    char c;
    int nl, nw, nc, state;
    char buff[4096];
    cin.rdbuf()->pubsetbuf(buff, 4096); // enable buffering

    state = OUT;
    nl = nw = nc = 0;
    int intc;
    streambuf* sbuf = cin.rdbuf();
    while ((intc = sbuf->sbumpc()) != EOF) {
        c = (char)intc;
	++nc;
	if (c == '\n')
	    ++nl;
	if (c == ' ' || c == '\n' || c == '\t')
	    state = OUT;
	else if (state == OUT) {
	    state = IN;
	    ++nw;
	}
    }
    cout << nl << " " << nw << " " << nc << endl;
}
