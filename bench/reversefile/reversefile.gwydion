module: reversefile
use-libraries: common-dylan, io
use-modules: common-dylan, standard-io, streams

begin
  let lines = make(<stretchy-vector>);
  while(~stream-at-end?(*standard-input*))
    add!(lines, read-line(*standard-input*));
  end while;
  do(curry(write-line, *standard-output*), reverse!(lines));
end;
