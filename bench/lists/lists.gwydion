module:    list
synopsis:  implemenation of "List Processing" benchmark from http://shootout.alioth.debian.org
author:    Peter Hinely
copyright: public domain


define function test-lists (number-of-elements :: <integer>) => result :: <integer>;
  // first create a list (L1) of integers from 1 through SIZE.
  let L1 = map-as(<deque>, identity, range(from: 1, to: number-of-elements));

  // copy L1 to L2 (can use any builtin list copy function, if available)
  let L2 = shallow-copy(L1);

  // remove each individual item from left side (head) of L2 and append to right side (tail) of L3 (preserving order).
  // (L2 should be emptied by one item at a time as that item is appended to L3).
  let L3 = make(<deque>);
  until (empty?(L2))
    push-last(L3, pop(L2));
  end;

  // remove each individual item from right side (tail) of L3 and append to right side (tail) of L2 (reversing list).
  // (L3 should be emptied by one item at a time as that item is appended to L2).
  until (empty?(L3))
    push-last(L2, pop-last(L3));
  end;

  // reverse L1 (preferably in place) (can use any builtin function for this, if available).
  L1 := reverse!(L1);

  // check that first item of L1 is now == SIZE.
  unless (L1[0] = number-of-elements)
    error("Error: bad first element in L1. Exiting...\n");
  end;

  // and compare L1 and L2 for equality
  unless (L1 = L2)
    error("Error: the elements of L1 and L2 not equal. Exiting...\n");
  end;

  // and return length of L1 (which should be equal to SIZE).
  size(L1)
end function test-lists;


define function main ()
  let arg = string-to-integer(element(application-arguments(), 0, default: "1"));
  let result = #f;
  for (i from 1 to arg)
    result := test-lists(10000)
  end;
  format-out("%d\n", result);
end function main;


begin
  main();
end
