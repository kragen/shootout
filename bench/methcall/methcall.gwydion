module:     methcall
synopsis:   implementation of "Method Calls" benchmark
author:     Peter Hinely
copyright:  public domain


define class <toggle> (<object>)
  slot value :: <boolean>, required-init-keyword: start-state:;
end class;


define class <nth-toggle> (<toggle>)
  slot counter :: <integer> = 0;
  slot counter-maxiumum :: <integer>, required-init-keyword: counter-maxiumum:;
end class;


define method activate (t :: <toggle>) => value :: <boolean>;
  t.value := ~t.value;
end method;


define method activate (t :: <nth-toggle>) => value :: <boolean>;
  t.counter := t.counter + 1;
  if (t.counter >= t.counter-maxiumum)
    t.value := ~t.value;
    t.counter := 0;
  end;
  t.value;
end method;


define function main ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  let val = #t;
  let toggle = make(<toggle>, start-state: val);
    
  for (i from 1 to arg)
    val := activate(toggle);
  end;

  format-out("%s\n", if (val) "true" else "false" end);
     
  val := #t;
  let nth-toggle = make(<nth-toggle>, start-state: val, counter-maxiumum: 3);
  
  for (i from 1 to arg)
    val := activate(nth-toggle);
  end;

  format-out("%s\n", if (val) "true" else "false" end);
end function main;


main();