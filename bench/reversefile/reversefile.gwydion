module:         reversefile
synopsis:       implementation of "Reverse A File" benchmark
author:         Andreas Bogk
copyright:      public domain
use-libraries:  common-dylan, io
use-modules:    common-dylan, standard-io, streams

begin
  let lines = #();
  let line = #f;
  while (line := read-line(*standard-input*, on-end-of-stream: #f))
    lines := add!(lines, line); // utilize the fact that lists are automatically built reversed
  end while;
  do(curry(write-line, *standard-output*), lines);
end;