module: strcat

begin
  let s = make(<stretchy-vector>);
  for(i from 0 below string-to-integer(application-arguments()[0]))
    do(curry(add!, s), "hello\n");
  end for;
  format-out("%=\n", s.size);
end;