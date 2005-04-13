module: harmonic

begin
  let n = application-arguments()[0].string-to-integer;
  let partial-sum :: <double-float> = 0.0d0;
  let i :: <double-float> = 1.0d0;
  while (i < n)
    partial-sum := partial-sum + 1.0d0 / i;
    i := i + 1.0d0;
  end while;
  format-out("%.9f\n",partial-sum);
end;
