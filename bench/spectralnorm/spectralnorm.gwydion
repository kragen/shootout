module:    spectralnorm
synopsis:  implementation of "spectral-norm" benchmark
author:    Bruce Mitchener <bruce@cubik.org>
copyright: public domain
use-libraries:  common-dylan, dylan, io
use-modules:    common-dylan, transcendentals, format-out, extensions

limited-vector-class(<double-vector>, <double-float>, 0.0d0);

define function eval-A (i :: <integer>, j :: <integer>) => result :: <double-float>;
  1.0d0 / (truncate/((i + j) * (i + j + 1), 2) + i + 1);
end function eval-A;

define function eval-A-times-u (u :: <double-vector>, Au :: <double-vector>);
  for (i from 0 below u.size)
    Au[i] := 0.0d0;
    for (j from 0 below u.size)
      Au[i] := Au[i] + eval-A(i, j) * u[j];
    end for;
  end for;
end function eval-A-times-u;

define function eval-At-times-u (u :: <double-vector>, Au :: <double-vector>);
  for (i from 0 below u.size)
    Au[i] := 0.0d0;
    for (j from 0 below u.size)
      Au[i] := Au[i] + eval-A(j, i) * u[j];
    end for;
  end for;
end function eval-At-times-u;

define function eval-AtA-times-u (u :: <double-vector>, AtAu :: <double-vector>);
  let v = make(<double-vector>, size: u.size);
  eval-A-times-u(u, v);
  eval-At-times-u(v, AtAu);
end function eval-AtA-times-u;

begin
  let N = application-arguments()[0].string-to-integer;
  let u = make(<double-vector>, size: N, fill: 1.0d0);
  let v = make(<double-vector>, size: N, fill: 1.0d0);
  for (i from 0 below 10)
    eval-AtA-times-u(u, v);
    eval-AtA-times-u(v, u);
  end for;
  let vBv :: <double-float> = 0.0d0;
  let vv :: <double-float> = 0.0d0;
  for (i from 0 below N)
    let u-i = u[i];
    let v-i = v[i];
    vBv := vBv + u-i * v-i;
    vv := vv + v-i * v-i;
  end for;
  format-out("%0.9f\n", sqrt(vBv / vv));
end

