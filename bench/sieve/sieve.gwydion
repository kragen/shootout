module:    sieve
synopsis:  implementation of "Sieve of Eratosthenes" benchmark
author:    Eric Kidd <eric.kidd@pobox.com>
copyright: public domain


define constant <int-vector> = limited(<simple-vector>, of: <integer>);

define function sieve (limit :: <integer>) => result :: <integer>;
  let flags = make(<int-vector>, size: limit + 1, fill: 1);

  // We know 1 isn't prime.
  flags[0] := 0;
  flags[1] := 0;
  let count = 0;

  // Sieve for the rest.
  for (i from 2 to limit)
    unless (flags[i] == 0)
      for (k from (i * 2) to limit by i)
        flags[k] := 0;
      end for;
      count := count + 1;
    end unless;
  end for;

  // Return our findings.
  count;
end function sieve;


begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  let prime-count = 0;
  for (num from 1 to arg)
    prime-count := sieve(8192);
  end for;
  format-out("Count: %d\n", prime-count);
end