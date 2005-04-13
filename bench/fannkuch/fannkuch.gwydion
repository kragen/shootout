module: fannkuch

define constant <int-vector> = limited(<vector>, of: <integer>);

define function fannkuch (n :: <integer>)
 => result :: <integer>;
  let perm :: <int-vector> = make(<int-vector>,size: n,fill: 0);
  let perm1 = make(<int-vector>,size: n,fill: 0);
  let max-perm = make(<int-vector>,size: n,fill: 0);
  let count = make(<int-vector>,size: n,fill: 0);
  let max-flip-count :: <integer> = 0;
  let m :: <integer> = n - 1;
  let r :: <integer> = n;

  for (i from 0 below n)
    perm1[i] := i;
  end for;

  block(return)
    while (#t)
      while (r ~= 1)
        count[r - 1] := r;
        r := r - 1;
      end while;

      if (~ (perm1[0] = 0 | perm1[m] = m))
        for (i from 0 below n)
          perm[i] := perm1[i];
        end for;
        let flip-count :: <integer> = 0;
        while (perm[0] ~= 0)
          let k :: <integer> = perm[0];
          let k2 = (k + 1) / 2.0;
          for(i from 0 below k2)
            let tmp = perm[i];
            perm[i] := perm[k - i];
            perm[k - i] := tmp;
          end for;
          flip-count := flip-count + 1;
        end while;

        if (flip-count > max-flip-count)
          max-flip-count := flip-count;
          for (i from 0 below n)
            max-perm[i] := perm1[i];
          end for;
        end if;
      end if;

      block(break)
        while(#t)
          if (r = n)
            return(max-flip-count);
          end if;
          let perm0 :: <integer> = perm1[0];
          let i :: <integer> = 0;
          while (i < r)
            let j = i + 1;
            perm1[i] := perm1[j];
            i := j;
          end while;
          perm1[r] := perm0;
          count[r] := count[r] - 1;
          if (count[r] > 0)
            break();
          end if;
          r := r + 1;
        end while;
      end block;

    end while;
  end block;
end function fannkuch;

begin
  let arg = application-arguments()[0].string-to-integer;
  format-out("Pfannkuchen(%=) = %d\n", arg, fannkuch(arg));
end;
