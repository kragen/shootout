module: sumcol
use-libraries: common-dylan, io
use-modules: common-dylan, standard-io, streams, format-out

begin
  let sum :: <integer> = 0;
  while(~stream-at-end?(*standard-input*))
    sum := sum + string-to-integer(read-line(*standard-input*));
  end while;
  format-out("%=\n", sum);
end;
