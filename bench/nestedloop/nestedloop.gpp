// -*- mode: c++ -*-
// $Id: nestedloop.gpp,v 1.1 2004-11-10 06:52:26 bfulgham Exp $
// http://shootout.alioth.debian.org/

#include <iostream>
#include <stdlib.h>

using namespace std;

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);
    int a, b, c, d, e, f, x=0;
	
    for (a=0; a<n; a++)
	for (b=0; b<n; b++)
	    for (c=0; c<n; c++)
		for (d=0; d<n; d++)
		    for (e=0; e<n; e++)
			for (f=0; f<n; f++)
			    x++;

    cout << x << endl;
    return(0);
}
