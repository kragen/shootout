<p>The <a href="http://en.wikipedia.org/wiki/Craps" title="Craps defined on Wikipedia"><b>Completely Random and Arbitrary Point System!&#8482;</b></a> works as follows:</p>
<ul>
<li>For each benchmark, the "best score" is determined by locating the lowest non-zero score.  (This is done for CPU, Memory, and LOC scores.)</li>

<li><p>For each language, compute its score in logarithmic space:</p>
<pre>score = 1 / (1 + log2(x / b))
   where
   x = current benchmark's score
   b = best score for this benchmark
</pre>
<br />

<p>This yields a non-zero value from 0 to 1, which 1 being the "best score".</p>
<p>Each such score is then multiplied by the weight of the benchmark (a number between 0 and 5), yielding the language's
score for that benchmark.  If a language does not have an entry for a test its score is zero.  (Again we do the same for Memory and LOC).</p></li>

<li>Then the CPU/Memory/LOC scores are multiplied by their respective Mulipliers and the resulting scores are added together to the get final score.</li>
<li>Add up all the scores for each language for each benchmark, and put them on this nice web page.</li>
<li>And the result is <a href="http://en.wikipedia.org/wiki/Craps" title="Craps defined on Wikipedia"><b>CRAPS!&#8482;</b></a></li>
</ul>



