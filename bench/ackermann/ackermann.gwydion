module: ackermann

define function ackermann(M :: <integer>, N :: <integer>)
 => result :: <integer>;
  case 
    M = 0     => N + 1;
    N = 0     => ackermann(M - 1, 1);
    otherwise => ackermann (M - 1, ackermann(M, N - 1));
  end case;
end function ackermann;

begin
  let arg = application-arguments()[0].string-to-integer;
  format-out("Ack(3,%d): %d\n", arg, ackermann(3, arg));
end;

