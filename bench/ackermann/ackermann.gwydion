module: ackermann

begin
  local method ackerman(M :: <integer>, N :: <integer>)
          case
            M = 0     => N + 1;
            N = 0     => ackerman(M - 1, 1);
            otherwise => ackerman(M - 1, ackerman(M, N - 1));
          end;
        end;

  let arg = application-arguments()[0].string-to-integer;
  format-out("Ack(3,%d): %d\n", arg, ackerman(3, arg));
end;

