module: ary

define constant <integer-vector> = limited(<vector>, of: <integer>);

define function main (arguments)
  let n = string-to-integer(element(arguments, 0, default: "1"));

  let x = make(<integer-vector>, size: n, fill: 0);
  let y = make(<integer-vector>, size: n, fill: 0);

  for (i from 0 below x.size)
    x[i] := i + 1;
  end for;
  
  for (k from 0 below 1000)
    for (i from n - 1 to 0 by -1)
      y[i] := y[i] + x[i];
    end for;
  end for;

  format-out("%d %d\n", y[0], y[y.size - 1]);
end function main;

main(application-arguments());