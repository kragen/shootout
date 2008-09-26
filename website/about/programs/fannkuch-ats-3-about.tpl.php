<p>Given an integer n, the type natLte(n) is defined as follows
in ATS:</p>

<pre>typedef natLte(n:int) = [i:nat | i &lt;= n] int(i)</pre>


<p>where int(i) is the type for the only integer of value i. In
plain words, natLte(n) is for natural numbers (a.k.a., nonnegative
integers) less than or equal to n. Note that the syntax <tt>[...]</tt>
is used for existential quantification.</p>

<p>The type iarr(n) is defined as follows:</p>

<pre>typedef iarr(n:int) = array(natLte n, n+1)</pre>

<p>In ATS, <tt>array(T, I)</tt> is a type for arrays of size I in which each
element is of type T. So <tt>iarr(n)</tt> is a type for arrays of size
<tt>n+1</tt> in which each element is of type <tt>natLte(n)</tt>, that is, each
element is a natural number less than or equal to n.</p>

<p>Now let us take a look at the following function definition:</p>

<pre>fn iarr_copy {n:nat}
  (A: iarr n, B: iarr n, n: int n): void = let
  var i: intGte 1 = 1 in while (i &lt;= n) (B[i] := A[i]; i := i+1)
end // end of [iarr_copy]</pre>

<p>The type assigned to <tt>iarr_copy</tt> is:</p>

<pre>{n:nat} (iarr n, iarr n, int n): void</pre>

<p>The syntax {...} is used for universal quantification. So the
type of iarr_copy states that for every natural number n, the
function takes two arrays of type iarr(n) and an integer whose
value equals n, and return nothing. In the body of the function,
we can see the code B[i] := A[i]; here, the ATS typechecker *must*
verify that i is within the bounds of A and B; this is easy as
the code B[i] := A[i] occurs after the test (i &lt;= n) succeeds.
Note that if i is replaced with i+1, then a type error appears
as it is impossible to prove that i+1 is within the bounds of
A and B (i.e., 0 &lt;= i+1 &lt; n+1) under the condition i &lt;=
n.</p>

<p>In this implementation of fannkuch, for each and every array
subscription, it is verified by the ATS typechecker at compile-time
that the subscript involved is within the bounds of the subscripted
array. Probably the most interesting case here is the function
perm_next; the type assigned to this function indicates that
the return value of this function is a natural number less than
or equal to n+1, where n is the value of the third argument of
the function.</p>
<p>A value returned by perm_next is later used to as an array
subscript.</p>
