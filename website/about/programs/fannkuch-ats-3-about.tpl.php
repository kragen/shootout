<p>Given an integer <tt>n</tt>, the type <tt>natLte(n)</tt> is defined as follows
in ATS:</p>

<pre>typedef natLte(n:int) = [i:nat | i &lt;= n] int(i)</pre>


<p>where <tt>int(i)</tt> is the type for the only integer of value <tt>i</tt>. In
plain words, <tt>natLte(n)</tt> is for natural numbers (a.k.a., nonnegative
integers) less than or equal to n. Note that the syntax <tt>[...]</tt>
is used for existential quantification.</p>

<p>The type <tt>iarr(n)</tt> is defined as follows:</p>

<pre>typedef iarr(n:int) = array(natLte n, n+1)</pre>

<p>In ATS, <tt>array(T, I)</tt> is a type for arrays of size <tt>I</tt> in which each
element is of type <tt>T</tt>. So <tt>iarr(n)</tt> is a type for arrays of size
<tt>n+1</tt> in which each element is of type <tt>natLte(n)</tt>, that is, each
element is a natural number less than or equal to <tt>n</tt>.</p>

<p>Now let us take a look at the following function definition:</p>

<pre>fn iarr_copy {n:nat}
  (A: iarr n, B: iarr n, n: int n): void = let
  var i: intGte 1 = 1 in while (i &lt;= n) (B[i] := A[i]; i := i+1)
end // end of [iarr_copy]</pre>

<p>The type assigned to <tt>iarr_copy</tt> is:</p>

<pre>{n:nat} (iarr n, iarr n, int n): void</pre>

<p>The syntax <tt>{...}</tt> is used for universal quantification. So the
type of <tt>iarr_copy</tt> states that for every natural number <tt>n</tt>, the
function takes two arrays of type <tt>iarr(n)</tt> and an integer whose
value equals <tt>n</tt>, and return nothing. In the body of the function,
we can see the code <tt>B[i] := A[i];</tt> here, the ATS typechecker *must*
verify that <tt>i</tt> is within the bounds of <tt>A</tt> and <tt>B</tt>; this is easy as
the code <tt>B[i] := A[i]</tt> occurs after the test <tt>(i &lt;= n)</tt> succeeds.
Note that if <tt>i</tt> is replaced with <tt>i+1</tt>, then a type error appears
as it is impossible to prove that <tt>i+1</tt> is within the bounds of
<tt>A</tt> and <tt>B</tt> (i.e., <tt>0 &lt;= i+1 &lt; n+1</tt>) under the condition <tt>i &lt;=
n</tt>.</p>

<p>In this implementation of fannkuch, for each and every array
subscription, it is verified by the ATS typechecker at compile-time
that the subscript involved is within the bounds of the subscripted
array. Probably the most interesting case here is the function
<tt>perm_next</tt>; the type assigned to this function indicates that
the return value of this function is a natural number less than
or equal to <tt>n+1</tt>, where <tt>n</tt> is the value of the third argument of
the function.</p>
<p>A value returned by <tt>perm_next</tt> is later used to as an array
subscript.</p>
