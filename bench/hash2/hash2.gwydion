module:         hash2
synopsis:       implementation of "Hashes, Part II" benchmark
author:         Peter Hinely
copyright:      public domain
use-libraries:  common-dylan, table-extensions, format-out
use-modules:    common-dylan, table-extensions, format-out


define function main () => ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));

  let table1 = make(<case-insensitive-string-table>);
  let table2 = make(<case-insensitive-string-table>);

  for (i from 0 below 10000)
    table1[concatenate("foo_", integer-to-string(i))] := i;
  end;

  for (i from 0 below arg)
    for (value :: <integer> keyed-by key in table1)
      let found :: <integer> = element(table2, key, default: 0);
      table2[key] := found + value;
    end;
  end;

  format-out("%d %d %d %d\n", table1["foo_1"], table1["foo_9999"], table2["foo_1"], table2["foo_9999"]);
end function;


main();
