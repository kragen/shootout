/*
-- The Great Computer Language Shootout
-- http://shootout.alioth.debian.org/
--
-- contributed by Daniel Skiles
*/

#include <cstdlib>
#include <iostream>
#include <iomanip>

using namespace std;

int main(int argc, char *argv[])
{
    double n;
    double partialSum = 0;
    n = (argc == 2) ? atof(argv[1]) : 10000000;
    cout << setiosflags(ios::fixed) << setprecision(9);
    
    for(double i=1; i<=n; i++)
            partialSum += 1.0/i;
    cout << partialSum << endl;
    return EXIT_SUCCESS;
}

