<!--#set var="TITLE" value="List Processing" -->
<!--#set var="KEYWORDS" value="performance, benchmark, 
computer, language, compare, cpu, memory,
list processing" --> 

<?php require("../../html/testtop.php"); ?>

<h4>About this test</h4>
<p>
  For this test, each program should be implemented in the <a
  href="../../method.shtml#sameway"><i>same way</i></a>.
<p>
  This is a highly contrived test that exercises various <i>list</i>
  operations: pushing and popping from either end of a list, list
  reversal, list copying, and comparing lists for equality.  We are
  not testing list traversal unless it is implicitly implemented in
  those places where we allow builtin list functions.
<p>
  The test can use whichever sequence data structure is best suited
  for the problem (e.g. list, array, deque, or doubly-linked-list).
  It is preferred to use a native data structure, if possible, but a
  number of languages benefit from creating a custom data structure.
<p>
  Here's a description of how each test program works:
<ul>
<li>
  first create a list (L1) of integers from 1 through SIZE (SIZE is
  currently defined as 10000).
<li>
  copy L1 to L2 (can use any builtin list copy function, if available)
<li>
  remove each individual item from left side (head) of L2 and append to
  right side (tail) of L3 (preserving order).  (L2 should be emptied by
  one item at a time as that item is appended to L3).
<li>
  remove each individual item from right side (tail) of L3 and append
  to right side (tail) of L2 (reversing list).  (L3 should be emptied
  by one item at a time as that item is appended to L2).
<li>
  reverse L1 (preferably in place) (can use any builtin function for
  this, if available).
<li>
  check that first item of L1 is now == SIZE.
<li>
  and compare L1 and L2 for equality and return length of L1 (which
  should be equal to SIZE).
</ul>


<h4>Observations</h4>
<p>
  The following programs exceed the time limit (300 CPU seconds) and
  are disqualified:
  <a href="lists.mercury">Mercury</a>.
<p>
  The <a href="lists.se">SmallEiffel program</a> uses a custom
  DOUBLY_LINKED_LIST class implemented in this header file: <a
  href="../Include/doubly_linked_list.e">doubly_linked_list.e</a>.

<h4><a href="alt/">Alternates</a></h4>
<p>
  <i>This section is for displaying alternate solutions that are either
  slower than ones above or perhaps don't quite meet my criteria for
  the competition, but are otherwise worthy of comment.</i>
<ul>
<li>
  My original <a href="alt/lists.lua.tables">lua test</a>
  didn't perform well on this test at all because I was using the
  builtin associative arrays, since Lua does not provide a native
  array data type.
<li>
  Julian Assange contributed a very beautiful example in <a
  href="alt/lists.ghc2.ghc">Haskell</a>, which runs much faster than
  all the other contestants, however, it's not really doing the same
  work as all the others.
</ul>

<!--#include virtual="../../html/nav.shtml" -->
<!--#include virtual="../../html/footer.shtml" -->
