module: k-nucleotide
use-libraries: common-dylan, io
use-modules: common-dylan, standard-io, streams, format-out

define sealed class <key-value-pair> (<object>)
    constant slot key :: <byte-string>, required-init-keyword: key:;
    slot val :: <integer>, required-init-keyword: value:;
end class <key-value-pair>;

define sealed inline method make (class == <key-value-pair>,
                                  #rest all-keys, #key)
 => (res)
    next-method();
end method make;

define function kfrequency
    (sequence :: <byte-string>,
     freq :: <string-table>,
     k :: <integer>,
     frame :: <integer>)
  let n :: <integer> = size(sequence) - k + 1;
  for (i :: <integer> from frame below n by k)
    let sub :: <byte-string> = copy-sequence(sequence, start: i, end: i + k);
    let record :: false-or(<key-value-pair>) = element(freq, sub, default: #f);
    if (record)
      let tmp :: <key-value-pair> = record;
      tmp.val := tmp.val + 1;
    else
      freq[sub] := make(<key-value-pair>, key: sub, value: 1);
    end if;
  end for;
end function kfrequency;

/// Yuck! limited(<vector>) broken in d2c, and needed for performance!
//define constant <kv-vector> = limited(<vector>, of: <key-value-pair>);
define constant <kv-vector> = <simple-object-vector>;
define constant $null-kv = make(<key-value-pair>, key: "", value: 0);

define function frequency(sequence :: <byte-string>, k :: <integer>)
  let freq :: <string-table> = make(<string-table>);
  for (i from 0 below k)
    kfrequency(sequence, freq, k, i);
  end for;
  let sorted :: <kv-vector> = 
    make(<kv-vector>, size: size(freq), fill: $null-kv);
  let sum :: <double-float> = 0.0d0;
  for (tmp :: <key-value-pair> in freq,
       i from 0 below size(freq))
    sorted[i] := tmp;
    sum := sum + as(<double-float>, tmp.val);
  end for;
  sorted := sort(sorted,
                 test: method (a :: <key-value-pair>,
                               b :: <key-value-pair>) b.val < a.val end);
  for (i :: <key-value-pair> in sorted)
    let percent :: <double-float> = as(<double-float>, i.val) * 100.0d0 / sum;
    format-out("%s %.2f\n", i.key, percent);
  end for;
  format-out("\n");
end function frequency;

define function count (sequence :: <byte-string>, fragment :: <byte-string>)
  let freq :: <string-table> = make(<string-table>);
  let k = size(fragment);
  for (i from 0 below k)
    kfrequency(sequence, freq, k, i);
  end for;
  let record :: false-or(<key-value-pair>) =
    element(freq, fragment, default: #f);
  if (record)
    let tmp :: <key-value-pair> = record;
    format-out("%d\t%s\n", tmp.val, fragment);
  else
    format-out("0\t%s\n", fragment);
  end if;
end function count;

define function main ()
  let line :: false-or(<byte-string>) =
    read-line(*standard-input*, on-end-of-stream: #f);
  let needed-part :: <boolean> = #f;
  let still-reading :: <boolean> = #t;
  let sequence :: <byte-string> = "";
  while(line & still-reading)
    if (copy-sequence(line,start: 0, end: 6) = ">THREE")
      needed-part := #t;
      line := read-line(*standard-input*, on-end-of-stream: #f);
    end if;
    if (needed-part & line)
      if (line[0] = '>')
        still-reading := #f;
      elseif (line[0] ~= ';')
        sequence := concatenate(sequence, line);
      end if;
    end if;
    line := read-line(*standard-input*, on-end-of-stream: #f);
  end while;

  sequence := as-uppercase(sequence);
  
  frequency(sequence, 1);
  frequency(sequence, 2);

  count(sequence, "GGT");
  count(sequence, "GGTA");
  count(sequence, "GGTATT");
  count(sequence, "GGTATTTTAATT");
  count(sequence, "GGTATTTTAATTTATAGT");
end function main;

begin
  main();
end;
