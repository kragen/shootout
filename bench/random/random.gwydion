module: randum

define constant $IM :: <integer> = 139968;
define constant $IA :: <integer> = 3877;
define constant $IC :: <integer> = 29573;
define variable $LAST :: <integer> = 42;

define method gen-random( max :: <float> )
  => <float>;
  $LAST := modulo($LAST * $IA + $IC, $IM);
  max * $LAST / $IM;
end method gen-random;
  
begin
  let arg = application-arguments()[0].string-to-integer - 1;

  while (arg > 0)
    arg := arg - 1;
    gen-random(100.0);
  end while;

  format-out("%d\n", gen-random(100.0));
end;

