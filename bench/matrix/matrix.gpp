// -*- mode: c++ -*-
// $Id: matrix.gpp,v 1.2 2004-11-30 07:10:04 bfulgham Exp $
// http://shootout.alioth.debian.org/

#include <iostream>
#include <stdlib.h>

using namespace std;

#define SIZE 30
typedef int* int_ptr;

int **mkmatrix(int rows, int cols) {
    int j, count = 1;
    int **m = new int_ptr [rows];
    for (int i=0; i<rows; i++) {
	m[i] = new int[ cols ];
	for (j=0; j<cols; j++) {
	    m[i][j] = count++;
	}
    }
    return(m);
}

void zeromatrix(int rows, int cols, int **m) {
    int i, j;
    for (i=0; i<rows; i++)
	for (j=0; j<cols; j++)
	    m[i][j] = 0;
}

void freematrix(int rows, int **m) {
    while (--rows > -1) { delete[] m[rows]; }
    delete[] m;
}

int **mmult(int rows, int cols, int **m1, int **m2, int **m3) {
    int j,k,val;
    for (int i=0; i<rows; i++) {
	for (j=0; j<cols; j++) {
	    val = 0;
	    for (k=0; k<cols; k++) {
		val += m1[i][k] * m2[k][j];
	    }
	    m3[i][j] = val;
	}
    }
    return(m3);
}

int main(int argc, char *argv[]) {
    int n = ((argc == 2) ? atoi(argv[1]) : 1);
	
    int **m1 = mkmatrix(SIZE, SIZE);
    int **m2 = mkmatrix(SIZE, SIZE);
    int **mm = mkmatrix(SIZE, SIZE);

    for (int i=0; i<n; i++) {
	mm = mmult(SIZE, SIZE, m1, m2, mm);
    }
    cout << mm[0][0] << " " << mm[2][3] << " " << mm[3][2] << " " << mm[4][4] << endl;

    freematrix(SIZE, m1);
    freematrix(SIZE, m2);
    freematrix(SIZE, mm);
    return(0);
}
