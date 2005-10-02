module:     matrix
synopsis:   implementation of "Matrix Multiplication" benchmark
author:     Peter Hinely
copyright:  public domain


define constant <vector-of-integers> = limited(<simple-vector>, of: <integer>);

define constant $empty-vector-of-integers = make(<vector-of-integers>);

define class <matrix> (<object>)
  constant slot rows :: <integer>, required-init-keyword: rows:;
  constant slot columns :: <integer>, required-init-keyword: columns:;
  slot elements :: <vector-of-integers>, init-value: $empty-vector-of-integers;
end class;

define sealed domain make (singleton(<matrix>));

define sealed method initialize (matrix :: <matrix>, #key rows :: <integer>, columns :: <integer>) => ()
  matrix.elements := make(<vector-of-integers>, size: (rows * columns), fill: 0);
end method;

define inline function ele (matrix :: <matrix>, row :: <integer>, column :: <integer>) => value :: <integer>;
  matrix.elements[(row * matrix.columns) + column];
end function;

define inline function ele-setter (new-value :: <integer>, matrix :: <matrix>, row :: <integer>, column :: <integer>) => new-value :: <integer>;
  matrix.elements[(row * matrix.columns) + column] := new-value;
end function;

define function create-matrix (rows :: <integer>, columns :: <integer>) => m :: <matrix>;
  let m = make(<matrix>, rows: rows, columns: columns);
  for (i from 0 below m.elements.size)
    m.elements[i] := i + 1;
  end for;
  m;
end function;

define sealed method \* (m1 :: <matrix>, m2 :: <matrix>) => m :: <matrix>;
  unless (m1.columns == m2.rows)
    error("the number of columns of %= must equals the number of rows of %m=", m1, m2);
  end;

  let rows = m1.rows;
  let columns = m2.columns;
  let m3 = make(<matrix>, rows: rows, columns: columns);

  for (i from 0 below rows)
    for (j from 0 below columns)
      let value = 0;
      for (k from 0 below columns)
        value := value + ele(m1, i, k) * ele(m2, k, j);
      end;
      ele(m3, i, j) := value;
    end for;
  end for;
  m3;
end method;

define function main () => ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  let size = 30;
  let m1 = create-matrix(size, size);
  let m2 = create-matrix(size, size);

  let mm = #f;
  for (i from 1 to arg)
    mm := m1 * m2;
  end;
  format-out("%= %= %= %=\n", ele(mm, 0, 0), ele(mm, 2, 3), ele(mm, 3, 2), ele(mm, 4, 4));
end function;

main();
