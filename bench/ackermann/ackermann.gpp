// -*- mode: c++ -*-
// $Id: ackermann.gpp,v 1.1 2004-11-07 22:41:41 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/

#include <iostream>
#include <stdlib.h>

using namespace std;

int Ack(int M, int N) { return(M ? (Ack(M-1,N ? Ack(M,(N-1)) : 1)) : N+1); }

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);

    cout << "Ack(3," << n << "): " << Ack(3, n) << endl;
    return(0);
}
