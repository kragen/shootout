<p>Each program should</p> 
<ul>
<li>"Take a permutation of {1,...,n}, for example: {4,2,1,5,3}.</li>
<li>Take the first element, here 4, and reverse the order of the first 4 elements: {5,1,2,4,3}.</li>
<li>Repeat this until the first element is a 1, so flipping won't change anything more: {3,4,2,1,5}, {2,4,3,1,5}, {4,2,3,1,5}, {1,3,2,4,5}.</li>
<li>Count the number of flips, here 5.</li>
<li>Do this for all n! permutations, and record the maximum number of flips needed for any permutation.</li>
<li>Write the first 30 permutations and the number of flips.</li>
</ul>
<p>The conjecture is that this maximum count is approximated by n*log(n) when n goes to infinity.</p><p><i>FANNKUCH</i> is an abbreviation for the German word <i>Pfannkuchen</i>, or pancakes, in analogy to flipping pancakes."</p>
<br />


<p>Correct output N = 7 is:</p>
<pre>1234567
2134567
2314567
3214567
3124567
1324567
2341567
3241567
3421567
4321567
4231567
2431567
3412567
4312567
4132567
1432567
1342567
3142567
4123567
1423567
1243567
2143567
2413567
4213567
2345167
3245167
3425167
4325167
4235167
2435167
Pfannkuchen(7) = 16
</pre><br />

<p>The fannkuch benchmark is defined in <a href="http://www.apl.jhu.edu/~hall/text/Papers/Lisp-Benchmarking-and-Fannkuch.ps">Performing Lisp Analysis of the FANNKUCH Benchmark</a>, Kenneth R. Anderson and Duane Rettig (26KB postscript)</p>