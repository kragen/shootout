Module:    sieve
Author:    Eric Kidd <eric.kidd@pobox.com>
Copyright: Public Domain

define constant <int-vector> = limited(<simple-vector>, of: <integer>);

define function sieve(limit :: <integer>) => result :: <integer>;
  let vec :: <int-vector> = make(<int-vector>, size: limit + 1, fill: 1);

  // We know 1 isn't prime.
  vec[0] := 0;
  let prime-count = 0;

  // Sieve for the rest.
  for (i from 1 below limit)
    // We found a new prime!
    if (vec[i] ~= 0)
      prime-count := prime-count + 1;
      let prime = i + 1;
      // Eliminate our multiples.
      for (j from (i + prime) below limit by prime)
	vec[j] := 0;
      end for;
    end if;
  end for;

  // Print our findings.
  prime-count;
end function sieve;

begin
  let arg = application-arguments()[0].string-to-integer;
  let count = 0;
  for (num from 0 below arg)
      count := sieve(8192);
  end for;
  format-out("Count: %d\n", count);
end
