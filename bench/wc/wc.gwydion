module:         wc
synopsis:       implementation of "Count Lines/Words/Chars" benchmark
author:         Peter Hinely
copyright:      public domain
use-libraries:  common-dylan, io, string-extensions
use-modules:    common-dylan, standard-io, streams, character-type, format-out


define function count () => ()
  let number-of-lines = 0;
  let number-of-words = 0;
  let number-of-characters = 0;
  let in-word = #f;
  let chunk-size = 4096;
  
  block (break)
    while (#t)
      let buffer =  block ()
                      read(*standard-input*, chunk-size);
                    exception (err :: <incomplete-read-error>)
                      err.incomplete-read-sequence;
                    exception (err :: <end-of-stream-error>)
                      break();
                    end block;

      for (c in buffer)
        number-of-characters := number-of-characters + 1;
        if (c == '\n')
          number-of-lines := number-of-lines + 1;
        end;
        if (whitespace?(c))
           in-word := #f;
        elseif (~in-word)
          number-of-words := number-of-words + 1;
          in-word := #t;
        end if;
      end for;
    end while;
  end block;
  
  format-out("%d %d %d\n", number-of-lines, number-of-words, number-of-characters);
end function;


count();