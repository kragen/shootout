// $Id: takfp.gpp,v 1.3 2004-12-10 08:09:21 bfulgham Exp $
// http://shootout.alioth.debian.org
// Contributed by Brent Fulgham

#include <stdlib.h>
#include <iomanip>
#include <iostream>

using namespace std;

float Tak (float x, float y, float z)
{
	if (y >= x) return z;
	return Tak(Tak(x-1,y,z), Tak(y-1,z,x), Tak(z-1,x,y));
}

int main(int argc, char* argv[])
{
	int n = ((argc == 2) ? atoi(argv[1]) : 1);
	cout << std::fixed << std::setprecision(1);
	cout << Tak(n*3.0, n*2.0, n*1.0) << endl;
	return 0;
}

// vim: ts=4 ft=c
