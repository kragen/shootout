module: harmonic

begin
  for (n from application-arguments()[0].string-to-integer above 0 by -1,
       i from 1.0 by 1.0,
       sum = 0.0 then sum + 1.0 / i)
  finally format-out("%.9f\n", sum);
  end for;
end;
