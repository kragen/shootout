module: takfp
use-libraries: common-dylan, io
use-modules: common-dylan, format-out

define function takn (n :: <integer>) => result :: <single-float>;
  local method tak(X :: <single-float>, Y :: <single-float>, Z :: <single-float>)
         => result :: <single-float>;
          if (y >= x)
            z;
          else
            tak (tak((x - 1.0s0), y, z),
                 tak((y - 1.0s0), z, x),
                 tak((z - 1.0s0), x, y));
          end if;
        end method tak;

  tak(3.0s0 * n, 2.0s0 * n, 1.0s0 * n);
end function takn;

begin
  let n = application-arguments()[0].string-to-integer;
  format-out("%.1f\n", takn(n));
end;

