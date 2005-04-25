module: fibo

define function fibo(M :: <integer>)
 => result :: <integer>;
  case 
    M < 2     => 1;
    otherwise => fibo (M - 2) + fibo (M - 1);
  end case;
end function fibo;

begin
  let arg = application-arguments()[0].string-to-integer;
  format-out("%d\n", fibo(arg));
end;

