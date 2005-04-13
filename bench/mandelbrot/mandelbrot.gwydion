module: mandelbrot
use-libraries: common-dylan, io
use-modules: common-dylan, standard-io, streams, format-out

begin
  let w = application-arguments()[0].string-to-integer;
  let h = w;
  let bit-num = 0;
  let byte-acc = 0;
  let limit2 = 4.0;
  let Zr = 0.0;
  let Zi = 0.0;
  let Cr = 0.0;
  let Ci = 0.0;
  let Tr = 0.0;
  let Ti = 0.0;
  let tmp = 0.0;
  
  format-out("P4\n%d %d\n",w,h);

  for (y :: <double-float> from 0.0d0 below h)
    for (x :: <double-float> from 0.0d0 below w)
      Zr := (Zi := 0.0);
      Cr := (2 * x / as(<double-float>,w) - 1.5);
      Ci := (2 * y / as(<double-float>,h) - 1);
      byte-acc := ash(byte-acc,1);
      bit-num := bit-num + 1;
      block (done)
        for (i from 0 below 50)
          Tr := Zr * Zr - Zi * Zi + Cr;
          Ti := 2 * Zr * Zi + Ci;
          Zr := Tr;
          Zi := Ti;
          tmp := Zr * Zr + Zi * Zi;
          if (tmp > limit2)
            done();
          end if;
        end for;
      end block;
      if (tmp < limit2)
        byte-acc := byte-acc + 1;
      end if;
      if (bit-num = 8)
        write-element(*standard-output*,as(<byte-character>,byte-acc));
        bit-num := (byte-acc := 0);
      elseif (x = w - 1)
        byte-acc := ash(byte-acc, (8 - modulo(w,8)));
        write-element(*standard-output*,as(<byte-character>,byte-acc));
        bit-num := (byte-acc := 0);
      end if;
    end for;
  end for;
end;
