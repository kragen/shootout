module: ackermann

begin
  local method ackermann (M :: <integer>, N :: <integer>)
          case
            M = 0     => N + 1;
            N = 0     => ackermann(M - 1, 1);
            otherwise => ackermann(M - 1, ackermann(M, N - 1));
          end;
        end;

  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  format-out("Ack(3,%d): %d\n", arg, ackermann(3, arg));
end;