# $Id: matrix.gawk,v 1.1 2004-05-19 18:10:33 bfulgham Exp $
# http://www.bagley.org/~doug/shootout/

function mkmatrix(mx, rows, cols) {
    count = 1;
    for (i=0; i<rows; i++) {
	for (j=0; j<cols; j++) {
	    mx[i,j] = count++;
	}
    }
}

function mmult(rows, cols, m1, m2, m3) {
    for (i=0; i<rows; i++) {
	for (j=0; j<cols; j++) {
	    val = 0;
	    for (k=0; k<cols; k++) {
		val += m1[i,k] * m2[k,j];
	    }
	    m3[i,j] = val;
	}
    }
}


BEGIN {
    n = (ARGV[1] < 1) ? 1 : ARGV[1];
    size = 30;
    m1[0,0] = 0;
    m2[0,0] = 0;
    mkmatrix(m1, size, size);
    mkmatrix(m2, size, size);
    mm[0,0] = 0;
    for (i=0; i<n; i++) {
	mmult(size, size, m1, m2, mm);
    }
    printf("%d %d %d %d\n", mm[0,0], mm[2,3], mm[3,2], mm[4,4]);
    exit;
}
