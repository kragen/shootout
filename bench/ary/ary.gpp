// -*- mode: c++ -*-
// $Id: ary.gpp,v 1.2 2004-11-30 07:10:03 bfulgham Exp $
// http://shootout.alioth.debian.org/

#include <iostream>
#include <vector>

using namespace std;

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);
    typedef vector<int> ARY;
    ARY x(n);
    ARY y(n);

    for (int i=0; i<n; i++) {
	x[i] = i + 1;
    }
    for (int k=0; k<1000; k++) {
	for (int i = n - 1; i >= 0; --i) {
	    y[i] += x[i];
	}
    }

    cout << y[0] << " " << y.back() << endl;
}
