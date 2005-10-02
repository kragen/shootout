module:     randum
synopsis:   implementation of "Random Number Generator" benchmark
author:     Andreas Bogk
copyright:  public domain


define constant $IM = 139968;
define constant $IA = 3877;
define constant $IC = 29573;
define variable $LAST :: <integer> = 42;

define method generate-random (max :: <double-float>) => (m :: <double-float>);
  $LAST := modulo($LAST * $IA + $IC, $IM);
  max * $LAST / $IM;
end method;

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1")) - 1;

  for (i from 1 to arg)
    generate-random(100.0d0);
  end;

  format-out("%.9f\n", generate-random(100.0d0));
end;
