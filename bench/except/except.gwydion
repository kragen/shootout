module:     except
synopsis:   implementation of "Exception Handling" benchmark
author:     Peter Hinely
copyright:  public domain


define variable hi :: <integer> = 0;
define variable lo  :: <integer> = 0;


define sealed domain make (subclass(<hi-exception>));
define sealed domain initialize (<hi-exception>);


define class <hi-exception> (<error>)
  slot number :: <integer>, required-init-keyword: number:; // not really used for anything
end;


define class <lo-exception> (<hi-exception>)
end;


define function some-function (num :: <integer>) => ()
  block ()
    hi-function(num);
  exception (err :: <error>)
    error("We shouldn't have got here.");
  end;
end function;


define function hi-function (num :: <integer>) => ()
  block ()
    lo-function(num);
  exception (err :: <hi-exception>)
    hi := hi + 1;
  end;
end function;


define function lo-function (num :: <integer>) => ()
  block ()
    blowup(num);
  exception (err :: <lo-exception>)
    lo := lo + 1;
  end;
end function;


define function blowup (num :: <integer>) => ()
  if (odd?(num))
    signal(make(<lo-exception>, number: num));
  else
    signal(make(<hi-exception>, number: num));
  end;
end function;


define function main () => ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  for (i from arg to 1 by -1)
    some-function(i);
  end;

  format-out("Exceptions: HI=%d / LO=%d\n", hi, lo);
end function;


main();