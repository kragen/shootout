module:    heapsort
synopsis:  implementation of "Heapsort" benchmark
author:    Peter Hinely
copyright: public domain


define constant $IM = 139968;
define constant $IA = 3877;
define constant $IC = 29573;


// utilize Dylan's cool closure functionality to keep the state of the "last" variable
define function random-generator (seed :: <integer>) => random-generator :: <method>;
  let last = seed;

  method (maximum :: <double-float>) => result :: <double-float>;
    last := modulo((last * $IA + $IC), $IM);
    maximum * last / $IM;
  end;
end;


define constant <vector-of-doubles> = limited(<simple-vector>, of: <double-float>);


define function heapsort (n :: <integer>, ra :: <vector-of-doubles>) => ()
  block (return)
    let i = 0;
    let ir = n;
    let j = 0;
    let l = ash(n, -1) + 1;
    let rra = 0.0;
    
    while (#t)
      if (l > 1)
        l := l - 1;
        rra := ra[l];
      else
        rra := ra[ir];
        ra[ir] := ra[1];
        ir := ir - 1;
        if (ir == 1)
          ra[1] := rra;
          return();
        end if;
      end if;
      i := l;
      j := ash(l, 1);
      while (j <= ir)
        if ((j < ir) & (ra[j] < ra[j + 1]))
          j := j + 1;
        end if;
        if (rra < ra[j])
          ra[i] := ra[j];
          i := j;
          j := j + i;
        else
          j := ir + 1;
        end if;
      end while;
      ra[i] := rra;
    end while;
  end block;
end function heapsort;


define function main ()
  let N = string-to-integer(element(application-arguments(), 0, default: "2"));

  let array = make(<vector-of-doubles>, size: N + 1);
  let generate-random = random-generator(42);

  for (i from 1 to N)
    array[i] := generate-random(1.0d0);
  end;

  heapsort(N, array);

  // this is truly horrid.  Sorry.
  let (int, frac) = truncate(array[N]);
  format-out("%d.", int);
  for (i from 1 below 10)
    let (int, frac2) = truncate(frac * 10);
    frac := frac2;
    format-out("%d", int);
  end;
  format-out("%d\n", round(frac * 10));
end function main;


main();
