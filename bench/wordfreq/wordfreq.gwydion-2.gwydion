module: wordfreq
use-libraries: common-dylan, io, table-extensions
use-modules: common-dylan, standard-io, streams, format-out, table-extensions

begin
  let words = make(<string-table>);
  while(~stream-at-end?(*standard-input*))
    do(method(x)
           unless(x = "")
	     x := as-lowercase(x);
             let count = element(words, x, default: 0);
             words[x] := count + 1;
           end unless;
       end method, split(read-line(*standard-input*), ' '));
  end while;
  let results = make(<stretchy-vector>);
  for(w keyed-by k in words)
    add!(results, pair(k, w));
  end for;
  do(method(x)
         format-out("%s %=\n", x.head, x.tail)
     end method, sort(results, test: method(x, y)
                                         if(x.tail == y.tail)
                                           x.head > y.head
                                         else
                                           x.tail > y.tail
                                         end if; 
                                     end method));
end;
