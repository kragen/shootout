module:         wc
synopsis:       implementation of "Count Lines/Words/Chars" benchmark
author:         Peter Hinely
copyright:      public domain
use-libraries:  common-dylan, io
use-modules:    common-dylan, standard-io, streams, format-out

define function count () => ()
  let number-of-lines = 0;
  let number-of-words = 0;
  let number-of-characters = 0;
  let in-word = #f;
  
  let chunk-size = 4096;
  let buffer = make(<byte-string>, size: chunk-size);
  let bytes-read :: <integer> = 0;

  while ((bytes-read := read-into!(*standard-input*, chunk-size, buffer, on-end-of-stream: 0)) > 0)
    number-of-characters := number-of-characters + bytes-read;
    for (c keyed-by i in buffer, while: i < bytes-read)
      if (c == '\n')
        number-of-lines := number-of-lines + 1;
      end;
      select (c)
        ' ', '\n', '\t' => in-word := #f;
        otherwise       => if (~in-word)
                             number-of-words := number-of-words + 1;
                             in-word := #t;
                           end if;
      end select;
    end for;
  end while;
  
  format-out("%d %d %d\n", number-of-lines, number-of-words, number-of-characters);
end function;

count();
