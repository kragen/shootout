module:    methcall
synopsis:  implemenation of "Method Calls" benchmark from http://shootout.alioth.debian.org
author:    Peter Hinely
copyright: public domain


define class <toggle> (<object>)
  slot value :: <boolean>, required-init-keyword: start-state:;
end;


define class <nth-toggle> (<toggle>)
  slot counter :: <integer> = 0;
  slot counter-maxiumum :: <integer>, required-init-keyword: counter-maxiumum:;
end;


define method activate (t :: <toggle>) => ();
  t.value := ~t.value;
end;


define method activate (t :: <nth-toggle>) => ();
  t.counter := t.counter + 1;
  if (t.counter >= t.counter-maxiumum)
    t.value := ~t.value;
    t.counter := 0;
  end;
end;


define function main ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  let val = #t;
  let toggle = make(<toggle>, start-state: val);
    
  for (i from 1 to arg)
    activate(toggle);
    val := toggle.value;
  end;

  format-out("%s\n", if (val) "true" else "false" end);
     
  val := #t;
  let nth-toggle = make(<nth-toggle>, start-state: val, counter-maxiumum: 3);
  
  for (i from 1 to arg)
    activate(nth-toggle);
    val := nth-toggle.value;
  end;

  format-out("%s\n", if (val) "true" else "false" end);
end function main;


begin
  main();
end

