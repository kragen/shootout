#!/usr/bin/pike
// -*- mode: pike -*-
// $Id: matrix.pike,v 1.1 2004-05-19 18:10:34 bfulgham Exp $
// http://www.bagley.org/~doug/shootout/
// from: Per Hedbor

int size = 30;

array(array(int))
mkmatrix(int rows, int cols) {
    array(array(int)) m = allocate(rows);
    int count = 1;
    for (int i=0; i<rows; i++) {
	array(int) row = allocate(cols);
	for (int j=0; j<cols; j++) {
	    row[j] = count++;
	}
	m[i] = row;
    }
    return(m);
}

void
main(int argc, array(string) argv) {
    int n = (int)argv[-1];
    if (n < 1)
      n = 1;
    
    Math.Matrix m1 = Math.Matrix(mkmatrix(size, size));
    Math.Matrix m2 = Math.Matrix(mkmatrix(size, size));
    Math.Matrix mm;
    for( int i = n; i>0; i-- )
      mm = m1 * m2;
    array q = (array(array(int)))(array)mm;
    write( "%d %d %d %d\n", q[0][0], q[2][3], q[3][2], q[4][4] );
}
