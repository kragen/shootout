<p>Each program should 
<ul>
<li>"Take a permutation of {1,...,n}, for example: {4,2,1,5,3}.</li>
<li>Take the first element, here 4, and reverse the order of the first 4 elements: {5,1,2,4,3}.</li>
<li>Repeat this until the first element is a 1, so flipping won't change anything more: {3,4,2,1,5}, {2,4,3,1,5}, {4,2,3,1,5}, {1,3,2,4,5}.</li>
<li>Count the number of flips, here 5.</li>
<li>Do this for all n! permutations, and record the maximum number of flips needed for any permutation.</li>
</ul>
The conjecture is that this maximum count is approximated by n*log(n) when n goes to infinity.</p><p><i>FANNKUCH</i> is an abbreviation for the German word <i>Pfannkuchen</i>, or pancakes, in analogy to flipping pancakes."
</p><br/>

<p>Please use the Oberon-2 program as an example of how to implement this benchmark. There are better algorithms; we're interested in this particular algorithm.</p>

<p>Correct output N = 7 is:
<pre>Pfannkuchen(7) = 16
</pre></p><br/>
<p>Correct output N = 8 is:
<pre>Pfannkuchen(8) = 22
</pre></p><br/>

<p>The fannkuch benchmark is defined in <a href="http://www.apl.jhu.edu/~hall/text/Papers/Lisp-Benchmarking-and-Fannkuch.ps">Performing Lisp Analysis of the FANNKUCH Benchmark</a>, Kenneth R. Anderson and Duane Rettig (26KB postscript)</p>