module:    matrix
synopsis:  implementation of "Matrix Multiplication" benchmark
author:    Peter Hinely
copyright: public domain

/*
A quick-and-dirty straight-forward port of the C version of the benchmark.
This port does not show off the full elegance of Dylan's standard idioms,
such as defining classes.

Dylan actually has a <matrix> class in its standard libraries, but it's 
general-purpose (i.e. not specialized for integers), and therefore slow.

I would have used limited <array> (a multi-dimensional array) for the matrices,
but there's no optimization for limited arrays yet in Gwydion Dylan.

In fact, I'm having trouble figuring out how to get the type inferencing to work 
properly with just limited's of vectors.  The inner loop
  value := value + m1[i][k] * m2[k][j];
is not being optimized, making the program run orders of magnitude slower than necessary.
*/


define constant <int-vector> = limited(<simple-vector>, of: <integer>);
define constant <matrix> = limited(<simple-vector>, of: <int-vector>);
define constant $dummy-int-vector = make(<int-vector>, size: 0);


define function make-matrix (rows :: <integer>, columns :: <integer>) => m :: <matrix>;
  let count = 1;
  let m :: <matrix> = make(<matrix>, size: rows, fill: $dummy-int-vector);
  for (i from 0 below rows)
    m[i] := make(<int-vector>, size: columns);
    for (j from 0 below columns)
      m[i][j] := count;
      count := count + 1;
    end for;
  end for;
  m;
end;


define function multiply-matrix (m1 :: <matrix>, m2 :: <matrix>) => m :: <matrix>;
  let rows = m1.size;
  let columns = m2[0].size;
  let m3 :: <matrix> = make-matrix(rows, columns);
  
  for (i from 0 below rows)
    for (j from 0 below columns)
      let value = 0;
      for (k from 0 below columns)
        value := value + m1[i][k] * m2[k][j];
      end;
      m3[i][j] := value;
    end for;
  end for;
  m3;
end;


begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  
  let size = 30;
  let m1 = make-matrix(size, size);
  let m2 = make-matrix(size, size);
  
  let mm = #f;
  for (i from 1 to arg)
    mm := multiply-matrix(m1, m2);
  end;
  
  format-out("%= %= %= %=\n", mm[0][0], mm[2][3], mm[3][2], mm[4][4]);
end
